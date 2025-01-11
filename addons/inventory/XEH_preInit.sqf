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

ADDON = true;
