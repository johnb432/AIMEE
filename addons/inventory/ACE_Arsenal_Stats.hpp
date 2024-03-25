class ace_arsenal_stats {
    class statBase;
    class GVAR(isFlashHider): statBase {
        scope = 2;
        displayName = "Is flash hider";
        showText = 1;
        #pragma hemtt suppress pw3_padded_arg
        textStatement = QUOTE(\
            private _itemCfg = (_this select 1) >> 'ItemInfo';\
            if (!isClass _itemCfg) exitWith {localize 'STR_ACE_Common_No'};\
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
        #pragma hemtt suppress pw3_padded_arg
        textStatement = QUOTE(\
            private _itemCfg = (_this select 1) >> 'ItemInfo';\
            if (!isClass _itemCfg) exitWith {localize 'STR_ACE_Common_No'};\
            private _num = getNumber (_itemCfg >> 'AmmoCoef' >> 'audibleFire');\
            localize ([ARR_2('STR_ACE_Common_No','STR_ACE_Common_Yes')] select (_num != 0 && {_num != 1}))\
        );
        condition = QUOTE(true);
        tabs[] = {{}, {2}};
    };
};
