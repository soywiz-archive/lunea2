module SDL_image; import dbind;

import SDL;
extern (System):

int function(int on) IMG_InvertAlpha;

int function(SDL_RWops *src) IMG_isBMP;
int function(SDL_RWops *src) IMG_isPNM;
int function(SDL_RWops *src) IMG_isXPM;
int function(SDL_RWops *src) IMG_isXCF;
int function(SDL_RWops *src) IMG_isPCX;
int function(SDL_RWops *src) IMG_isGIF;
int function(SDL_RWops *src) IMG_isJPG;
int function(SDL_RWops *src) IMG_isTIF;
int function(SDL_RWops *src) IMG_isPNG;
int function(SDL_RWops *src) IMG_isLBM;

SDL_Surface* function(char *file) IMG_Load;
SDL_Surface* function(SDL_RWops *src, int freesrc) IMG_Load_RW;
SDL_Surface* function(SDL_RWops *src, int freesrc, char *type) IMG_LoadTyped_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadBMP_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadPNM_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadXPM_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadXCF_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadPCX_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadGIF_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadJPG_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadTIF_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadPNG_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadTGA_RW;
SDL_Surface* function(SDL_RWops *src) IMG_LoadLBM_RW;

SDL_Surface* function(char **xpm) IMG_ReadXPMFromArray;

alias SDL_GetError IMG_GetError;

extern (D):

void init() {
	dbind_m("SDL_image");
	
	mixin(dbind_f("IMG_InvertAlpha"));
	mixin(dbind_f("IMG_isBMP"));
	mixin(dbind_f("IMG_isPNM"));
	mixin(dbind_f("IMG_isXPM"));
	mixin(dbind_f("IMG_isXCF"));
	mixin(dbind_f("IMG_isPCX"));
	mixin(dbind_f("IMG_isGIF"));
	mixin(dbind_f("IMG_isJPG"));
	mixin(dbind_f("IMG_isTIF"));
	mixin(dbind_f("IMG_isPNG"));
	mixin(dbind_f("IMG_isLBM"));
	mixin(dbind_f("IMG_Load"));
	mixin(dbind_f("IMG_Load_RW"));
	mixin(dbind_f("IMG_LoadTyped_RW"));
	mixin(dbind_f("IMG_LoadBMP_RW"));
	mixin(dbind_f("IMG_LoadPNM_RW"));
	mixin(dbind_f("IMG_LoadXPM_RW"));
	mixin(dbind_f("IMG_LoadXCF_RW"));
	mixin(dbind_f("IMG_LoadPCX_RW"));
	mixin(dbind_f("IMG_LoadGIF_RW"));
	mixin(dbind_f("IMG_LoadJPG_RW"));
	mixin(dbind_f("IMG_LoadTIF_RW"));
	mixin(dbind_f("IMG_LoadPNG_RW"));
	mixin(dbind_f("IMG_LoadTGA_RW"));
	mixin(dbind_f("IMG_LoadLBM_RW"));
	mixin(dbind_f("IMG_ReadXPMFromArray"));	
}