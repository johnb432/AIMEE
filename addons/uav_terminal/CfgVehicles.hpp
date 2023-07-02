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
                condition = QUOTE(alive GETMVAR('bis_fnc_moduleRemoteControl_unit',objNull) && {!isPlayer GETMVAR('bis_fnc_moduleRemoteControl_unit',objNull)});
                exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
                displayName = CQSTRING(STR_useract_uav_releasecontrols);
                statement = QUOTE(call FUNC(stopRemoteControllingUnit));
            };

            class ACE_Equipment {
                class GVAR(terminalActionMenu) {
                    displayName = DEFAULT_TEXT;
                    exceptions[] = {"isNotInside", "isNotSwimming", "isNotSitting"};
                    condition = QUOTE(GVAR(termAction) && {(_player call FUNC(assignedTerminal)) != -1} && {isNull getConnectedUAV _player || {!GVAR(UAVAction) && {!(_player call EFUNC(main,operatingUAV))}}});
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
