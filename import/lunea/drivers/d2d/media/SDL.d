module lunea.drivers.d2d.media.SDL;

extern (C):

// Aliases
alias ubyte  Uint8;
alias byte   Sint8;
alias ushort Uint16;
alias short  Sint16;
alias uint   Uint32;
alias int    Sint32;
alias ulong  Uint64;
alias long   Sint64;

alias int    CDstatus;

alias void*  HWND2;
alias uint   UINT2;
alias uint   WPARAM2;
alias uint   LPARAM2;

alias int    SDLKey;
alias int    SDLMod;
alias int    SDL_bool;
alias int    SDL_errorcode;
alias int    SDL_eventaction;
alias int    SDL_audiostatus;
alias int    SDL_GLattr;
alias void*  SDL_TimerID;
alias int    SDL_GrabMode;

// Opaque structures
struct SDL_Thread { }
struct SDL_mutex { }
struct SDL_sem { }
struct SDL_cond { }

// Transparent simple structures
struct SDL_keysym { Uint8 scancode; SDLKey sym; SDLMod mod; Uint16 unicode; }
struct SDL_ActiveEvent { Uint8 type; Uint8 gain; Uint8 state; }
struct SDL_KeyboardEvent { Uint8 type; Uint8 which; Uint8 state; SDL_keysym keysym; }
struct SDL_MouseMotionEvent { Uint8 type; Uint8 which; Uint8 state; Uint16 x, y; Sint16 xrel; Sint16 yrel; }
struct SDL_MouseButtonEvent { Uint8 type; Uint8 which; Uint8 button; Uint8 state; Uint16 x, y; }
struct SDL_JoyAxisEvent { Uint8 type; Uint8 which; Uint8 axis; Sint16 value; }
struct SDL_JoyBallEvent { Uint8 type; Uint8 which; Uint8 ball; Sint16 xrel; Sint16 yrel; }
struct SDL_JoyHatEvent { Uint8 type; Uint8 which; Uint8 hat; Uint8 value; }
struct SDL_JoyButtonEvent { Uint8 type; Uint8 which; Uint8 button; Uint8 state; }
struct SDL_ResizeEvent { Uint8 type; int w; int h; }
struct SDL_ExposeEvent { Uint8 type; }
struct SDL_QuitEvent { Uint8 type; }
struct SDL_UserEvent { Uint8 type; int code; void *data1; void *data2; }
struct SDL_SysWMEvent { Uint8 type; SDL_SysWMmsg *msg; }
struct SDL_CDtrack { Uint8 id; Uint8 type; Uint16 unused; Uint32 length; Uint32 offset; }

// Enums
enum { SDL_FALSE, SDL_TRUE }
enum { SDL_RELEASED, SDL_PRESSED };
enum { SDL_APPMOUSEFOCUS = 0x01, SDL_APPINPUTFOCUS = 0x02, SDL_APPACTIVE = 0x04 }

enum {
	SDL_INIT_TIMER       = 0x00000001,
	SDL_INIT_AUDIO       = 0x00000010,
	SDL_INIT_VIDEO       = 0x00000020,
	SDL_INIT_CDROM       = 0x00000100,
	SDL_INIT_JOYSTICK    = 0x00000200,
	SDL_INIT_NOPARACHUTE = 0x00100000,
	SDL_INIT_EVENTTHREAD = 0x01000000,
	SDL_INIT_EVERYTHING  = 0x0000FFFF,
}

struct SDL_AudioSpec {
	int freq;
	Uint16 format;
	Uint8  channels;
	Uint8  silence;
	Uint16 samples;
	Uint16 padding;
	Uint32 size;

	void (*callback)(void *userdata, Uint8 *stream, int len);
	void  *userdata;
}

const uint AUDIO_U8	= 0x0008;
const uint AUDIO_S8	= 0x8008;
const uint AUDIO_U16LSB	= 0x0010;
const uint AUDIO_S16LSB	= 0x8010;
const uint AUDIO_U16MSB	= 0x1010;
const uint AUDIO_S16MSB	= 0x9010;
const uint AUDIO_U16	= AUDIO_U16LSB;
const uint AUDIO_S16	= AUDIO_S16LSB;
const uint AUDIO_U16SYS	= AUDIO_U16MSB;
const uint AUDIO_S16SYS	= AUDIO_S16MSB;

struct SDL_AudioCVT {
	int needed;
	Uint16 src_format;
	Uint16 dst_format;
	double rate_incr;
	Uint8 *buf;
	int    len;
	int    len_cvt;
	int    len_mult;
	double len_ratio;
	void (*filters[10])(SDL_AudioCVT *cvt, Uint16 format);
	int filter_index;
}

enum { SDL_AUDIO_STOPPED, SDL_AUDIO_PLAYING, SDL_AUDIO_PAUSED }

const uint SDL_MIX_MAXVOLUME = 128;

