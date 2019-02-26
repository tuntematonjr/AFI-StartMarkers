#define COMPONENT Aloitusmerkit
#define PREFIX Afi

#define MAJOR 3
#define MINOR 5
#define PATCHLVL 0
#define BUILD 19122017

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.56

/*
	#define DEBUG_ENABLED_SYS_MAIN
*/

// #define DEBUG_MODE_FULL

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2