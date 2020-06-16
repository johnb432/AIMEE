// assumes all vtols in arma 3 have 6-position vectoring
#include "script_component.hpp"

params [
	"_vehicle",
	"_n_notches"
];

private _current = round (VECTORING_MAX * (_vehicle call FUNC(guess_vectoring)));