const uint SDL_LIL_ENDIAN  = 1234;
const uint SDL_BIG_ENDIAN  = 4321;
const uint SDL_BYTEORDER   = SDL_LIL_ENDIAN;
const int  SDL_MAX_TRACKS  = 99;
const uint SDL_AUDIO_TRACK = 0x00;
const uint SDL_DATA_TRACK  = 0x04;

enum { CD_TRAYEMPTY, CD_STOPPED, CD_PLAYING, CD_PAUSED, CD_ERROR = -1 }

bool CD_INDRIVE(int status) { return status > 0; }

struct SDL_CD {
	int id;
	CDstatus status;
	int numtracks;
	int cur_track;
	int cur_frame;
	SDL_CDtrack track[SDL_MAX_TRACKS+1];
}

const uint CD_FPS	= 75;
void FRAMES_TO_MSF(int f, out int M, out int S, out int F) {
	int value = f;
	F = value % CD_FPS;
	value /= CD_FPS;
	S = value % 60;
	value /= 60;
	M = value;
}

int MSF_TO_FRAMES(int M, int S, int F) { return M * 60 * CD_FPS + S * CD_FPS + F; }

enum { SDL_ENOMEM, SDL_EFREAD, SDL_EFWRITE, SDL_EFSEEK, SDL_LASTERROR }

enum {
	SDL_NOEVENT = 0, SDL_ACTIVEEVENT, SDL_KEYDOWN, SDL_KEYUP, SDL_MOUSEMOTION, SDL_MOUSEBUTTONDOWN,
	SDL_MOUSEBUTTONUP, SDL_JOYAXISMOTION, SDL_JOYBALLMOTION, SDL_JOYHATMOTION, SDL_JOYBUTTONDOWN,
	SDL_JOYBUTTONUP, SDL_QUIT, SDL_SYSWMEVENT, SDL_EVENT_RESERVEDA, SDL_EVENT_RESERVEDB,
	SDL_VIDEORESIZE, SDL_VIDEOEXPOSE, SDL_EVENT_RESERVED2, SDL_EVENT_RESERVED3, SDL_EVENT_RESERVED4,
	SDL_EVENT_RESERVED5, SDL_EVENT_RESERVED6, SDL_EVENT_RESERVED7, SDL_USEREVENT = 24, SDL_NUMEVENTS = 32
}

uint SDL_EVENTMASK(uint X) { return 1 << (X); }

enum {
	SDL_ACTIVEEVENTMASK	= 1 << SDL_ACTIVEEVENT,
	SDL_KEYDOWNMASK		= 1 << SDL_KEYDOWN,
	SDL_KEYUPMASK		= 1 << SDL_KEYUP,
	SDL_MOUSEMOTIONMASK	= 1 << SDL_MOUSEMOTION,
	SDL_MOUSEBUTTONDOWNMASK	= 1 << SDL_MOUSEBUTTONDOWN,
	SDL_MOUSEBUTTONUPMASK	= 1 << SDL_MOUSEBUTTONUP,
	SDL_MOUSEEVENTMASK	= (1 << SDL_MOUSEMOTION) | (1 << SDL_MOUSEBUTTONDOWN)| (1 << SDL_MOUSEBUTTONUP),
	SDL_JOYAXISMOTIONMASK	= (1 << SDL_JOYAXISMOTION),
	SDL_JOYBALLMOTIONMASK	= (1 << SDL_JOYBALLMOTION),
	SDL_JOYHATMOTIONMASK	= (1 << SDL_JOYHATMOTION),
	SDL_JOYBUTTONDOWNMASK	= (1 << SDL_JOYBUTTONDOWN),
	SDL_JOYBUTTONUPMASK	= 1 << SDL_JOYBUTTONUP,
	SDL_JOYEVENTMASK	= (1 << SDL_JOYAXISMOTION)| (1 << SDL_JOYBALLMOTION)| (1 << SDL_JOYHATMOTION)| (1 << SDL_JOYBUTTONDOWN)| (1 << SDL_JOYBUTTONUP),
	SDL_VIDEORESIZEMASK	= 1 << SDL_VIDEORESIZE,
	SDL_VIDEOEXPOSEMASK	= 1 << SDL_VIDEOEXPOSE,
	SDL_QUITMASK		= 1 << SDL_QUIT,
	SDL_SYSWMEVENTMASK	= 1 << SDL_SYSWMEVENT
}

const uint SDL_ALLEVENTS	= 0xFFFFFFFF;

enum { SDL_ADDEVENT, SDL_PEEKEVENT, SDL_GETEVENT }

const uint SDL_QUERY	= cast(uint) -1;
const uint SDL_IGNORE	= 0;
const uint SDL_DISABLE	= 0;
const uint SDL_ENABLE	= 1;

