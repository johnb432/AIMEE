#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

SETTING(termAction,"CHECKBOX",true);
SETTING(UAVAction,"CHECKBOX",true);

ADDON = true;
