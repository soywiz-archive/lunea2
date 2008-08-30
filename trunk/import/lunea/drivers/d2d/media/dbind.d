module dbind;

//debug = dbind_debug;
//version = dbind_not_found_critical_error;

version (Windows) {
	import std.c.windows.windows;
	import std.string;
	import std.stdio;

	HANDLE last_module;
	char[] last_module_name;
	HANDLE[char[]] modules;
	
	void dbind_base(void** ptr, char[] funcName) {
		void* func = GetProcAddress(last_module, std.string.toStringz(funcName));
		if (!func) {
			version (dbind_not_found_critical_error) {
				throw(new Exception(std.string.format("Can't bind '%s' from '%s'", funcName, last_module_name)));
			} else {
				writefln("Can't bind '%s' from '%s'", funcName, last_module_name);
			}
		}
		*ptr = func;
		debug(dbind_debug) writefln("   function: %s", funcName);
	}	
	
	void dbind_m(char[] name) {
		last_module_name = name ~ ".dll";
		last_module = LoadLibraryA(std.string.toStringz(last_module_name));
		if (!last_module) throw(new Exception(std.string.format("Can't load module '%s'", last_module_name)));
		modules[last_module_name] = last_module;
		debug(dbind_debug) writefln("module: %s", last_module_name);
	}
	
	char[] dbind_f(char[] t) { return "dbind_base(cast(void**)&" ~ t ~ ", \"" ~ t ~ "\");"; }
} else {
	static assert (0 != 0);
}
