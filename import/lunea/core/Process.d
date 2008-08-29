module lunea.core.Process;

public import tango.core.Thread;
public import tango.math.Math;
public import tango.io.Stdout;

debug = DebugProcess;

interface IDrawable {
	void draw(real x = 0, real y = 0, real z = 0);
}

abstract class Process {
	static Process lastProcess;
	static Process currentProcess;
	alias void delegate() Action;

	Fiber fiber;
	int priority;
	real x = 0, y = 0, z = 0;
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
		if (parent == this) return _parentExecute = null;
		parent.childsDraw[this] = true;
		return _parentDraw = parent;
	}
	Process[] getChildsDraw() {
		return childsDraw.keys;
	}
	
	private Action _action;
	Action action() { return _action; }
	Action action(Action _action, bool doFrame = true) {
		auto b = fiber;
		fiber = new Fiber(this._action = _action);
		if (b && currentProcess is this && doFrame) frame();
		return _action;
	}
	
	real screenX() { return parentDraw ? (x + parentDraw.x) : x; }
	real screenY() { return parentDraw ? (y + parentDraw.y) : y; }
	real screenZ() { return parentDraw ? (z + parentDraw.z) : z; }
	
	this() {
		debug (DebugProcess) Stdout.formatln("Process.this();");
		action(&main, false);
		
		parentExecute = currentProcess.parentExecute ? currentProcess.parentExecute : currentProcess;
		parentDraw = currentProcess.parentDraw ? currentProcess.parentDraw : currentProcess;
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
		if (fiber.state == Fiber.State.TERM) return false;
		if (!doExecute) return true;

		currentProcess = this;
		
		try { fiber.call(); } catch (Exception e) { Stdout.formatln("Process Execution Exception (executeProcess): {}", e); }

		if (childsExecute.length) {
			lastProcess = this;
		
			try { executeBefore(); } catch (Exception e) { Stdout.formatln("Process Execution Exception (executeBefore): {}", e); }
			foreach (child; getChildsExecute) {
				child.execute();
				if (child.fiber.state == Fiber.State.TERM) child.dispose();
			}
			try { executeAfter(); }catch (Exception e) { Stdout.formatln("Process Execution Exception (executeAfter): {}", e); }
		}
		
		return true;
	}

	alias fiber.yield frame;
	
	void drawBefore () { }
	void drawAfter  () { }
	void drawProcess() {
		debug (DebugProcess) Stdout.formatln("Process({}, {}, {})", screenX, screenY, screenZ);
		if (graph) graph.draw(screenX, screenY, screenZ);
	}
	
	void draw() {
		if (!doDraw) return;
		
		try { drawProcess(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawProcess) : {}", e); }
		
		if (childsDraw.length) {
			try { drawBefore(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawBefore) : {}", e); }
			foreach (child; getChildsDraw) child.draw();
			try { drawAfter(); } catch (Exception e) { Stdout.formatln("Process Drawing Exception (drawAfter) : {}", e); }
		}
	}
	
	abstract void main();	
}
