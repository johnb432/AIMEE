#define COMPONENT vehicle_seats
#define COMPONENT_BEAUTIFIED Vehicle Seats
#include "..\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
#define DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_AIMEE_VEHICLE_SEATS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_AIMEE_VEHICLE_SEATS
    #define DEBUG_SETTINGS DEBUG_ENABLED_AIMEE_VEHICLE_SEATS
#endif

#define EJECT_TYPE_CAR   0
#define EJECT_TYPE_FORCE 1
#define EJECT_TYPE_NONE -1
#define EJECT_TYPE_JET  -2

#define TURN_IN  0
#define TURN_OUT 1

#include "..\main\script_macros.hpp"
