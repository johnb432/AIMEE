#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
SETTING(settingOpenAction,"CHECKBOX",true);
SETTING(settingBackpackAction,"CHECKBOX",true);
SETTING(settingHolderAction,"CHECKBOX",true);
SETTING(settingAssembleAction,"CHECKBOX",true);
SETTING(settingAssembleUavAction,"CHECKBOX",true);
SETTING(settingExplosivesAction,"CHECKBOX",true);

// Get all mines/explosives if ACE explosives and ACE arsenal aren't loaded
// https://github.com/acemod/ACE3/pull/10660#issuecomment-2599466880
if (uiNamespace isNil "ace_arsenal_putCache" && {!("ace_explosives" call ace_common_fnc_isModLoaded)}) then {
    uiNamespace setVariable ["ace_arsenal_putCache", (compatibleMagazines "Put") createHashMapFromArray []];
};

ADDON = true;
