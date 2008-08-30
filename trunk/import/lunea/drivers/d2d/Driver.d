module lunea.drivers.d2d.Driver;

public import lunea.drivers.d2d.media.SDL;
public import lunea.drivers.d2d.Display;

public import tango.sys.Environment;

static this() {
	Environment.set("SDL_VIDEO_WINDOW_POS", "center");
	Environment.set("SDL_VIDEO_CENTERED", "1");
	SDL_Init(0);
}

class Keyboard {
	static bool pressed[SDLK_LAST];
	
	static bool opIndex(int i) {
		return pressed[i];
	}
}

class Mouse {
	static int x, y;
	static int[5] b;
	static int wheel;
	
	static void warp(int x, int y) {
		SDL_WarpMouse(x, y);
	}
	
	static void update() {
		SDL_GetMouseState(&Mouse.x, &Mouse.y);
	}
}

class Driver {
	static void frame() {
		SDL_Event event;

		while (SDL_PollEvent(&event)) {
			switch (event.type) {
				case SDL_KEYDOWN: case SDL_KEYUP:
					bool bset = (event.type == SDL_KEYDOWN);
					int idx = event.key.keysym.sym;
				
					Keyboard.pressed[idx] = bset;
				break;
				case SDL_MOUSEBUTTONDOWN: case SDL_MOUSEBUTTONUP:
					bool bset = (event.type == SDL_MOUSEBUTTONDOWN);
					int idx;

					switch (event.button.button) {
						case SDL_BUTTON_LEFT:      idx = 0; break;
						case SDL_BUTTON_RIGHT:     idx = 1; break;
						default:
						case SDL_BUTTON_MIDDLE:    idx = 2; break;
						case SDL_BUTTON_WHEELUP:   idx = 3; break;
						case SDL_BUTTON_WHEELDOWN: idx = 4; break;
					}

					if (event.type == SDL_MOUSEBUTTONDOWN) {
						if (event.button.button == SDL_BUTTON_WHEELUP) {
							Mouse.wheel++;
						} else if (event.button.button == SDL_BUTTON_WHEELDOWN) {
							Mouse.wheel--;
						}
					}

					Mouse.b[idx] = bset;
				break;
				case SDL_QUIT:
					throw(new ExceptionExitRequest);
				break;
				default:
				break;
			}
		}
		
		Mouse.update();
		
		SDL_GL_SwapBuffers();
	}
}