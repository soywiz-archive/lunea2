module SDL_mixer; import dbind;
import SDL;

extern (C):

const int MIX_MAJOR_VERSION = 1, MIX_MINOR_VERSION = 2, MIX_PATCHLEVEL = 5;

alias int Mix_Fading;
alias int Mix_MusicType;

const int MIX_CHANNELS = 8;
const int MIX_DEFAULT_FREQUENCY = 22050;
version (LittleEndian) { const int MIX_DEFAULT_FORMAT = AUDIO_S16LSB;
} else { const int MIX_DEFAULT_FORMAT = AUDIO_S16MSB; }
const int MIX_DEFAULT_CHANNELS = 2;
const int MIX_MAX_VOLUME = 128;

struct Mix_Chunk { int allocated; Uint8 *abuf; Uint32 alen; Uint8 volume; }
enum { MIX_NO_FADING, MIX_FADING_OUT, MIX_FADING_IN }
enum { MUS_NONE, MUS_CMD, MUS_WAV, MUS_MOD, MUS_MID, MUS_OGG, MUS_MP3 }
struct Mix_Music {}
const char[] MIX_EFFECTSMAXSPEED = "MIX_EFFECTSMAXSPEED";

typedef void (*Mix_EffectFunc_t)(int chan, void *stream, int len, void *udata);
typedef void (*Mix_EffectDone_t)(int chan, void *udata);

const int MIX_CHANNEL_POST = -2;

int  function(int frequency, Uint16 format, int channels, int chunksize) Mix_OpenAudio;
int  function(int numchans) Mix_AllocateChannels;
int  function(int *frequency,Uint16 *format,int *channels) Mix_QuerySpec;
void function(Mix_Chunk *chunk) Mix_FreeChunk;
void function(void (*mix_func)(void *udata, Uint8 *stream, int len), void *arg) Mix_SetPostMix;
void function(void (*channel_finished)(int channel)) Mix_ChannelFinished;
int  function(int chan, Mix_EffectFunc_t f, Mix_EffectDone_t d, void *arg) Mix_RegisterEffect;
int  function(int channel, Mix_EffectFunc_t f) Mix_UnregisterEffect;
int  function(int channel) Mix_UnregisterAllEffects;
int  function(int channel, Uint8 left, Uint8 right) Mix_SetPanning;
int  function(int channel, Sint16 angle, Uint8 distance) Mix_SetPosition;
int  function(int channel, Uint8 distance) Mix_SetDistance;
int  function(int channel, int flip) Mix_SetReverseStereo;
int  function(int num) Mix_ReserveChannels;
int  function(int which, int tag) Mix_GroupChannel;
int  function(int from, int to, int tag) Mix_GroupChannels;
int  function(int tag) Mix_GroupAvailable;
int  function(int tag) Mix_GroupCount;
int  function(int tag) Mix_GroupOldest;
int  function(int tag) Mix_GroupNewer;
int  function(int channel, Mix_Chunk *chunk, int loops, int ticks) Mix_PlayChannelTimed;
int  function(int channel, Mix_Chunk *chunk, int loops, int ms, int ticks) Mix_FadeInChannelTimed;
int  function(int channel, int volume) Mix_Volume;
int  function(Mix_Chunk *chunk, int volume) Mix_VolumeChunk;
int  function(int channel) Mix_HaltChannel;
int  function(int tag) Mix_HaltGroup;
int  function(int channel, int ticks) Mix_ExpireChannel;
int  function(int which, int ms) Mix_FadeOutChannel;
int  function(int tag, int ms) Mix_FadeOutGroup;
Mix_Fading function(int which) Mix_FadingChannel;
void function(int channel) Mix_Pause;
void function(int channel) Mix_Resume;
int  function(int channel) Mix_Paused;

int  function(int ms) Mix_FadeOutMusic;
Mix_Fading function() Mix_FadingMusic;
int  function(Mix_Music *music, int loops) Mix_PlayMusic;
int  function(Mix_Music *music, int loops, int ms) Mix_FadeInMusic;
int  function(Mix_Music *music, int loops, int ms, double position) Mix_FadeInMusicPos;
int  function(int volume) Mix_VolumeMusic;
void function(void (*music_finished)()) Mix_HookMusicFinished;
void function(void (*mix_func)(void *udata, Uint8 *stream, int len), void *arg) Mix_HookMusic;
Mix_MusicType function(Mix_Music *music) Mix_GetMusicType;
void function(Mix_Music *music) Mix_FreeMusic;
int  function(double position) Mix_SetMusicPosition;
int  function() Mix_HaltMusic;
void function() Mix_PauseMusic;
void function() Mix_ResumeMusic;
void function() Mix_RewindMusic;
int  function() Mix_PausedMusic;

int  function(int channel) Mix_Playing;
int  function() Mix_PlayingMusic;
int  function(char *command) Mix_SetMusicCMD;
int  function(int value) Mix_SetSynchroValue;
int  function() Mix_GetSynchroValue;
void function() Mix_CloseAudio;

