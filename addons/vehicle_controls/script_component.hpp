#define COMPONENT vehicle_controls
#define COMPONENT_BEAUTIFIED Vehicle Controls
#include "..\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
#define DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_AIMEE_VEHICLE_CTRL
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_AIMEE_VEHICLE_CTRL
    #define DEBUG_SETTINGS DEBUG_ENABLED_AIMEE_VEHICLE_CTRL
#endif

#define GEAR_ERROR 0
#define GEAR_DOWN 1
#define GEAR_EXTENDING 2
#define GEAR_UP 3
#define GEAR_RETRACTING 4
#define GEAR_UNKNOWN 5

#define FLAPS_MAX 2

#include "..\main\script_macros.hpp"
