#include "script_component.hpp"

class CfgFunctions {
	class ADDON {
		class functions {
			file = QUOTE(FILE(functions));

			class preinit {
				FNC_RECOMPILE;
			};

			class operating_uav {
				FNC_RECOMPILE;
			};

			class keybind_name {
				FNC_RECOMPILE;
			};

			class ignore_keybind_for_input_action {
				FNC_RECOMPILE;
			};
		};
	};
};