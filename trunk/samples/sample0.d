debug = DebugProcess;

import lunea.core.Core;
import lunea.drivers.d2d.Driver;

mixin ProgramMain;

class Bullet : Process {
	void main() {
		x = 100;
		while (true) {
			x--;
			if (x <= 0) break;
			frame;
		}
	}

	void drawProcess() {
		Stdout.formatln("{}", x);
	}
}

class Program : Process {
	void main() {
		Stdout.formatln("Program");
		Display.set();
		new Test(1000);
		while (true) {
			if (Keyboard[SDLK_ESCAPE]) exit();
			if (Keyboard[SDLK_LEFT]) new Bullet();
			frame;
		}
	}
	
	void drawProcess() {
		Stdout.formatln("{}, {}, {}", Mouse.x, Mouse.y, Mouse.b);
	}
}

class Test : Process {
	int n, max;
	
	this(int max) {
		this.max = max;
	}
	
	void drawProcess() { Stdout.formatln("{}", n); }
	
	void main() {
		Stdout.formatln("test.main");
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
