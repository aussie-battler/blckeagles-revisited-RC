/*
	by Ghostrider
	4-5-17
	Alerts the units of nearby vehicles of the location of an enemy.
	 
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_target"];

_fn_alertGroupUnits = {
	params["_group","_target"];
	private["_intelligence","_knowsAbout"];
	_intelligence = (leader _group) getVariable ["intelligence",1];
	{
		_knowsAbout = _x knowsAbout _target;
		_x reveal [_target,_knowsAbout + _intelligence];
	}forEach (units _group);
};

_fn_allertNearbyVehicleGroups = {
	params["_vehicles","_target"];
	private["_vehGroup"];
	{
		_vehGroup = _x getVariable["vehicleGroup",grpNull];
		if (_target distance2D (leader _vehGroup) < 1000) then {[_vehGroup,_target] call _fn_alertGroupUnits;};
	}forEach _vehicles;
};

[blck_monitoredVehicles,_target] call _fn_allertNearbyVehicleGroups;


