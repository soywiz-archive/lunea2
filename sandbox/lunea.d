module lunea;

//debug = showProcessList;

public import
	tango.io.Stdout,
	tango.core.Thread,
	tango.core.Memory,
	tango.math.Math,
	tango.text.convert.Format,
	tango.time.Time,
	tango.time.Clock,
	tango.sys.Environment
;

public import 
	derelict.sdl.sdl,
	derelict.opengl.gl
;

public import
	tango.sys.win32.UserGdi,
	tango.sys.win32.Types
;

alias char[] string;

struct Rectangle {
	int x, y, w, h;
	alias w width;
	alias h height;
	int x1() { return x; }
	int y1() { return y; }
	int x2() { return x + w; }
	int y2() { return y + h; }
	string toString() { return Format.convert("Rectangle({},{},{},{})", x, y, w, h); }
	static bool intersects(Rectangle r1, Rectangle r2) {
		return (r1.x1 <= r2.x2) && (r1.x2 >= r2.x1) && (r1.y1 <= r2.y2) && (r1.y2 >= r2.y1);
	}
}

struct Position {
	real x = 0.0, y = 0.0, z = 0.0;
	string toString() { return Format.convert("Position({},{},{})", x, y, z); }
	Position opAdd(Position that) {
		Position p = void;
		p.x = this.x + that.x;
		p.y = this.y + that.y;
		p.z = this.z + that.z;
		return p;
	}
}

static class Drawing {
	static void quad(Rectangle rect) {
		glBegin(GL_QUADS);
			glVertex2i(rect.x1, rect.y1);
			glVertex2i(rect.x2, rect.y1);
			glVertex2i(rect.x2, rect.y2);
			glVertex2i(rect.x1, rect.y2);
		glEnd();
	}
	static void color(real r, real g, real b, real a = 1.0) {
		glColor4f(r, g, b, a);
	}
}

class Process {
	static bool[Process] list;
	static bool[Process][string] listByType;

	enum Status { ACTIVE, INACTIVE, DELETED }

	abstract class Category {
		Status status;
		Process process;
		Process __parent;
		bool[Process] __childs;
		Process[] childs() { return __childs.keys; }
		
		this(Process process) {
			this.process = process;
		}
		
		Process parent() { return __parent; }
		Process parent(Process __parent) {
			if (this.__parent !is null) category(this.__parent) -= this.process;
			if (__parent !is null) category(__parent) += this.process;
			return __parent;
		}
		Process parentOrCurrent() { return __parent ? __parent : process; }
		
		private Process opAddAssign(Process child) {
			__childs[child] = true;
			category(child).__parent = this.process;
			return child;
		}

		private Process opSubAssign(Process child) {
			__childs.remove(child);
			return child;
		}

		void die() {
			//foreach (child; childs) category(child).parent = __parent;
			parent = null;
		}

		void print(int level = 0) {
			for (int n = 0; n < level; n++) Stdout("  ");
			Stdout.format("- {}", process).newline;
			foreach (childProcess; category(process).childs) {
				category(childProcess).print(level + 1);
			}
		}

		abstract Category category(Process process);
	}

	class CategoryExecuting : Category { Category category(Process process) { return process.executing; } this(Process process) { super(process); } }
	class CategoryDrawing   : Category { Category category(Process process) { return process.drawing;   } this(Process process) { super(process); } }

	static class StopFiberException : Exception { this() { super("StopFiberException"); } }

	template ActionStuff() {
		alias void delegate() Action;
		alias __fiber.yield frame;

		Fiber  __fiber;
		Action __action;
		Action action() { return __action; }
		Action action(Action __action) {
			auto closingFiber = __fiber;
			this.__action = __action;

			__fiber = new Fiber(this.__action);
			
			if (closingFiber && (Fiber.getThis is closingFiber)) {
				throw(new StopFiberException());
				//assert(0);
				//frame;
				//throw(null);
			}

			//assert(0);
			return __action;
		}
	}

