module test;

import lunea;

class SmallBox : Process {
	real timer = 0;
	this(real timer = 0) {
		this.timer = timer;
	}
	void init() {
		this.x = 120;
	}
	void main() {
		while (true) {
			this.x = 120 * cos(timer);
			this.y = 120 * sin(timer);
			checkCollision();
			frame();
			timer = (timer + 0.02) % (PI * 2);
		}
	}
	void draw() {
		//Stdout.format("{}\n", position).newline;
		Drawing.color(0, 0, 1);
		Drawing.quad(Rectangle(-10, -10, 20, 20));
	}
	void checkCollision() {
		if (auto that = collisionWith(drawing.parent.type)) {
			this.kill();
			//that.kill();
			//Stdout("Collide").newline;
		}
	}
	Rectangle boundingBox() {
		return Rectangle(-10, -10, 20, 20);
	}
}

class BigBox : Process {
	SmallBox[] rotators;

	this(real x = 0, real y = 240) {
		this.x = x;
		this.y = y;
	}
	void init( ){
		for (int n = 0; n < 6; n++) {
			auto rotator = new SmallBox(PI / 3 * n);
			rotator.drawing.parent = this;
			//this.drawing += rotator;
			rotators ~= rotators;
		}
		//rotator.drawing.parent = this;
	}
	void main() {
		action(&right);
	}
	void left() {
		while (true) {
			x -= 5.0;
			if (x <= 0) action(&right);
			frame;
		}
	}
	void right() {
		while (true) {
			x += 5.0;
			if (x >= 640) action(&left);
			frame;
		}
	}
	void draw() {
		//Stdout.format("{}\n", position).newline;
		Drawing.color(1, 0, 0);
		Drawing.quad(Rectangle(-50, -50, 100, 100));
	}
	Rectangle boundingBox() {
		return Rectangle(-50, -50, 100, 100);
	}
}

class Camera : Process {
	void main() {
		while (true) {
			//x++;
			frame();
		}
	}
}

/*static bool collide(Process l, Process r) {
}*/

void main() {
	//new Viewport(Rectangle(100, 100, 440, 280));
	auto viewport = new Viewport();
	auto camera = new Camera();
	with (new BigBox(0, 240)) {
		drawing.parent = camera;
	}
	with (new BigBox(640, 240)) {
		drawing.parent = camera;
	}
	
	ProcessManager.singleton.mainLoop();
}