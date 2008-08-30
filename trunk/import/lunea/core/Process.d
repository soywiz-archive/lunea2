module lunea.core.Process;

public import tango.core.Thread;
public import tango.math.Math;
public import tango.io.Stdout;

interface IDrawable {
	void draw(Process p);
}

class ExceptionExitRequest : Exception {
	this() { super(""); }
}

abstract class Process {
	static Process lastProcess;
	static Process currentProcess;
	alias void delegate() Action;

	Fiber fiber;
	int priority;
	real x = 0, y = 0, z = 0;
	real angle = 0, size = 1;
	IDrawable graph;
	bool doExecute = true;
	bool doDraw = true;
	private Process _parentExecute;
	private Process _parentDraw;
	
	bool[Process] childsExecute;
	Process parentExecute() { return _parentExecute; }
	Process parentExecute(Process parent) {
		if (_parentExecute) _parentExecute.childsExecute.remove(this);
		if (parent == this) return _parentExecute = null;
		parent.childsExecute[this] = true;
		return _parentExecute = parent;
	}
	Process[] getChildsExecute() {
		return childsExecute.keys;
	}

	bool[Process] childsDraw;
	Process parentDraw() { return _parentDraw; }
	Process parentDraw(Process parent) {
		if (_parentDraw) _parentDraw.childsDraw.remove(this);
		if (parent == this) return _parentDraw = null;
		parent.childsDraw[this] = true;
		return _parentDraw = parent;
	}
	Process[] getChildsDraw() {
		return childsDraw.keys;
	}
	
	private Action _action;
	Action action() { return _action; }
	Action action(Action _action) {
		auto b = fiber;
		fiber = new Fiber(this._action = _action, 32 * 1024);
		
		if (b && (Fiber.getThis is b)) frame;
		return _action;
	}
	
	real screenX() { return parentDraw ? (x + parentDraw.x) : x; }
	real screenY() { return parentDraw ? (y + parentDraw.y) : y; }
	real screenZ() { return parentDraw ? (z + parentDraw.z) : z; }
	
	this(Process _parentExecute = null, Process _parentDraw = null) {
		debug (DebugProcess) Stdout.formatln("Process.this();");
		action = &main;
		
		parentExecute = _parentExecute ? _parentExecute : (currentProcess.parentExecute ? currentProcess.parentExecute : currentProcess);
		parentDraw = _parentDraw ? _parentDraw : (currentProcess.parentDraw ? currentProcess.parentDraw : currentProcess);
	}
	
	void dispose() {
		if (parentExecute) parentExecute.childsExecute.remove(this);
		if (parentDraw) parentDraw.childsDraw.remove(this);
		foreach (child; childsExecute.keys) child.dispose();
		foreach (child; childsDraw.keys) child.dispose();
	}
	
	void executeBefore() { }
	void executeAfter () { }

	bool execute() {
		//Stdout.formatln("execute");
		
		if (fiber.state == Fiber.State.TERM) return false;
		if (!doExecute) return true;

		currentProcess = this;
		
		try { fiber.call(); } catch (Exception e) { Stdout.formatln("Process Execution Exception (executeProcess): {}:{}", this, e); }

		if (childsExecute.length) {
			lastProcess = this;
		
			try { executeBefore(); } catch (Exception e) { Stdout.formatln("Process Execution Exception (executeBefore): {}:{}", this, e); }
			foreach (child; getChildsExecute) {
				if (this != child) child.execute();
				if (child.fiber.state == Fiber.State.TERM) child.dispose();
			}
			try { executeAfter(); }catch (Exception e) { Stdout.formatln("Process Execution Exception (executeAfter): {}:{}", this, e); }
		}
		
		return true;
	}

	alias fiber.yield frame;
	
	void drawBefore () { }
	void drawAfter  () { }
	void drawProcess() {
		debug (DebugProcess) Stdout.formatln("Process({}, {}, {})", screenX, screenY, screenZ);
		if (graph) graph.draw(this);
	}
	
	void draw() {
		if (!doDraw) return;
		
		try { drawProcess(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawProcess) : {}:{}", this, e); }
		
		if (childsDraw.length) {
			try { drawBefore(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawBefore) : {}:{}", this, e); }
			foreach (child; getChildsDraw) child.draw();
			try { drawAfter(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawAfter) : {}:{}", this, e); }
		}
	}
	
	abstract void main();	
}
