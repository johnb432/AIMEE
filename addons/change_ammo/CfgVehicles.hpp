#define VEHICLE_AMMO_ACTION \
class GVAR(vehicleAmmoClass) {\
    condition = QUOTE(GVAR(settingVehicleAmmoClass) && {!isTurnedOut _player} && {_player == gunner _target});\
    displayName = CQSTRING(STR_usract_reload_magazine);\
    exceptions[] = {"isNotInside"};\
    icon = ICON_RELOAD_VEHICLE;\
    insertChildren = QUOTE([ARR_2(_player,_target)] call FUNC(magazinesVehicleMenus));\
}

// `[player, cursorObject, []] call ace_common_fnc_canInteractWith` returns false when swimming, but true on land
// `[player, cursorObject, ["isNotSwimming"]] call ace_common_fnc_canInteractWith` returns true when swimming and on land

class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class GVAR(ammoClass) {
                condition = QUOTE(GVAR(settingAmmoClass) && {private _weaponState = weaponState _player; _weaponState select 5 <= 0 && {_weaponState select 6 <= 0}} && {!(_player call EFUNC(main,operatingUAV))} && {_player call CBA_fnc_canUseWeapon});
                displayName = CQSTRING(STR_usract_reload_magazine);
                icon = ICON_RELOAD_MAN;
                insertChildren = QUOTE(_player call FUNC(magazinesUnitMenus));
            };
        };
    };

    class LandVehicle;
    class Car: LandVehicle {
        class ACE_SelfActions {
            VEHICLE_AMMO_ACTION;
        };
    };

    class Tank: LandVehicle {
        class ACE_SelfActions {
            VEHICLE_AMMO_ACTION;
        };
    };

    class StaticWeapon: LandVehicle {
        class ACE_SelfActions {
            VEHICLE_AMMO_ACTION;
        };
    };

    class Air;
    class Helicopter: Air {
        class ACE_SelfActions {
            VEHICLE_AMMO_ACTION;
        };
    };

    class Plane: Air {
        class ACE_SelfActions {
            VEHICLE_AMMO_ACTION;
        };
    };
};
