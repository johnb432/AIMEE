#define GETIN_ACTION \
   	class GVAR(getInAction) {\
      		condition = QUOTE(GVAR(settingGetInAction) && {alive _target} && {locked _target <= 1} && {!([ARR_2(side _player,side _target)] call BIS_fnc_sideIsEnemy)} && {((fullCrew [ARR_3(_target,"",true)]) findIf {[ARR_3(_player,_target,_x)] call FUNC(canSwitch)}) isNotEqualTo -1});\
      		displayName = CQSTRING(STR_rscMenu.hppRscGroupRootMenu_Items_GetIn1);\
        icon = ICON_GET_IN;\
      		insertChildren = QUOTE([ARR_2(_target,_player)] call FUNC(changeSubMenus));\
        statement = QUOTE([ARR_2(_target,_player)] call FUNC(getInRun));\
   	}

class CfgVehicles {
   	class LandVehicle;
   	class Car: LandVehicle {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

    class Motorcycle: LandVehicle {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

    class StaticWeapon: LandVehicle {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

   	class Tank: LandVehicle {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

   	class Air;
   	class Helicopter: Air {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

   	class Plane: Air {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
  		    };
   	};

   	class Ship;
   	class Ship_F: Ship {
      		class ACE_Actions {
         			class ACE_MainActions {
         				   GETIN_ACTION;
         			};
      		};
   	};

   	class Man;
   	class CAManBase: Man {
      		class ACE_SelfActions {
         			class GVAR(changeAction) {
            				condition = QUOTE(GVAR(settingChangeAction) && {!isTurnedOut _player} && {locked objectParent _player <= 1} && {isMultiplayer || {effectiveCommander objectParent _player isEqualTo _player}});
            				displayName = CSTRING(ChangeSeat);
                exceptions[] = {"isNotInside"};
                icon = ICON_CHANGE_SEAT;
            				insertChildren = QUOTE([ARR_2(_target,_player)] call FUNC(changeSubMenus));
         			};

         			class GVAR(turnOutAction) {
            				condition = QUOTE(GVAR(settingTurnOutAction) && {!isTurnedOut _player} && {'TurnOut' call EFUNC(main,ignoreKeybindForInputAction)} && {[ARR_2(_player,objectParent _player)] call FUNC(canTurnOut)});
            				displayName = CQSTRING(STR_action_turnout);
                exceptions[] = {"isNotInside"};
                icon = ICON_ARROW_UP;
                statement = QPACTION('TurnOut',objectParent _player);
         			};

         			class GVAR(turnInAction) {
            				condition = QUOTE(GVAR(settingTurnOutAction) && {isTurnedOut _player} && {'TurnOut' call EFUNC(main,ignoreKeybindForInputAction)});
            				displayName = CQSTRING(STR_action_turnin);
                exceptions[] = {"isNotInside"};
                icon = ICON_ARROW_DOWN;
                statement = QPACTION('TurnIn',objectParent _player);
         			};

         			class GVAR(ejectActionMoving) {
            				condition = QUOTE(GVAR(settingGetOutAction) && {!isNull objectParent _player} && {'Eject' call EFUNC(main,ignoreKeybindForInputAction)} && {!(abs speed (objectParent _player) < 2 && {(getPos objectParent _player) select 2 < 2})} && {[ARR_2(_player,objectParent _player)] call FUNC(canEject) isNotEqualTo EJECT_TYPE_NONE});
                displayName = CQSTRING(STR_action_eject);
                exceptions[] = {"isNotInside"};
                icon = ICON_EJECT;

            				class GVAR(ejectConfirmAction) {
               					condition = QUOTE(true);
                    displayName = CSTRING(ConfirmEject);
                    exceptions[] = {"isNotInside"};
                    icon = ICON_CONFIRM;
                    statement = QUOTE([ARR_2(_player,objectParent _player)] call FUNC(eject));
            				};
         			};

         			class GVAR(getOutAction) {
            				condition = QUOTE(GVAR(settingGetOutAction) && {!isNull objectParent _player} && {'GetOut' call EFUNC(main,ignoreKeybindForInputAction)} && {abs speed (objectParent _player) < 2} && {(getPos (objectParent _player)) select 2 < 2});
                displayName = CQSTRING(STR_action_getout);
                exceptions[] = {"isNotInside"};
                icon = ICON_GET_OUT;
                statement = QPACTION('GetOut',objectParent _player);

            				class GVAR(ejectAction) {
               					condition = QUOTE('Eject' call EFUNC(main,ignoreKeybindForInputAction) && {[ARR_2(_player,objectParent _player)] call FUNC(canEject) >= 0});
                    displayName = CQSTRING(STR_action_eject);
                    exceptions[] = {"isNotInside"};
                    icon = ICON_EJECT;
                    statement = QUOTE([ARR_2(_player,objectParent _player)] call FUNC(eject));
            				};
         			};
      		};
   	};
};