const uint SDL_HAT_CENTERED	= 0x00;
const uint SDL_HAT_UP		= 0x01;
const uint SDL_HAT_RIGHT	= 0x02;
const uint SDL_HAT_DOWN		= 0x04;
const uint SDL_HAT_LEFT		= 0x08;
const uint SDL_HAT_RIGHTUP		= (SDL_HAT_RIGHT|SDL_HAT_UP);
const uint SDL_HAT_RIGHTDOWN	= (SDL_HAT_RIGHT|SDL_HAT_DOWN);
const uint SDL_HAT_LEFTUP		= (SDL_HAT_LEFT|SDL_HAT_UP);
const uint SDL_HAT_LEFTDOWN		= (SDL_HAT_LEFT|SDL_HAT_DOWN);

const uint SDL_ALL_HOTKEYS		= 0xFFFFFFFF;
const uint SDL_DEFAULT_REPEAT_DELAY		= 500;
const uint SDL_DEFAULT_REPEAT_INTERVAL	= 30;

union SDL_Event {
	Uint8 type;
	SDL_ActiveEvent active;
	SDL_KeyboardEvent key;
	SDL_MouseMotionEvent motion;
	SDL_MouseButtonEvent button;
	SDL_JoyAxisEvent jaxis;
	SDL_JoyBallEvent jball;
	SDL_JoyHatEvent jhat;
	SDL_JoyButtonEvent jbutton;
	SDL_ResizeEvent resize;
	SDL_ExposeEvent expose;
	SDL_QuitEvent quit;
	SDL_UserEvent user;
	SDL_SysWMEvent syswm;
}

enum {
	SDLK_UNKNOWN = 0,
	SDLK_FIRST = 0,
	SDLK_BACKSPACE = 8,
	SDLK_TAB = 9,
	SDLK_CLEAR = 12,
	SDLK_RETURN = 13,
	SDLK_PAUSE = 19,
	SDLK_ESCAPE = 27,
	SDLK_SPACE = 32,
	SDLK_EXCLAIM = 33,
	SDLK_QUOTEDBL = 34,
	SDLK_HASH = 35,
	SDLK_DOLLAR = 36,
	SDLK_AMPERSAND = 38,
	SDLK_QUOTE = 39,
	SDLK_LEFTPAREN = 40,
	SDLK_RIGHTPAREN = 41,
	SDLK_ASTERISK = 42,
	SDLK_PLUS = 43,
	SDLK_COMMA		= 44,
	SDLK_MINUS		= 45,
	SDLK_PERIOD		= 46,
	SDLK_SLASH		= 47,
	
	// Numbers
	SDLK_0 = 48, SDLK_1, SDLK_2, SDLK_3, SDLK_4, SDLK_5, SDLK_6, SDLK_7, SDLK_8, SDLK_9,

	SDLK_COLON		= 58,
	SDLK_SEMICOLON		= 59,
	SDLK_LESS		= 60,
	SDLK_EQUALS		= 61,
	SDLK_GREATER		= 62,
	SDLK_QUESTION		= 63,
	SDLK_AT			= 64,

	SDLK_LEFTBRACKET	= 91,
	SDLK_BACKSLASH		= 92,
	SDLK_RIGHTBRACKET	= 93,
	SDLK_CARET		= 94,
	SDLK_UNDERSCORE		= 95,
	SDLK_BACKQUOTE		= 96,
	
	// Letters
	SDLK_a = 97, SDLK_b, SDLK_c, SDLK_d, SDLK_e, SDLK_f, SDLK_g, SDLK_h, SDLK_i, SDLK_j,
	SDLK_k, SDLK_l, SDLK_m, SDLK_n, SDLK_o, SDLK_p, SDLK_q, SDLK_r, SDLK_s, SDLK_t,
	SDLK_u, SDLK_v, SDLK_w, SDLK_x, SDLK_y, SDLK_z,
	
	SDLK_DELETE		= 127,

	// KP
	SDLK_KP0 = 256,
	SDLK_KP1, SDLK_KP2, SDLK_KP3, SDLK_KP4, SDLK_KP5, SDLK_KP6, SDLK_KP7, SDLK_KP8, SDLK_KP9,
	
	SDLK_KP_PERIOD		= 266,
	SDLK_KP_DIVIDE		= 267,
	SDLK_KP_MULTIPLY	= 268,
	SDLK_KP_MINUS		= 269,
	SDLK_KP_PLUS		= 270,
	SDLK_KP_ENTER		= 271,
	SDLK_KP_EQUALS		= 272,

	// Arrows
	SDLK_UP = 273, SDLK_DOWN, SDLK_RIGHT, SDLK_LEFT,
	
	// Position
	SDLK_INSERT = 277, SDLK_HOME, SDLK_END, SDLK_PAGEUP, SDLK_PAGEDOWN,

	// FS
	SDLK_F1 = 282, SDLK_F2, SDLK_F3, SDLK_F4, SDLK_F5, SDLK_F6, SDLK_F7, SDLK_F8, SDLK_F9, SDLK_F10, SDLK_F11, SDLK_F12, SDLK_F13, SDLK_F14, SDLK_F15,

	SDLK_NUMLOCK		= 300,
	SDLK_CAPSLOCK		= 301,
	SDLK_SCROLLOCK		= 302,
	
	SDLK_RSHIFT		= 303,
	SDLK_LSHIFT		= 304,
	
