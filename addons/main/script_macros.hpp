#pragma hemtt flag pe23_ignore_has_include

#include "\x\cba\addons\main\script_macros_common.hpp"

// This part includes parts of the CBA and ACE3 macro libraries
#define GETPRVAR(var1,var2) (profileNamespace getVariable [ARR_2(var1,var2)])
#define GETUVAR(var1,var2) (uiNamespace getVariable [ARR_2(var1,var2)])
#define GETMVAR(var1,var2) (missionNamespace getVariable [ARR_2(var1,var2)])

#define SETPRVAR(var1,var2) (profileNamespace setVariable [ARR_2(var1,var2)])
#define SETUVAR(var1,var2) (uiNamespace setVariable [ARR_2(var1,var2)])
#define SETMVAR(var1,var2,var3) (missionNamespace setVariable [ARR_3(var1,var2,var3)])

// CBA Setting
#define SETTING(name,type,value)\
[\
    QGVAR(name),\
    type,\
    [LSTRING(name), LSTRING(DOUBLES(name,ToolTip))],\
    COMPONENT_NAME,\
    value\
] call CBA_fnc_addSetting

// Config string
#define CQSTRING(var1) QUOTE($var1)

// Script string
#define LQSTRING(var1) localize QUOTE(var1)

// Player actions
#define PACTION(var1,var2) _player action [ARR_2(var1,var2)]
#define QPACTION(var1,var2) QUOTE(PACTION(var1,var2))

#define DEFAULT_TEXT "Standby..."
#define DISTANCE_INTERACTION_WEAPONHOLDER 4

#define GEAR_ERROR 0
#define GEAR_DOWN 1
#define GEAR_EXTENDING 2
#define GEAR_UP 3
#define GEAR_RETRACTING 4
#define GEAR_UNKNOWN 5
#define FLAPS_MAX 2

#define EJECT_TYPE_CAR 0
#define EJECT_TYPE_FORCE 1
#define EJECT_TYPE_NONE -1
#define EJECT_TYPE_JET -2

#define TEXT_LEFT LQSTRING(STR_ACTION_CUSTOMINFO_LEFT_MODE)
#define TEXT_CLOSE_LEFT LQSTRING(STR_ACTION_CUSTOMINFO_LEFT_CLOSE)
#define TEXT_RIGHT LQSTRING(STR_ACTION_CUSTOMINFO_RIGHT_MODE)
#define TEXT_CLOSE_RIGHT LQSTRING(STR_ACTION_CUSTOMINFO_RIGHT_CLOSE)

#define TEXT_DRIVER LQSTRING(str_getin_pos_driver)
#define TEXT_PILOT LQSTRING(str_getin_pos_pilot)
#define TEXT_CARGO LQSTRING(str_getin_pos_cargo)

#define ICON_OFF "\A3\ui_f\data\igui\cfg\commandbar\unitcombatmode_ca.paa"
#define ICON_ON ""

#define ICON_DRIVER "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa"
#define ICON_PILOT "A3\ui_f\data\IGUI\Cfg\Actions\getinpilot_ca.paa"
#define ICON_GUNNER "A3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa"
#define ICON_COMMANDER "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
#define ICON_CARGO "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa"
#define ICON_TURRET "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa"
#define ICON_FFV "A3\ui_f\data\IGUI\Cfg\CrewAimIndicator\gunnerAuto_ca.paa"

#define ICON_DISCONNECT "\A3\ui_f\data\gui\rsc\rscpendinginvitation\connectionqualitybad_ca.paa"
#define ICON_RELEASE "\A3\ui_f\data\igui\cfg\actions\ico_off_ca.paa"
#define ICON_FEED "\A3\ui_f\data\gui\cfg\hints\uavconncetion_ca.paa"

#define ICON_RELOAD_MAN "\A3\ui_f\data\igui\cfg\actions\reload_ca.paa"
#define ICON_RELOAD_VEHICLE "\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa"

#define ICON_STEP_DOWN_LEADER "\A3\ui_f\data\gui\cfg\ranks\private_gs.paa"

#define ICON_REMOTE_CONTOL "\A3\Modules_F_Curator\Data\portraitRemoteControl_ca.paa"

#define ICON_TAKE "\A3\ui_f\data\igui\cfg\actions\take_ca.paa"
#define ICON_INVENTORY "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa"
#define ICON_REPAIR "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa"
#define ICON_EXPLOSION "\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_ca.paa"

#define ICON_GET_IN "\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getin_ca.paa"
#define ICON_GET_OUT "\A3\ui_f\data\igui\cfg\actions\getout_ca.paa"
#define ICON_EJECT "\A3\ui_f\data\igui\cfg\actions\eject_ca.paa"
#define ICON_CONFIRM "\A3\ui_f\data\igui\cfg\actions\ico_on_ca.paa"

#define ICON_ARROW_UP "\A3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_up_ca.paa"
#define ICON_ARROW_DOWN "\A3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_down_ca.paa"

#if __has_include("\z\ace\addons\quickmount\script_component.hpp")
    #define ICON_CHANGE_SEAT "\z\ace\addons\quickmount\UI\Seats_ca.paa"
#else
    #define ICON_CHANGE_SEAT "\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getincargo.paa"
#endif

#define ICON_PARACHUTE "\A3\Air_F_Beta\Parachute_01\Data\UI\Portrait_Parachute_01_CA.paa"

#define ICON_GEAR "\A3\ui_f\data\igui\cfg\vehicletoggles\landinggeariconon_ca.paa"

#define ICON_LIGHTS_ON "A3\ui_f\data\igui\cfg\actions\ico_cpt_land_ON_ca.paa"
#define ICON_LIGHTS_OFF "A3\ui_f\data\igui\cfg\actions\ico_cpt_land_OFF_ca.paa"

#define ICON_COLLISION_LIGHTS_ON "A3\ui_f\data\igui\cfg\actions\ico_cpt_col_ON_ca.paa"
#define ICON_COLLISION_LIGHTS_OFF "A3\ui_f\data\igui\cfg\actions\ico_cpt_col_OFF_ca.paa"

#define ICON_HOVER "\A3\ui_f\data\igui\cfg\actions\autohover_ca.paa"
#define ICON_HOVER_CANCEL "\A3\ui_f\data\igui\cfg\actions\cancelhover_ca.paa"

#define ICON_MANUAL_FIRE "\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_manualfire_ca.paa"
#define ICON_MANUAL_FIRE_CANCEL "\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_manualfire_ca.paa"

#define ICON_ENGINE_ON "\A3\ui_f\data\igui\cfg\actions\engine_on_ca.paa"
#define ICON_ENGINE_OFF "\A3\ui_f\data\igui\cfg\actions\engine_off_ca.paa"

#define ICON_FLAPS "\A3\ui_f\data\igui\cfg\simpletasks\types\plane_ca.paa"
#define ICON_FLAPS_0 "\A3\ui_f\data\igui\cfg\vehicletoggles\flapsiconoff_ca.paa"
#define ICON_FLAPS_1 "\A3\ui_f\data\igui\cfg\vehicletoggles\flapsiconon_ca.paa"
#define ICON_FLAPS_2 "\A3\ui_f\data\igui\cfg\vehicletoggles\flapsiconon2_ca.paa"

#define ICON_ARTY_COMP "\A3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa"

#define ICON_MORE "\A3\ui_f\data\gui\cfg\cursors\add_gs.paa"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif
