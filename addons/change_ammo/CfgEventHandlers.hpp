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

class Extended_Reloaded_EventHandlers {
	class CAManBase {
		class ADDON {
			clientReloaded = QUOTE(_this call FUNC(reloaded_handler));
		};
	};
};