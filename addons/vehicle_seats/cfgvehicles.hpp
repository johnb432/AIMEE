#include "script_component.hpp"

#define GETIN_ACTION \
	class GVAR(getInAction) {\
		displayName = "Get In";\
		condition = QUOTE(call FUNC(getin_condition));\
		statement = QUOTE(call FUNC(getin_run));\
		icon = "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getin_ca.paa";\
		insertChildren = QUOTE(call FUNC(change_submenus));\
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

	class StaticWeapon: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				GETIN_ACTION;
			};
		};
	};

	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class changeAction {
				displayName = "Change Seat";
				condition = QUOTE(call FUNC(change_condition));
				icon = "\a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_getincargo.paa";
				exceptions[] = {"isNotInside"};
				insertChildren = QUOTE(call FUNC(change_submenus));
			};

			class turnOutAction {
				displayName = "Turn out";
				condition = QUOTE(call FUNC(turnout_condition));
				statement = "_player action ['TurnOut', vehicle _player]";
				icon = "\A3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_up_ca.paa";
				exceptions[] = {"isNotInside"};
			};

			class turnInAction {
				displayName = "Turn in";
				condition = QUOTE(call FUNC(turnin_condition));
				statement = "_player action ['TurnIn', vehicle _player]";
				icon = "\A3\ui_f\data\gui\rsc\rscdisplaymultiplayer\arrow_down_ca.paa";
				exceptions[] = {"isNotInside"};
			};

			class ejectAction {
				displayName = "Eject";
				condition = QUOTE(call FUNC(eject_condition));
				icon = "\a3\ui_f\data\igui\cfg\actions\eject_ca.paa";
				exceptions[] = {"isNotInside"};
				class ejectConfirmAction {
					displayName = "Confirm Eject";
					condition = "true";
					statement = QUOTE(ARR2(_player, vehicle _player) call FUNC(eject));
					icon = "\a3\ui_f\data\igui\cfg\actions\ico_on_ca.paa";
					exceptions[] = {"isNotInside"};
				};
			};

			class getOutAction {
				displayName = "Get Out";
				condition = QUOTE(call FUNC(getout_condition));
				statement = "_player action ['GetOut', vehicle _player]";
				icon = "\a3\ui_f\data\igui\cfg\actions\getout_ca.paa";
				exceptions[] = {"isNotInside"};
				class ejectAction {
					displayName = "Eject";
					condition = QUOTE(call FUNC(getout_eject_condition));
					statement = QUOTE(ARR2(_player, vehicle _player) call FUNC(eject));
					icon = "\a3\ui_f\data\igui\cfg\actions\eject_ca.paa";
					exceptions[] = {"isNotInside"};
				};
			};
		};
	};
};