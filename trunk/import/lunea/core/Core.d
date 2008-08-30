module lunea.core.Core;

public import lunea.core.Process;
public import tango.core.Memory;

class ProcessManager : Process {
	static ProcessManager singleton;

	this() {
		singleton = this;
		debug (DebugProcess) Stdout.formatln("MainProcess.this();");
		currentProcess = this;
		super();
	}

	bool execute() {
		Process.lastProcess = this;
		Process.currentProcess = this;	
		return Process.execute();
	}
	
	override void drawProcess()  { }
	
	void main() { while (true) frame(); }
}

bool requestExit = false;

void exit() {
	requestExit = true;
}

template ProgramMain() {
	void main() {
		alias ProcessManager.singleton p;

		new ProcessManager;
		new Program;
		
		while (true) {
			//Stdout.formatln("frame");
			
			if (!p.execute()) break;
			if (requestExit) break;

			p.draw();
			
			//GC.collect();
			
			try {
				Driver.frame();
			} catch (ExceptionExitRequest e) {
				break;
			} catch (Exception e) {
				Stdout.formatln("Exception (Display.update): {}", e);
			}
		}
	}
}