class CfgVehicles {
   	class Man;
   	class CAManBase: Man {
      		class ACE_SelfActions {
            // When controlling the drone, this menu will show up
            class GVAR(UAVActionMenuInside) {
                condition = QUOTE(GVAR(UAVAction) && {_player call EFUNC(main,operatingUAV)});
                displayName = DEFAULT_TEXT;
                insertChildren = QUOTE(call FUNC(UAVMenus));
                modifierFunction = QUOTE(call FUNC(UAVModify));
                statement = QUOTE(if (!(_player call EFUNC(main,operatingUAV))) then {PACTION('UAVTerminalOpen',_player)});
            };

            class ACE_Equipment {
                class GVAR(GPSActionMenu) {
                				condition = QUOTE(GVAR(GPSAction) && {!isNil {_player call FUNC(assignedGPS)}});
                				displayName = DEFAULT_TEXT;
                    insertChildren = QUOTE([ARR_3(_target,_player,'MinimapDisplayComponent')] call FUNC(infoPanelMenus));
                				modifierFunction = QUOTE(call FUNC(GPSModify));
             			};

                class GVAR(terminalActionMenu) {
                				displayName = DEFAULT_TEXT;
                				condition = QUOTE(GVAR(termAction) && {!isNil {[ARR_2(_player,true)] call FUNC(assignedGPS)}} && {isNull getConnectedUAV _player || {!GVAR(UAVAction) && {!(_player call EFUNC(main,operatingUAV))}}});
                				modifierFunction = QUOTE(call FUNC(terminalModify));
                    statement = QPACTION('UAVTerminalOpen',_player);
             			};

                class GVAR(UAVActionMenu) {
                				condition = QUOTE(GVAR(UAVAction) && {!isNull getConnectedUAV _player} && {!(_player call EFUNC(main,operatingUAV))});
                				displayName = DEFAULT_TEXT;
                    insertChildren = QUOTE(call FUNC(UAVMenus));
                				modifierFunction = QUOTE(call FUNC(UAVModify));
                    statement = QPACTION('UAVTerminalOpen',_player);
             			};
            };
      		};
   	};
};