	SDLK_RCTRL		= 305,
	SDLK_LCTRL		= 306,
	
	SDLK_RALT		= 307,
	SDLK_LALT		= 308,
	
	SDLK_RMETA		= 309,
	SDLK_LMETA		= 310,
	
	SDLK_LSUPER		= 311,
	SDLK_RSUPER		= 312,
	
	SDLK_MODE		= 313,
	SDLK_COMPOSE		= 314,

	SDLK_HELP		= 315,
	SDLK_PRINT		= 316,
	SDLK_SYSREQ		= 317,
	SDLK_BREAK		= 318,
	SDLK_MENU		= 319,
	SDLK_POWER		= 320,
	SDLK_EURO		= 321,
	SDLK_UNDO		= 322,

	SDLK_LAST
}

enum {
	KMOD_NONE  = 0x0000,
	KMOD_LSHIFT= 0x0001,
	KMOD_RSHIFT= 0x0002,
	KMOD_LCTRL = 0x0040,
	KMOD_RCTRL = 0x0080,
	KMOD_LALT  = 0x0100,
	KMOD_RALT  = 0x0200,
	KMOD_LMETA = 0x0400,
	KMOD_RMETA = 0x0800,
	KMOD_NUM   = 0x1000,
	KMOD_CAPS  = 0x2000,
	KMOD_MODE  = 0x4000,
	KMOD_RESERVED = 0x8000
}

const uint KMOD_CTRL	= (KMOD_LCTRL | KMOD_RCTRL);
const uint KMOD_SHIFT	= (KMOD_LSHIFT | KMOD_RSHIFT);
const uint KMOD_ALT		= (KMOD_LALT | KMOD_RALT);
const uint KMOD_META	= (KMOD_LMETA | KMOD_RMETA);

struct WMcursor { void* curs; };

struct SDL_Cursor {
	SDL_Rect area;
	Sint16 hot_x, hot_y;
	Uint8 *data;
	Uint8 *mask;
	Uint8 *save[2];
	WMcursor *wm_cursor;
}

uint SDL_BUTTON(uint X) { return SDL_PRESSED << (X-1); }
const uint SDL_BUTTON_LEFT		= 1;
const uint SDL_BUTTON_MIDDLE	= 2;
const uint SDL_BUTTON_RIGHT		= 3;
const uint SDL_BUTTON_WHEELUP	= 4;
const uint SDL_BUTTON_WHEELDOWN	= 5;
const uint SDL_BUTTON_LMASK		= SDL_PRESSED << (SDL_BUTTON_LEFT - 1);
const uint SDL_BUTTON_MMASK		= SDL_PRESSED << (SDL_BUTTON_MIDDLE - 1);
const uint SDL_BUTTON_RMASK		= SDL_PRESSED << (SDL_BUTTON_RIGHT - 1);
const uint SDL_MUTEX_TIMEDOUT	= 1;
const uint SDL_MUTEX_MAXWAIT	= 0xFFFFFFFF;

typedef int (*_seek_func_t )(SDL_RWops *context, int offset, int whence);
typedef int (*_read_func_t )(SDL_RWops *context, void *ptr, int size, int maxnum);
typedef int (*_write_func_t)(SDL_RWops *context, void *ptr, int size, int num);
typedef int (*_close_func_t)(SDL_RWops *context);

struct SDL_RWops {
	_seek_func_t seek;
	_read_func_t read;
	_write_func_t write;
	_close_func_t close;

	Uint32 type;
	union {
	    struct { int autoclose; void *fp; }
	    struct { Uint8* base, here, stop; }
	    struct { void *data1; }
	}
}

struct SDL_SysWMmsg {
	SDL_version _version;
	HWND2 hwnd;
	UINT2 msg;
	WPARAM2 wParam;
	LPARAM2 lParam;
}

struct SDL_SysWMinfo { SDL_version _version; HWND2 window; }

const uint SDL_MAJOR_VERSION	= 1;
const uint SDL_MINOR_VERSION	= 2;
const uint SDL_PATCHLEVEL		= 6;

const uint SDL_ALPHA_OPAQUE = 255;
const uint SDL_ALPHA_TRANSPARENT = 0;

struct SDL_Rect { Sint16 x, y; Uint16 w, h; }
struct SDL_Color { Uint8 r, g, b, a; }
struct SDL_Palette { int ncolors; SDL_Color *colors; }

struct SDL_PixelFormat {
	SDL_Palette *palette;
	Uint8  BitsPerPixel;
	Uint8  BytesPerPixel;
	Uint8  Rloss;
	Uint8  Gloss;
	Uint8  Bloss;
	Uint8  Aloss;
	Uint8  Rshift;
	Uint8  Gshift;
	Uint8  Bshift;
	Uint8  Ashift;
	Uint32 Rmask;
	Uint32 Gmask;
	Uint32 Bmask;
	Uint32 Amask;
	Uint32 colorkey;
	Uint8  alpha;
}

