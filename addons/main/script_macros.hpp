#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#define FUNC_PATHTO_SYS(var1,var2,var3) \MAINPREFIX\var1\SUBPREFIX\var2\functions\var3.sqf
#define FUNC_PATHTO_SYS_HELP(var1,var2,var3) \MAINPREFIX\var1\SUBPREFIX\var2\ace_action_helpers\var3.sqf

#ifdef DISABLE_COMPILE_CACHE
    #define PREPFNC(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'FUNC_PATHTO_SYS(PREFIX,COMPONENT,DOUBLES(fnc,var1))'
    #define PREPFNCHELP(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'FUNC_PATHTO_SYS_HELP(PREFIX,COMPONENT,DOUBLES(fnc,var1))'
#else
    #define PREPFNC(var1) ['FUNC_PATHTO_SYS(PREFIX,COMPONENT,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
    #define PREPFNCHELP(var1) ['FUNC_PATHTO_SYS_HELP(PREFIX,COMPONENT,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
#endif

#define ARR2(s0, s1) [(s0), (s1)]

#define GEAR_ERROR 0
#define GEAR_DOWN 1
#define GEAR_EXTENDING 2
#define GEAR_UP 3
#define GEAR_RETRACTING 4
#define GEAR_UNKNOWN 5
#define FLAPS_MAX 2
#define VECTORING_MAX 6

#define EJECT_TYPE_CAR 0
#define EJECT_TYPE_FORCE 1
#define EJECT_TYPE_NONE -1
#define EJECT_TYPE_JET -2