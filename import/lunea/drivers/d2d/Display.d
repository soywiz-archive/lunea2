module lunea.drivers.d2d.Display;

public import lunea.core.Process;
public import lunea.drivers.d2d.media.SDL;

class Display {
	static SDL_Surface *screen;
	
	static void set(int width = 640, int height = 480, bool fullscreen = false) {
		screen = SDL_SetVideoMode(640, 480, 0, SDL_OPENGL | (fullscreen * SDL_FULLSCREEN));
	}
}