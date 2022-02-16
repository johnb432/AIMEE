#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

SETTING(settingGetInAction,"CHECKBOX",true);
SETTING(settingChangeAction,"CHECKBOX",true);
SETTING(settingGetOutAction,"CHECKBOX",true);
SETTING(settingForceEject,"CHECKBOX",true);
SETTING(settingTurnOutAction,"CHECKBOX",true);

ADDON = true;
