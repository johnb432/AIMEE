#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

SETTING(settingOpenAction,"CHECKBOX",true);
SETTING(settingBackpackAction,"CHECKBOX",true);
SETTING(settingHolderAction,"CHECKBOX",true);
SETTING(settingAssembleAction,"CHECKBOX",true);

// Add various stats to arsenal
if (hasInterface && {isClass (configFile >> "CfgPatches" >> "ace_arsenal")}) then {
    [[[8, 9], []], QGVAR(hasNightVision), [], "Has night vision", [false, true], [{}, {
        params ["", "_itemCfg"];

        private _visionModes = if (isClass (_itemCfg >> "OpticsModes")) then {
            flatten (("true" configClasses (_itemCfg >> "OpticsModes")) apply {getArray (_x >> "visionMode")})
        } else {
            getArray (_itemCfg >> "visionMode")
        };

        ["No", "Yes"] select (_visionModes findIf {"NVG" == _x} != -1)
    }, {true}]] call ace_arsenal_fnc_addStat;

    [[[8, 9], []], QGVAR(hasThermalVision), [], "Has thermal vision", [false, true], [{}, {
        params ["", "_itemCfg"];

        private _visionModes = if (isClass (_itemCfg >> "OpticsModes")) then {
            flatten (("true" configClasses (_itemCfg >> "OpticsModes")) apply {getArray (_x >> "visionMode")})
        } else {
            getArray (_itemCfg >> "visionMode")
        };

        ["No", "Yes"] select (_visionModes findIf {"TI" == _x} != -1)
    }, {true}]] call ace_arsenal_fnc_addStat;

    [[[2], []], QGVAR(canBuddyReload), [], "Special functionality", [false, true], [{}, {
        "Can be reloaded by a buddy";
    }, {
        params ["", "_itemCfg"];

        getNumber (_itemCfg >> "ACE_reloadlaunchers_enabled") == 1
    }]] call ace_arsenal_fnc_addStat;

    [[[5], []], QGVAR(hasWireCutter), [], "Special functionality", [false, true], [{}, {
        "Has wirecutters built in";
    }, {
        params ["", "_itemCfg"];

        getNumber (_itemCfg >> "ace_logistics_wirecutter_hasWirecutter") == 1
    }]] call ace_arsenal_fnc_addStat;

    [[[], [2]], QGVAR(isSuppressor), [], "Is suppressor", [false, true], [{}, {
        "Yes";
    }, {
        params ["", "_itemCfg"];

        _itemCfg = _itemCfg >> "ItemInfo";

        if (!isClass _itemCfg) exitWith {false};

        private _num = getNumber (_itemCfg >> "AmmoCoef" >> "audibleFire");

         _num != 0 && {_num != 1} && {getNumber (_itemCfg >> "soundTypeIndex") == 1}
    }]] call ace_arsenal_fnc_addStat;

    [[[], [2]], QGVAR(isFlashHider), [], "Is flash hider", [false, true], [{}, {
        "Yes";
    }, {
        params ["", "_itemCfg"];

        _itemCfg = _itemCfg >> "ItemInfo";

        if (!isClass _itemCfg) exitWith {false};

        private _num = getNumber (_itemCfg >> "AmmoCoef" >> "visibleFire");

        _num != 0 && {_num != 1}
    }]] call ace_arsenal_fnc_addStat;
};

ADDON = true;