	template DrawStuff() {
		alias void delegate() Draw;
		CategoryDrawing drawing;

		// Draw.
		void draw() {
			//Stdout.format("{}", this).newline;
		}

		bool drawChildrenCalled;
		void drawChildren() {
			if (drawChildrenCalled) return;
			drawChildrenCalled = true;
			foreach (child; drawing.childs) child.__draw();
		}

		void __draw() {
			if (drawing.status != Status.ACTIVE) return;

			drawChildrenCalled = false;
			glMatrixMode(GL_MODELVIEW); glPushMatrix();
			{
				glTranslatef(x, y, z);
				glScalef(size, size, 1.0);
				glRotatef(0, 0, 1, angle);
				glMatrixMode(GL_MODELVIEW); glPushMatrix();
				{
					draw();
				}
				glMatrixMode(GL_MODELVIEW); glPopMatrix();
			}
			if (!drawChildrenCalled) {
				drawChildren();
			}
			glMatrixMode(GL_MODELVIEW); glPopMatrix();
		}
	}
	
	template ExecuteStuff() {
		// Parents for drawing and executing.
		CategoryExecuting executing;

		// Entrypoint.
		void main() { while (true) frame(); }

		void __execute() {
			if (executing.status != Status.ACTIVE) return;
			if (__fiber.state == Fiber.State.TERM) return;
			__lastExecutingProcess = this;
			__lastDrawingProcess = drawing.parentOrCurrent;
			try {
				__fiber.call();
			} catch (StopFiberException e) {
				// none
			} catch (Exception e) {
				Stdout.format("Exception in Process.__execute: {}", e).newline;
			}
			foreach (child; executing.childs) child.__execute();
		}
	}
	
	mixin ActionStuff;
	mixin DrawStuff;
	mixin ExecuteStuff;

	union {
		struct { real x = 0.0, y = 0.0, z = 0.0; }
		Position position;
	}

	Position positionGlobal() {
		Position position = this.position;
		if (drawing.parent) {
			position = position + drawing.parent.position;
		}
		return position;
	}

	real angle = 0.0;
	real size  = 1.0;
	real alpha = 1.0;

	static Process __lastExecutingProcess, __lastDrawingProcess;

	this() {
		this.action    = &main; // This sets fiber.
		this.drawing   = new CategoryDrawing(this);
		this.executing = new CategoryExecuting(this);

		if (__lastExecutingProcess !is null) this.executing.parent = __lastExecutingProcess.executing.parentOrCurrent;
		if (__lastDrawingProcess !is null) this.drawing.parent = __lastDrawingProcess;
		
		list[this] = true;
		listByType[type][this] = true;

		init();
	}

	string type() { return Object.toString; }

	void init() {
	}

	void kill() {
		executing.status = Status.DELETED;
		drawing.status   = Status.DELETED;
	}

	string toString() {
		return Format.convert("{}({})", Object.toString, position);
	}

	Process[] collisionWithList(string ctype) {
		Process[] r;
		if (ctype in listByType) {
			foreach (process; listByType[ctype].keys) {
				if (process is this) continue;
				if (process.executing.status != Status.ACTIVE) continue;
				//Stdout.format("{}", process.toString).newline;
				if (collision(process, this)) r ~= process;
			}
		}
		return r;
	}
	Process collisionWith(string ctype) {
		auto r = collisionWithList(ctype);
		return (r.length > 0) ? r[0] : null;
	}

	Rectangle boundingBox() {
		return Rectangle(0, 0, 0, 0);
	}

	Rectangle boundingBoxGlobal() {
		Rectangle r = boundingBox();
		Position  p = positionGlobal;
		r.x += p.x;
		r.y += p.y;
		return r;
	}
}

class ProcessManager : Process {
	static ProcessManager singleton;

	Time frameStartTime;
	/// 0 == no frame limited
	int fps = 60;
	bool running = true;

	private this() {
		singleton = this;
		__lastExecutingProcess = null;
		__lastDrawingProcess = null;
		super();
		__lastExecutingProcess = this;
		__lastDrawingProcess = this;
	}

	static this() {
		DerelictSDL.load();
		DerelictGL.load();
		new ProcessManager;
	}

	void init() {
		Environment.set("SDL_VIDEO_WINDOW_POS");
		Environment.set("SDL_VIDEO_CENTERED", "1");

		SDL_Init(0);
		SDL_InitSubSystem(SDL_INIT_VIDEO);
		SDL_SetVideoMode(640, 480, 0, SDL_OPENGL | SDL_DOUBLEBUF);

		SDL_Cursor *cursor = SDL_GetCursor();
		//cursor.wm_cursor.curs = cast(void *)LoadCursor(null, IDC_ARROW);
		SDL_SetCursor(cursor);
	}

