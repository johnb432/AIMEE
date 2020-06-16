#include "script_component.hpp"

#define INVENTORY_DISTANCE 2.5

#define VEHICLE_INVENTORY_ACTION \
	class GVAR(openAction) {\
		displayName = "Inventory";\
		condition = QUOTE(GVAR(settingOpenAction)\
				 && { alive _target }\
				 && { _target call FUNC(has_inventory) });\
		statement = "_player action [""Gear"", _target]";\
		icon = "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa";\
		exceptions[] = {"isNotSwimming"};\
	}

class DefaultEventhandlers;

class CfgVehicles {
	class ReammoBox;
	class WeaponHolder: ReammoBox {
		class Eventhandlers: DefaultEventhandlers {
		};

		class ACE_Actions {
			class GVAR(holderAction) {
				displayName = "Standby...";
				condition = QGVAR(settingHolderAction);
				statement = QUOTE(call FUNC(holder_run));
				modifierFunction = QUOTE(call FUNC(holder_modify));
				distance = INVENTORY_DISTANCE;
				position = QUOTE(_target call FUNC(ground_pos));

				class GVAR(holder_open_action) {
					displayName = "Open";
					condition = QUOTE(call FUNC(holder_open_condition));
					statement = QUOTE(call FUNC(holder_open_run));
					icon = "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa";
				};
			};
		};
	};

	class ThingX;
	class WeaponHolderSimulated: ThingX {
		class ACE_Actions {
			class GVAR(holderAction) {
				displayName = "Standby...";
				condition = QGVAR(settingHolderAction);
				statement = QUOTE(call FUNC(holder_run));
				modifierFunction = QUOTE(call FUNC(holder_modify));
				distance = INVENTORY_DISTANCE;
				position = QUOTE(_target call FUNC(ground_pos));
			};
		};
	};

	class LandVehicle;
	class Car: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				VEHICLE_INVENTORY_ACTION;
			};
		};
	};

	class Tank: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				VEHICLE_INVENTORY_ACTION;
			};
		};
	};

	class Air;
	class Helicopter: Air {
		class ACE_Actions {
			class ACE_MainActions {
				VEHICLE_INVENTORY_ACTION;
			};
		};
	};

	class Plane: Air {
		class ACE_Actions {
			class ACE_MainActions {
				VEHICLE_INVENTORY_ACTION;
			};
		};
	};

	class Ship;
	class Ship_F: Ship {
		class ACE_Actions {
			class ACE_MainActions {
				VEHICLE_INVENTORY_ACTION;
			};
		};
	};

	class StaticWeapon: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(disassembleAction) {
					displayName = "Disassemble";
					condition = QUOTE(GVAR(settingAssembleAction)\
							 && { alive _target }\
							 && { [_player, _target] call FUNC(can_disassemble) });
					statement = "_player action [""Disassemble"", _target]";
					icon = "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa";
				};
			};
		};
	};

	class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class GVAR(backpackAction3d) {
				displayName = "Open backpack";
				condition = QUOTE(GVAR(settingBackpackAction)\
						 && { call FUNC(backpack_condition) });
				statement = "_player action [""OpenBag"", _target]";
				icon = "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa";
				exceptions[] = {"isNotSwimming"};
				distance = INVENTORY_DISTANCE;
				position = QUOTE(_target call FUNC(backpack_pos));
			};

			class ACE_MainActions {
				class GVAR(backpackAction) {
					displayName = "Open backpack";
					condition = QUOTE(!GVAR(settingBackpackAction)\
							 && { call FUNC(backpack_condition) });
					statement = "_player action [""OpenBag"", _target]";
					icon = "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa";
					exceptions[] = {"isNotSwimming"};
				};

				class GVAR(openAction) {
					displayName = "Inventory";
					condition = QUOTE(GVAR(settingOpenAction)\
							 && { !alive _target });
					statement = "_player action [""Gear"", _target]";
					icon = "\A3\ui_f\data\igui\cfg\actions\gear_ca.paa";
					exceptions[] = {"isNotSwimming"};
				};
			};
		};

		class ACE_SelfActions {
			class GVAR(assembleAction) {
				displayName = "Standby...";
				condition = QUOTE(GVAR(settingAssembleAction)\
						 && { ARR2(_player, backpack _player) call FUNC(can_assemble) });
				statement = QUOTE(ARR2(_player, backpack _player) call FUNC(assemble));
				icon = "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa";
				modifierFunction = QUOTE(call FUNC(assemble_modify));
			};
		};
	};
};