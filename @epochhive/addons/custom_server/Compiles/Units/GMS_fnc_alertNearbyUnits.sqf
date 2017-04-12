/*
	by Ghostrider
	9-20-15
	Allerts all units within a certain radius of the location of a killer.
	**  Not in use at this time; reserved for the future  **
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_alertDist","_intelligence"];
params["_unit","_killer"];

//diag_log format["#-alertNearbyUnits.sqf-# alerting nearby units of killer of unit %1",_unit];
_alertDist = _unit getVariable ["alertDist",300];
_intelligence = _unit getVariable ["intelligence",1];
if (_alertDist > 0) then {
		//diag_log format["+----+ alerting units close to %1",_unit];
		{
			if (((position _x) distance2D (position _unit)) <= _alertDist) then {
				_knowsAbout = _x knowsAbout _killer;
				_x reveal [_killer, _knowsAbout + _intelligence];
				//diag_log "Killer revealed";
			}
		} forEach allUnits;
};