	void draw() {
	}

	void processEvents() {
		SDL_Event event;
		while (SDL_PollEvent(&event)) {
			switch (event.type) {
				case SDL_QUIT:
					running = false;
				break;
				default:
				break;
			}
		}
		//SDL_PumpEvents();
	}

	void mainLoop() {
		void frameBegin() {
			frameStartTime = Clock.now;

			//glClearColor(0.8, 0.8, 0.9, 1.0);
			glClearColor(0, 0, 0, 1);
			glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

			//GC.disable();

			/*
			glViewport(0, 0, 640, 480);
			glMatrixMode(GL_PROJECTION); glLoadIdentity(); glOrtho(0, 640, 480, 0, -1.0, 1.0);
			glMatrixMode(GL_MODELVIEW); glLoadIdentity();
			*/
		}
		
		void frameEnd() {
			SDL_GL_SwapBuffers();
			processEvents();
			Thread.sleep(0);
			//GC.enable();
			GC.collect();
			//GC.minimize();
			if (fps > 0) {
				int frameMillis = 1000 / fps;
				while ((Clock.now - frameStartTime).millis < frameMillis) {
					processEvents();
					Thread.sleep(0.01);
				} 
			}
		}

		while (running) {
			frameBegin();
			{
				//Stdout("Executing...").newline;
				__execute();
				//Stdout("Drawing...").newline;
				__draw();
			}
			cleanUp();
			frameEnd();
			debug (showProcessList) ProcessManager.singleton.drawing.print();
		}
	}

	void cleanUp() {
		foreach (process; Process.list.keys.dup) {
			if (process.executing.status != Process.Status.ACTIVE) process.executing.die();
			if (process.drawing.status   != Process.Status.ACTIVE) process.drawing.die();
			if (process.executing.status != Process.Status.ACTIVE && process.drawing.status   != Process.Status.ACTIVE) {
				Process.list.remove(process);
				if (process.type in Process.listByType) Process.listByType[process.type].remove(process);
			}
		}
		//Stdout(Process.list.length).newline;
	}
}

static bool collision(Process l, Process r) {
	return Rectangle.intersects(l.boundingBoxGlobal, r.boundingBoxGlobal);
}

class Viewport : Process {
	static Viewport current, lastSet;
	Rectangle rect;

	this(Rectangle rect) {
		this.rect = rect;
		__lastDrawingProcess = this;
	}

	this() {
		this(maxRect());
	}

	static Rectangle maxRect() {
		GLint w = 640, h = 480;
		//glGetIntegerv(GL_MAX_VIEWPORT_DIMS, &w);
		return Rectangle(0, 0, w, h);
	}

	static Rectangle currentViewport() {
		GLint x, y, w, h;
		glGetIntegerv(GL_VIEWPORT, &x);
		return Rectangle(x, y, w, h);
	}

	static protected void setViewport(Rectangle rect) {
		glViewport(rect.x, rect.y, rect.width, rect.height);
		glMatrixMode(GL_PROJECTION); glLoadIdentity(); glOrtho(0, rect.w, rect.h, 0, -1.0, 1.0);
		glMatrixMode(GL_MODELVIEW); glLoadIdentity();
		//Stdout.format("setViewport({})", rect).newline;
	}

	void invalidate() {
		lastSet = null;
	}

	void set() {
		//if (lastSet is this) return;
		lastSet = this;
		setViewport(rect);
	}

	void draw() {
		// Changes the viewport only if viewport has childs.
		if (!drawing.childs.length) return;

		auto viewPortLast    = this.current;
		auto viewPortCurrent = this;

		{
			// Sets the current viewport.
			if (viewPortCurrent) viewPortCurrent.set();
			glMatrixMode(GL_MODELVIEW); glLoadIdentity();
			{
				// Sets the current viewport as this.
				current = this;
				// Draw all the children.
				drawChildren();
			}
			// Restores the previous viewport.
			if (viewPortLast) viewPortLast.set();
		}
	}
	
	string toString() {
		return Format.convert("{}({})", Object.toString, rect);
	}
	
	/*void main() {
		while (true) {
			x++;
			frame();
		}
	}*/
}

/*class Camera : Process {
}

class Camera2D : Camera {
	void draw() {
		glOrtho(0, Screen.width, Screen.height, 0, -1.0, 1.0 );
	}
}*/