struct SDL_Surface {
	Uint32 flags;
	SDL_PixelFormat *format;
	int w, h;
	Uint16 pitch;
	void *pixels;
	int offset;
	void  *hwdata;
	SDL_Rect clip_rect;
	Uint32 unused1;
	Uint32 locked;
	void  *map;
	uint format_version;
	int refcount;
}

const uint SDL_SWSURFACE	= 0x00000000;
const uint SDL_HWSURFACE	= 0x00000001;
const uint SDL_ASYNCBLIT	= 0x00000004;

const uint SDL_ANYFORMAT	= 0x10000000;
const uint SDL_HWPALETTE	= 0x20000000;
const uint SDL_DOUBLEBUF	= 0x40000000;
const uint SDL_FULLSCREEN	= 0x80000000;
const uint SDL_OPENGL		= 0x00000002;
const uint SDL_OPENGLBLIT	= 0x0000000A;
const uint SDL_RESIZABLE	= 0x00000010;
const uint SDL_NOFRAME	= 0x00000020;

const uint SDL_HWACCEL	= 0x00000100;
const uint SDL_SRCCOLORKEY	= 0x00001000;
const uint SDL_RLEACCELOK	= 0x00002000;
const uint SDL_RLEACCEL	= 0x00004000;
const uint SDL_SRCALPHA	= 0x00010000;
const uint SDL_PREALLOC	= 0x01000000;

const uint SDL_YV12_OVERLAY = 0x32315659;
const uint SDL_IYUV_OVERLAY = 0x56555949;
const uint SDL_YUY2_OVERLAY = 0x32595559;
const uint SDL_UYVY_OVERLAY = 0x59565955;
const uint SDL_YVYU_OVERLAY = 0x55595659;

struct SDL_VideoInfo { Uint32 flags; Uint32 video_mem; SDL_PixelFormat *vfmt; }

struct SDL_Overlay {
	Uint32 format;
	int w, h;
	int planes;
	Uint16 *pitches;
	Uint8 **pixels;

	void  *hwfuncs;
	void  *hwdata;

	union { bool hw_overlay; Uint32 _dummy; }
}

enum {
	SDL_GL_RED_SIZE, SDL_GL_GREEN_SIZE, SDL_GL_BLUE_SIZE, SDL_GL_ALPHA_SIZE,
	SDL_GL_BUFFER_SIZE, SDL_GL_DOUBLEBUFFER, SDL_GL_DEPTH_SIZE, SDL_GL_STENCIL_SIZE,
	SDL_GL_ACCUM_RED_SIZE, SDL_GL_ACCUM_GREEN_SIZE, SDL_GL_ACCUM_BLUE_SIZE, SDL_GL_ACCUM_ALPHA_SIZE,
	SDL_GL_STEREO, SDL_GL_MULTISAMPLEBUFFERS, SDL_GL_MULTISAMPLESAMPLES, SDL_GL_ACCELERATED_VISUAL,
	SDL_GL_SWAP_CONTROL
}

enum { SDL_GRAB_QUERY = -1, SDL_GRAB_OFF = 0, SDL_GRAB_ON = 1, SDL_GRAB_FULLSCREEN }
enum { SDL_LOGPAL = 0x01, SDL_PHYSPAL }

typedef int (*SDL_blit)(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect);

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

int SDL_GetWMInfo(SDL_SysWMinfo *info);
SDL_Thread * SDL_CreateThread(int (*fn)(void *), void *data);
Uint32 SDL_ThreadID();
Uint32 SDL_GetThreadID(SDL_Thread *thread);
void SDL_WaitThread(SDL_Thread *thread, int *status);
void SDL_KillThread(SDL_Thread *thread);
const uint SDL_TIMESLICE	= 10;
const uint TIMER_RESOLUTION	= 10;
Uint32 SDL_GetTicks();
void SDL_Delay(Uint32 ms);
alias Uint32 (*SDL_TimerCallback)(Uint32 interval);
int SDL_SetTimer(Uint32 interval, SDL_TimerCallback callback);
alias Uint32 (*SDL_NewTimerCallback)(Uint32 interval, void *param);
SDL_TimerID SDL_AddTimer(Uint32 interval, SDL_NewTimerCallback callback, void *param);
SDL_bool SDL_RemoveTimer(SDL_TimerID t);
struct SDL_version { Uint8 major, minor, patch; }
void SDL_VERSION(SDL_version* X) { X.major = SDL_MAJOR_VERSION; X.minor = SDL_MINOR_VERSION; X.patch = SDL_PATCHLEVEL; }
uint SDL_VERSIONNUM(Uint8 X, Uint8 Y, Uint8 Z) { return X * 1000 + Y * 100 + Z; }
const uint SDL_COMPILEDVERSION = SDL_MAJOR_VERSION * 1000 + SDL_MINOR_VERSION * 100 + SDL_PATCHLEVEL;
bool SDL_VERSION_ATLEAST(Uint8 X, Uint8 Y, Uint8 Z) { return (SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z)); }
SDL_version * SDL_Linked_Version();


