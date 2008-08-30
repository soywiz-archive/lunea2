module SDL_ttf; import dbind;
import SDL;

extern (System):

struct TTF_Font {}

enum { TTF_STYLE_NORMAL = 0x00, TTF_STYLE_BOLD = 0x01, TTF_STYLE_ITALIC = 0x02, TTF_STYLE_UNDERLINE = 0x04 }

int function() TTF_Init;
TTF_Font* function(char*file, int ptsize) TTF_OpenFont;
TTF_Font* function(char*file, int ptsize, long index) TTF_OpenFontIndex;
TTF_Font* function(SDL_RWops *src, int freesrc, int ptsize) TTF_OpenFontRW;
TTF_Font* function(SDL_RWops *src, int freesrc, int ptsize, long index) TTF_OpenFontIndexRW;
int   function(TTF_Font*font) TTF_GetFontStyle;
void  function(TTF_Font*font, int style) TTF_SetFontStyle;
int   function(TTF_Font*font) TTF_FontHeight;
int   function(TTF_Font*font) TTF_FontAscent;
int   function(TTF_Font*font) TTF_FontDescent;
int   function(TTF_Font*font) TTF_FontLineSkip;
long  function(TTF_Font*font) TTF_FontFaces;
int   function(TTF_Font*font) TTF_FontFaceIsFixedWidth;
char* function(TTF_Font*font) TTF_FontFaceFamilyName;
char* function(TTF_Font*font) TTF_FontFaceStyleName;
int   function(TTF_Font*font, Uint16 ch, int *minx, int *maxx, int *miny, int *maxy, int *advance) TTF_GlyphMetrics;
int   function(TTF_Font*font, char*text, int *w, int *h) TTF_SizeText;
int   function(TTF_Font*font, char*text, int *w, int *h) TTF_SizeUTF8;
int   function(TTF_Font*font, Uint16 *text, int *w, int *h) TTF_SizeUNICODE;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg) TTF_RenderText_Solid;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg) TTF_RenderUTF8_Solid;
SDL_Surface* function(TTF_Font*font, Uint16 *text, SDL_Color fg) TTF_RenderUNICODE_Solid;
SDL_Surface* function(TTF_Font*font, Uint16 ch, SDL_Color fg) TTF_RenderGlyph_Solid;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg, SDL_Color bg) TTF_RenderText_Shaded;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg, SDL_Color bg) TTF_RenderUTF8_Shaded;
SDL_Surface* function(TTF_Font*font, Uint16 *text, SDL_Color fg, SDL_Color bg) TTF_RenderUNICODE_Shaded;
SDL_Surface* function(TTF_Font*font, Uint16 ch, SDL_Color fg, SDL_Color bg) TTF_RenderGlyph_Shaded;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg) TTF_RenderText_Blended;
SDL_Surface* function(TTF_Font*font, char*text, SDL_Color fg) TTF_RenderUTF8_Blended;
SDL_Surface* function(TTF_Font*font, Uint16 *text, SDL_Color fg) TTF_RenderUNICODE_Blended;
SDL_Surface* function(TTF_Font*font, Uint16 ch, SDL_Color fg) TTF_RenderGlyph_Blended;
void function(TTF_Font*font) TTF_CloseFont;
void function() TTF_Quit;

alias TTF_RenderText_Shaded TTF_RenderText;
alias TTF_RenderUTF8_Shaded TTF_RenderUTF8;
alias TTF_RenderUNICODE_Shaded TTF_RenderUNICODE;
alias SDL_GetError TTF_GetError;

extern (D):

import std.stdio;

void init() {
	dbind_m("SDL_ttf");
	
	mixin(dbind_f("TTF_Init"));
	mixin(dbind_f("TTF_OpenFont"));
	mixin(dbind_f("TTF_OpenFontIndex"));
	mixin(dbind_f("TTF_OpenFontRW"));
	mixin(dbind_f("TTF_OpenFontIndexRW"));
	mixin(dbind_f("TTF_GetFontStyle"));
	mixin(dbind_f("TTF_SetFontStyle"));
	mixin(dbind_f("TTF_FontHeight"));
	mixin(dbind_f("TTF_FontAscent"));
	mixin(dbind_f("TTF_FontDescent"));
	mixin(dbind_f("TTF_FontLineSkip"));
	mixin(dbind_f("TTF_FontFaces"));
	mixin(dbind_f("TTF_FontFaceIsFixedWidth"));
	mixin(dbind_f("TTF_FontFaceFamilyName"));
	mixin(dbind_f("TTF_FontFaceStyleName"));
	mixin(dbind_f("TTF_GlyphMetrics"));
	mixin(dbind_f("TTF_SizeText"));
	mixin(dbind_f("TTF_SizeUTF8"));
	mixin(dbind_f("TTF_SizeUNICODE"));
	mixin(dbind_f("TTF_RenderText_Solid"));
	mixin(dbind_f("TTF_RenderUTF8_Solid"));
	mixin(dbind_f("TTF_RenderUNICODE_Solid"));
	mixin(dbind_f("TTF_RenderGlyph_Solid"));
	mixin(dbind_f("TTF_RenderText_Shaded"));
	mixin(dbind_f("TTF_RenderUTF8_Shaded"));
	mixin(dbind_f("TTF_RenderUNICODE_Shaded"));
	mixin(dbind_f("TTF_RenderGlyph_Shaded"));
	mixin(dbind_f("TTF_RenderText_Blended"));
	mixin(dbind_f("TTF_RenderUTF8_Blended"));
	mixin(dbind_f("TTF_RenderUNICODE_Blended"));
	mixin(dbind_f("TTF_RenderGlyph_Blended"));
	mixin(dbind_f("TTF_CloseFont"));
	mixin(dbind_f("TTF_Quit"));
}
