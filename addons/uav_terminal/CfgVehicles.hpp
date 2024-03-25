class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            // When controlling the drone, this menu will show up
            class GVAR(UAVActionMenuInside) {
                condition = QUOTE(GVAR(UAVAction) && {_player call EFUNC(main,operatingUAV)});
                displayName = DEFAULT_TEXT;
                insertChildren = QUOTE(_player call FUNC(UAVMenus));
                modifierFunction = QUOTE(call FUNC(UAVModify));
                statement = QUOTE(if (!(_player call EFUNC(main,operatingUAV))) then {PACTION('UAVTerminalOpen',_player)});
            };

            // For stopping remote controlling when Zeus
            class GVAR(remoteControllingUnit) {
                condition = QUOTE(GVAR(remoteControlAction) && {private _unit = GETMVAR('BIS_fnc_moduleRemoteControl_unit',objNull); alive _unit && {!isPlayer _unit}});
                displayName = CQSTRING(STR_useract_uav_releasecontrols);
                exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
                icon = ICON_REMOTE_CONTOL;
                statement = QUOTE(call FUNC(stopRemoteControllingUnit));
            };

            class ACE_Equipment {
                class GVAR(terminalActionMenu) {
                    condition = QUOTE(GVAR(termAction) && {_player call FUNC(assignedTerminal)} && {isNull getConnectedUAV _player || {!GVAR(UAVAction) && {!(_player call EFUNC(main,operatingUAV))}}});
                    displayName = DEFAULT_TEXT;
                    exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
                    modifierFunction = QUOTE(call FUNC(terminalModify));
                    statement = QPACTION('UAVTerminalOpen',_player);
                };

                class GVAR(UAVActionMenu) {
                    condition = QUOTE(GVAR(UAVAction) && {alive getConnectedUAV _player} && {!(_player call EFUNC(main,operatingUAV))});
                    displayName = DEFAULT_TEXT;
                    exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
                    insertChildren = QUOTE(_player call FUNC(UAVMenus));
                    modifierFunction = QUOTE(call FUNC(UAVModify));
                    statement = QPACTION('UAVTerminalOpen',_player);
                };
            };
        };
    };
};