void SDL_PumpEvents();
int SDL_PeepEvents(SDL_Event *events, int numevents, SDL_eventaction action, Uint32 mask);
int SDL_PollEvent(SDL_Event *event);
int SDL_WaitEvent(SDL_Event *event);
int SDL_PushEvent(SDL_Event *event);
alias int (*SDL_EventFilter)(SDL_Event *event);
void SDL_SetEventFilter(SDL_EventFilter filter);
SDL_EventFilter SDL_GetEventFilter();

Uint8 SDL_GetAppState();
int SDL_Init(Uint32 flags);
int SDL_InitSubSystem(Uint32 flags);
void SDL_QuitSubSystem(Uint32 flags);
Uint32 SDL_WasInit(Uint32 flags);
void SDL_Quit();
int SDL_VideoInit(char *driver_name, Uint32 flags);
void SDL_VideoQuit();
char *SDL_VideoDriverName(char *namebuf, int maxlen);
SDL_Surface * SDL_GetVideoSurface();
SDL_VideoInfo * SDL_GetVideoInfo();
int SDL_VideoModeOK(int width, int height, int bpp, Uint32 flags);
SDL_Rect ** SDL_ListModes(SDL_PixelFormat *format, Uint32 flags);
SDL_Surface *SDL_SetVideoMode(int width, int height, int bpp, Uint32 flags);
void SDL_UpdateRects (SDL_Surface *screen, int numrects, SDL_Rect *rects);
void SDL_UpdateRect (SDL_Surface *screen, Sint32 x, Sint32 y, Uint32 w, Uint32 h);
int SDL_Flip(SDL_Surface *screen);
int SDL_SetGamma(float red, float green, float blue);
int SDL_SetGammaRamp(Uint16 *red, Uint16 *green, Uint16 *blue);
int SDL_GetGammaRamp(Uint16 *red, Uint16 *green, Uint16 *blue);
int SDL_SetColors(SDL_Surface *surface, SDL_Color *colors, int firstcolor, int ncolors);
int SDL_SetPalette(SDL_Surface *surface, int flags, SDL_Color *colors, int firstcolor, int ncolors);
Uint32 SDL_MapRGB(SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b);
Uint32 SDL_MapRGBA(SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
void SDL_GetRGB(Uint32 pixel, SDL_PixelFormat *fmt, Uint8 *r, Uint8 *g, Uint8 *b);
void SDL_GetRGBA(Uint32 pixel, SDL_PixelFormat *fmt, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a);
SDL_Surface *SDL_CreateRGBSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
SDL_Surface *SDL_CreateRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);
void SDL_FreeSurface(SDL_Surface *surface);
SDL_Surface *SDL_AllocSurface(Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask) { return SDL_CreateRGBSurface(flags, width, height, depth, Rmask, Gmask, Bmask, Amask); }
int SDL_LockSurface(SDL_Surface *surface);
void SDL_UnlockSurface(SDL_Surface *surface);
SDL_Surface * SDL_LoadBMP_RW(SDL_RWops *src, int freesrc);
SDL_Surface * SDL_LoadBMP(char* file) { return SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1); }
int SDL_SaveBMP_RW(SDL_Surface *surface, SDL_RWops *dst, int freedst);
int SDL_SaveBMP(SDL_Surface *surface, char* file) { return SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1); }
int SDL_SetColorKey(SDL_Surface *surface, Uint32 flag, Uint32 key);
int SDL_SetAlpha(SDL_Surface *surface, Uint32 flag, Uint8 alpha);
SDL_bool SDL_SetClipRect(SDL_Surface *surface, SDL_Rect *rect);
void SDL_GetClipRect(SDL_Surface *surface, SDL_Rect *rect);
SDL_Surface *SDL_ConvertSurface(SDL_Surface *src, SDL_PixelFormat *fmt, Uint32 flags);
int SDL_UpperBlit(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect);
int SDL_LowerBlit(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect);
int SDL_BlitSurface(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect) { return SDL_UpperBlit(src, srcrect, dst, dstrect); }
int SDL_FillRect(SDL_Surface *dst, SDL_Rect *dstrect, Uint32 color);
SDL_Surface * SDL_DisplayFormat(SDL_Surface *surface);
SDL_Surface * SDL_DisplayFormatAlpha(SDL_Surface *surface);
SDL_Overlay *SDL_CreateYUVOverlay(int width, int height, Uint32 format, SDL_Surface *display);
int SDL_LockYUVOverlay(SDL_Overlay *overlay);
void SDL_UnlockYUVOverlay(SDL_Overlay *overlay);
int SDL_DisplayYUVOverlay(SDL_Overlay *overlay, SDL_Rect *dstrect);
void SDL_FreeYUVOverlay(SDL_Overlay *overlay);
int SDL_GL_LoadLibrary(char *path);
void *SDL_GL_GetProcAddress(char* proc);
int SDL_GL_SetAttribute(SDL_GLattr attr, int value);
int SDL_GL_GetAttribute(SDL_GLattr attr, int* value);
void SDL_GL_SwapBuffers();
void SDL_GL_UpdateRects(int numrects, SDL_Rect* rects);
void SDL_GL_Lock();
void SDL_GL_Unlock();
void SDL_WM_SetCaption(char *title, char *icon);
void SDL_WM_GetCaption(char **title, char **icon);
void SDL_WM_SetIcon(SDL_Surface *icon, Uint8 *mask);
int SDL_WM_IconifyWindow();
int SDL_WM_ToggleFullScreen(SDL_Surface *surface);

