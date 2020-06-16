#include "script_component.hpp"

class Extended_PreInit_EventHandlers {
  class ADDON {
    init = QUOTE(call COMPILE_FILE(XEH_preInit));
  };
};

class Extended_PostInit_EventHandlers {
  class ADDON {
    init = QUOTE(call COMPILE_FILE(XEH_postInit));
  };
};

class Extended_Gear_EventHandlers {
	class Air {
		class ADDON {
			clientGear = QUOTE(_this call FUNC(gear_handler));
		};
	};
};