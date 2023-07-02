#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
SETTING(settingGearAction,"CHECKBOX",true);
SETTING(settingCollisionAction,"CHECKBOX",true);
SETTING(settingLightsAction,"CHECKBOX",true);
SETTING(settingHoverAction,"CHECKBOX",true);
SETTING(settingManualAction,"CHECKBOX",true);
SETTING(settingEngineAction,"CHECKBOX",true);
SETTING(settingFlapsAction,"CHECKBOX",true);
SETTING(settingUserActions,"CHECKBOX",true);
SETTING(settingArtyComputerAction,"CHECKBOX",true);
SETTING(settingLockControlsAction,"CHECKBOX",true);
SETTING(settingTakeControlsAction,"CHECKBOX",true);

ADDON = true;