int  SDL_AudioInit(char *driver_name);
void SDL_AudioQuit();
char*SDL_AudioDriverName(char *namebuf, int maxlen);
int  SDL_OpenAudio(SDL_AudioSpec *desired, SDL_AudioSpec *obtained);
SDL_audiostatus SDL_GetAudioStatus();
void SDL_PauseAudio(int pause_on);
SDL_AudioSpec *SDL_LoadWAV_RW(SDL_RWops *src, int freesrc, SDL_AudioSpec *spec, Uint8 **audio_buf, Uint32 *audio_len);
SDL_AudioSpec *SDL_LoadWAV(char* file, SDL_AudioSpec* spec, Uint8 **audio_buf, Uint32 *audio_len) { return SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len); }
void SDL_FreeWAV(Uint8 *audio_buf);
int  SDL_BuildAudioCVT(SDL_AudioCVT *cvt, Uint16 src_format, Uint8 src_channels, int src_rate, Uint16 dst_format, Uint8 dst_channels, int dst_rate);
int  SDL_ConvertAudio(SDL_AudioCVT *cvt);
void SDL_MixAudio(Uint8 *dst, Uint8 *src, Uint32 len, int volume);
void SDL_LockAudio();
void SDL_UnlockAudio();
void SDL_CloseAudio();

int SDL_CDNumDrives();
char * SDL_CDName(int drive);
SDL_CD * SDL_CDOpen(int drive);
CDstatus SDL_CDStatus(SDL_CD *cdrom);
int SDL_CDPlayTracks(SDL_CD *cdrom, int start_track, int start_frame, int ntracks, int nframes);
int SDL_CDPlay(SDL_CD *cdrom, int start, int length);
int SDL_CDPause(SDL_CD *cdrom);
int SDL_CDResume(SDL_CD *cdrom);
int SDL_CDStop(SDL_CD *cdrom);
int SDL_CDEject(SDL_CD *cdrom);
void SDL_CDClose(SDL_CD *cdrom);

Uint16 SDL_Swap16(Uint16 D) { return((D<<8)|(D>>8)); }

//Uint32 SDL_Swap32(Uint32 D) { return((D<<24)|((D<<8)&0x00FF0000)|((D>>8)&0x0000FF00)|(D>>24)); }
import std.intrinsic; Uint32 SDL_Swap32(Uint32 D) { return bswap(D); }

Uint64 SDL_Swap64(Uint64 val) {
	Uint32 hi, lo;

	lo = cast(Uint32)(val&0xFFFFFFFF);
	val >>= 32;
	hi = cast(Uint32)(val&0xFFFFFFFF);
	val = SDL_Swap32(lo);
	val <<= 32;
	val |= SDL_Swap32(hi);
	return(val);
}

Uint16 SDL_SwapLE16(Uint16 X) { return SDL_Swap16(X); }
Uint32 SDL_SwapLE32(Uint32 X) { return SDL_Swap32(X); }
Uint64 SDL_SwapLE64(Uint64 X) { return SDL_Swap64(X); }
Uint16 SDL_SwapBE16(Uint16 X) { return (X); }
Uint32 SDL_SwapBE32(Uint32 X) { return (X); }
Uint64 SDL_SwapBE64(Uint64 X) { return (X); }
Uint16 SDL_ReadLE16(SDL_RWops *src);
Uint16 SDL_ReadBE16(SDL_RWops *src);
Uint32 SDL_ReadLE32(SDL_RWops *src);
Uint32 SDL_ReadBE32(SDL_RWops *src);
Uint64 SDL_ReadLE64(SDL_RWops *src);
Uint64 SDL_ReadBE64(SDL_RWops *src);
int SDL_WriteLE16(SDL_RWops *dst, Uint16 value);
int SDL_WriteBE16(SDL_RWops *dst, Uint16 value);
int SDL_WriteLE32(SDL_RWops *dst, Uint32 value);
int SDL_WriteBE32(SDL_RWops *dst, Uint32 value);
int SDL_WriteLE64(SDL_RWops *dst, Uint64 value);
int SDL_WriteBE64(SDL_RWops *dst, Uint64 value);
void SDL_SetError(char *fmt, ...);
char * SDL_GetError();
void SDL_ClearError();
bool SDL_MUSTLOCK(SDL_Surface *surface) { return surface.offset || ((surface.flags & (SDL_HWSURFACE | SDL_ASYNCBLIT | SDL_RLEACCEL)) != 0); }

