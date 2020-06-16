#include "script_component.hpp"

switch ([_this] call FUNC(gear_status)) do {
	case GEAR_DOWN: {
		player action ["LandGearUp", _this];
		[_this, GEAR_RETRACTING] call FUNC(gear_status);
	};
	case GEAR_UP: {
		player action ["LandGear", _this];
		[_this, GEAR_EXTENDING] call FUNC(gear_status);
	};
	default {
	};
};