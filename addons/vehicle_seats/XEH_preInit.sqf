#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
SETTING(settingGetInAction,"CHECKBOX",true);
SETTING(settingChangeAction,"CHECKBOX",true);
SETTING(settingGetOutAction,"CHECKBOX",true);
SETTING(settingForceEject,"CHECKBOX",true);
SETTING(settingTurnOutAction,"CHECKBOX",true);

ADDON = true;