Uint8 SDL_GetMouseState(int *x, int *y);
Uint8 SDL_GetRelativeMouseState(int *x, int *y);
void SDL_WarpMouse(Uint16 x, Uint16 y);
SDL_Cursor *SDL_CreateCursor (Uint8 *data, Uint8 *mask, int w, int h, int hot_x, int hot_y);
void SDL_SetCursor(SDL_Cursor *cursor);
SDL_Cursor * SDL_GetCursor();
void SDL_FreeCursor(SDL_Cursor *cursor);
int SDL_ShowCursor(int toggle);
SDL_mutex * SDL_CreateMutex();
int SDL_LockMutex(SDL_mutex *m) { return SDL_mutexP(m); }
int SDL_mutexP(SDL_mutex *mutex);
int SDL_UnlockMutex(SDL_mutex* m) { return SDL_mutexV(m); }
int SDL_mutexV(SDL_mutex *mutex);
void SDL_DestroyMutex(SDL_mutex *mutex);
SDL_sem * SDL_CreateSemaphore(Uint32 initial_value);
void SDL_DestroySemaphore(SDL_sem *sem);
int SDL_SemWait(SDL_sem *sem);
int SDL_SemTryWait(SDL_sem *sem);
int SDL_SemWaitTimeout(SDL_sem *sem, Uint32 ms);
int SDL_SemPost(SDL_sem *sem);
Uint32 SDL_SemValue(SDL_sem *sem);
SDL_cond * SDL_CreateCond();
void SDL_DestroyCond(SDL_cond *cond);
int SDL_CondSignal(SDL_cond *cond);
int SDL_CondBroadcast(SDL_cond *cond);
int SDL_CondWait(SDL_cond *cond, SDL_mutex *mut);
int SDL_CondWaitTimeout(SDL_cond *cond, SDL_mutex *mutex, Uint32 ms);
bool SDL_QuitRequested() { SDL_PumpEvents(); return cast(bool)SDL_PeepEvents(null, 0, SDL_PEEKEVENT, SDL_QUITMASK); }
SDL_RWops* SDL_RWFromFile(char *file, char *mode);
SDL_RWops* SDL_RWFromFP(void *fp, int autoclose);
SDL_RWops* SDL_RWFromMem(void *mem, int size);
SDL_RWops* SDL_AllocRW();
void SDL_FreeRW(SDL_RWops *area);
int  SDL_RWseek(SDL_RWops *ctx, int offset, int whence) { _seek_func_t seek; seek = ctx.seek; return (*seek)(ctx, offset, whence); }
int  SDL_RWtell(SDL_RWops *ctx) { _seek_func_t seek; seek = ctx.seek; return (*seek)(ctx, 0, 1); }
int  SDL_RWread(SDL_RWops *ctx, void* ptr, int size, int n) { _read_func_t read; read = ctx.read; return (*read)(ctx, ptr, size, n); }
int  SDL_RWwrite(SDL_RWops *ctx, void* ptr, int size, int n) { _write_func_t write; write = ctx.write; return (*write)(ctx, ptr, size, n); }
int  SDL_RWclose(SDL_RWops *ctx) { _close_func_t close; close = ctx.close; return (*close)(ctx); }

Uint8 SDL_EventState(Uint8 type, int state);
struct SDL_Joystick { }
int SDL_NumJoysticks();
char *SDL_JoystickName(int device_index);
SDL_Joystick *SDL_JoystickOpen(int device_index);
int SDL_JoystickOpened(int device_index);
int SDL_JoystickIndex(SDL_Joystick *joystick);
int SDL_JoystickNumAxes(SDL_Joystick *joystick);
int SDL_JoystickNumBalls(SDL_Joystick *joystick);
int SDL_JoystickNumHats(SDL_Joystick *joystick);
int SDL_JoystickNumButtons(SDL_Joystick *joystick);
void SDL_JoystickUpdate();
int SDL_JoystickEventState(int state);
Sint16 SDL_JoystickGetAxis(SDL_Joystick *joystick, int axis);
Uint8 SDL_JoystickGetHat(SDL_Joystick *joystick, int hat);
int SDL_JoystickGetBall(SDL_Joystick *joystick, int ball, int *dx, int *dy);
Uint8 SDL_JoystickGetButton(SDL_Joystick *joystick, int button);
void SDL_JoystickClose(SDL_Joystick *joystick);
int SDL_EnableUNICODE(int enable);
int SDL_EnableKeyRepeat(int delay, int interval);
Uint8 * SDL_GetKeyState(int *numkeys);
SDLMod SDL_GetModState();
void SDL_SetModState(SDLMod modstate);
char * SDL_GetKeyName(SDLKey key);

extern void SDL_Error(SDL_errorcode code);

SDL_GrabMode SDL_WM_GrabInput(SDL_GrabMode mode);
int SDL_SoftStretch(SDL_Surface *src, SDL_Rect *srcrect, SDL_Surface *dst, SDL_Rect *dstrect);

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
///////////////////////////////////////////////////////////////////////////////
