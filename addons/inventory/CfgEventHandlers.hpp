#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
  class ADDON {
    init = QUOTE(call COMPILE_FILE(XEH_preInit));
  };
};

class Extended_WeaponAssembled_EventHandlers {
	class CAManBase {
		class ADDON {
			clientWeaponAssembled = QUOTE(clearBackpackCargoGlobal GVAR(base); GVAR(base) = nil);
		};
	};
};