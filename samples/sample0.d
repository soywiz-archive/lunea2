import lunea.core.Process;

class MainProcess : Process {
	this() {
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

class Test : Process {
	int n, max;
	
	this(int max) {
		this.max = max;
	}
	
	void drawProcess() { Stdout.formatln("{}", n); }
	
	void main() {
		action = &left;
	}
	
	void left() {
		while (true) {
			n--;
			if (n <= -max) action = &right;
			frame();
		}
	}

	void right() {
		while (true) {
			n++;
			if (n >= +max) action = &left;
			frame();
		}
	}
}

real distance(Process a, Process b) {
	return hypot(a.x - b.x, a.y - b.y); 
}

bool collide(Process a, Process b) {
	return false;
}

void main() {
	auto p = new MainProcess();
	new Test(100);
	//new Test(2000);
	
	while (true) {
		if (!p.execute()) break;
		p.draw();
	}
}