Mix_Chunk*   function(int channel) Mix_GetChunk;
SDL_version* function() Mix_Linked_Version;
Mix_Chunk*   function(SDL_RWops *src, int freesrc) Mix_LoadWAV_RW;
Mix_Music*   function(char *file) Mix_LoadMUS;
Mix_Chunk*   function (Uint8 *mem)Mix_QuickLoad_WAV;
Mix_Chunk*   function(Uint8 *mem, Uint32 len) Mix_QuickLoad_RAW;
void*        function() Mix_GetMusicHookData;

Mix_Chunk* Mix_LoadWAV(char *file) { return Mix_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1); }
int Mix_PlayChannel(int channel, Mix_Chunk* chunk, int loops) { return Mix_PlayChannelTimed(channel,chunk,loops,-1); }
int Mix_FadeInChannel(int channel, Mix_Chunk* chunk, int loops, int ms) { return Mix_FadeInChannelTimed(channel,chunk,loops,ms,-1); }
alias SDL_GetError Mix_GetError;

extern (D):

void init() {
	dbind_m("SDL_mixer");
	
	mixin(dbind_f("Mix_OpenAudio"));
	mixin(dbind_f("Mix_AllocateChannels"));
	mixin(dbind_f("Mix_QuerySpec"));
	mixin(dbind_f("Mix_FreeChunk"));
	mixin(dbind_f("Mix_SetPostMix"));
	mixin(dbind_f("Mix_ChannelFinished"));
	mixin(dbind_f("Mix_RegisterEffect"));
	mixin(dbind_f("Mix_UnregisterEffect"));
	mixin(dbind_f("Mix_UnregisterAllEffects"));
	mixin(dbind_f("Mix_SetPanning"));
	mixin(dbind_f("Mix_SetPosition"));
	mixin(dbind_f("Mix_SetDistance"));
	mixin(dbind_f("Mix_SetReverseStereo"));
	mixin(dbind_f("Mix_ReserveChannels"));
	mixin(dbind_f("Mix_GroupChannel"));
	mixin(dbind_f("Mix_GroupChannels"));
	mixin(dbind_f("Mix_GroupAvailable"));
	mixin(dbind_f("Mix_GroupCount"));
	mixin(dbind_f("Mix_GroupOldest"));
	mixin(dbind_f("Mix_GroupNewer"));
	mixin(dbind_f("Mix_PlayChannelTimed"));
	mixin(dbind_f("Mix_FadeInChannelTimed"));
	mixin(dbind_f("Mix_Volume"));
	mixin(dbind_f("Mix_VolumeChunk"));
	mixin(dbind_f("Mix_HaltChannel"));
	mixin(dbind_f("Mix_HaltGroup"));
	mixin(dbind_f("Mix_ExpireChannel"));
	mixin(dbind_f("Mix_FadeOutChannel"));
	mixin(dbind_f("Mix_FadeOutGroup"));
	mixin(dbind_f("Mix_FadingChannel"));
	mixin(dbind_f("Mix_Pause"));
	mixin(dbind_f("Mix_Resume"));
	mixin(dbind_f("Mix_Paused"));
	mixin(dbind_f("Mix_FadeOutMusic"));
	mixin(dbind_f("Mix_FadingMusic"));
	mixin(dbind_f("Mix_PlayMusic"));
	mixin(dbind_f("Mix_FadeInMusic"));
	mixin(dbind_f("Mix_FadeInMusicPos"));
	mixin(dbind_f("Mix_VolumeMusic"));
	mixin(dbind_f("Mix_HookMusicFinished"));
	mixin(dbind_f("Mix_HookMusic"));
	mixin(dbind_f("Mix_GetMusicType"));
	mixin(dbind_f("Mix_FreeMusic"));
	mixin(dbind_f("Mix_SetMusicPosition"));
	mixin(dbind_f("Mix_HaltMusic"));
	mixin(dbind_f("Mix_PauseMusic"));
	mixin(dbind_f("Mix_ResumeMusic"));
	mixin(dbind_f("Mix_RewindMusic"));
	mixin(dbind_f("Mix_PausedMusic"));
	mixin(dbind_f("Mix_Playing"));
	mixin(dbind_f("Mix_PlayingMusic"));
	mixin(dbind_f("Mix_SetMusicCMD"));
	mixin(dbind_f("Mix_SetSynchroValue"));
	mixin(dbind_f("Mix_GetSynchroValue"));
	mixin(dbind_f("Mix_CloseAudio"));
	mixin(dbind_f("Mix_GetChunk"));
	mixin(dbind_f("Mix_Linked_Version"));
	mixin(dbind_f("Mix_LoadWAV_RW"));
	mixin(dbind_f("Mix_LoadMUS"));
	mixin(dbind_f("Mix_QuickLoad_WAV"));
	mixin(dbind_f("Mix_QuickLoad_RAW"));
	mixin(dbind_f("Mix_GetMusicHookData"));	
}