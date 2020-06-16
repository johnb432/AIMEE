#include "script_component.hpp"

private _phases = [_this, "engine"] call FUNC(anim_phases);

if (count _phases == 0) exitWith { nil };
_phases select 0;