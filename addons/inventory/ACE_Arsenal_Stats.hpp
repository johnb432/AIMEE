class ace_arsenal_stats {
    class statBase;
    class GVAR(hasNightVision): statBase {
        scope = 2;
        displayName = CQSTRING(STR_ACE_Spectator_visions_nv);
        showText = 1;
        textStatement = QUOTE(\
            private _visionModes = if (isClass ((_this select 1) >> 'OpticsModes')) then {\
                flatten (('true' configClasses ((_this select 1) >> 'OpticsModes')) apply {getArray (_x >> 'visionMode')})\
            } else {\
                getArray ((_this select 1) >> 'visionMode')\
            };\
            localize ([ARR_2('STR_ACE_Common_No','STR_ACE_Common_Yes')] select (_visionModes findIf {'NVG' == _x} != -1))\
        );
        condition = QUOTE(true);
        tabs[] = {{8,9}, {}};
    };
    class GVAR(hasThermalVision): statBase {
        scope = 2;
        displayName = CQSTRING(STR_ACE_Spectator_visions_ti);
        showText = 1;
        textStatement = QUOTE(\
            private _visionModes = if (isClass ((_this select 1) >> 'OpticsModes')) then {\
                flatten (('true' configClasses ((_this select 1) >> 'OpticsModes')) apply {getArray (_x >> 'visionMode')})\
            } else {\
                getArray ((_this select 1) >> 'visionMode')\
            };\
            localize ([ARR_2('STR_ACE_Common_No','STR_ACE_Common_Yes')] select (_visionModes findIf {'TI' == _x} != -1))\
        );
        condition = QUOTE(true);
        tabs[] = {{8,9}, {}};
    };
    class GVAR(canBuddyReload): statBase {
        scope = 2;
        displayName = "Special functionality";
        showText = 1;
        textStatement = QUOTE('Can be reloaded by a buddy');
        condition = QUOTE(getNumber ((_this select 1) >> 'ACE_reloadlaunchers_enabled') == 1);
        tabs[] = {{2}, {}};
    };
    class GVAR(hasWireCutter): statBase {
        scope = 2;
        displayName = "Special functionality";
        showText = 1;
        textStatement = QUOTE(localize 'STR_ACE_Logistics_Wirecutter_wirecutterName');
        condition = QUOTE(getNumber ((_this select 1) >> 'ace_logistics_wirecutter_hasWirecutter') == 1);
        tabs[] = {{4,5}, {}};
    };
    class GVAR(hasWireCutterMiscItems): statBase {
        scope = 2;
        displayName = "Special functionality";
        showText = 1;
        textStatement = QUOTE(localize 'STR_ACE_Logistics_Wirecutter_wirecutterName');
        condition = QUOTE(getNumber ((_this select 1) >> 'ACE_isWirecutter') == 1);
        tabs[] = {{}, {7}};
    };
    class GVAR(isFlashHider): statBase {
        scope = 2;
        displayName = "Is flash hider";
        showText = 1;
        textStatement = QUOTE(\
            private _itemCfg = (_this select 1) >> 'ItemInfo';\
            if (!isClass _itemCfg) exitWith {false};\
            private _num = getNumber (_itemCfg >> 'AmmoCoef' >> 'visibleFire');\
            localize ([ARR_2('STR_ACE_Common_No','STR_ACE_Common_Yes')] select (_num != 0 && {_num != 1}))\
        );
        condition = QUOTE(true);
        tabs[] = {{}, {2}};
    };
    class GVAR(isSuppressor): statBase {
        scope = 2;
        displayName = "Is suppressor";
        showText = 1;
        textStatement = QUOTE(\
            private _itemCfg = (_this select 1) >> 'ItemInfo';\
            if (!isClass _itemCfg) exitWith {false};\
            private _num = getNumber (_itemCfg >> 'AmmoCoef' >> 'audibleFire');\
            localize ([ARR_2('STR_ACE_Common_No','STR_ACE_Common_Yes')] select (_num != 0 && {_num != 1}))\
        );
        condition = QUOTE(true);
        tabs[] = {{}, {2}};
    };
};
