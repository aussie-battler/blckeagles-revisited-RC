/*
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 3-14-17
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Compiles\blck_defines.hpp";

private["_vehType","_safepos","_veh"];
params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",30],["_maxDis",45],["_group",grpNull] ];
//_pos  Center of the mission area
//_vehType = [_this,1,"I_G_Offroad_01_armed_F"] call BIS_fnc_param; 
//_minDis = minimum distance from the center of the mission for vehicle waypoints
//_maxDis = maximum distance from the center of the mission for vehicle waypoints
//_groupForVehiclePatrol = The group with which to man the vehicle

if (isNull _group) exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnVehiclePatrol"; objNull;};
//diag_log format["_fnc_spawnVehiclePatrol::->> _group = %1",_group];
_safepos = [_pos,0,25,0,0,20,0] call BIS_fnc_findSafePos;	
_veh = [_vehType,_safepos] call blck_fnc_spawnVehicle;

//diag_log format["spawnVehiclePatrol:: vehicle spawned is %1 of typeof %2",_veh, typeOf _veh];

private["_unitNumber"];
_unitNumber = 0;

{
		switch (_unitNumber) do
		{
			case 0: {_x moveingunner _veh;};
			case 1: {_x moveindriver _veh;};
			default {_x moveInCargo _veh;};
		};
		_unitNumber = _unitNumber + 1;
}forEach (units _group);

while {(count (waypoints _group)) > 0} do
{
	deleteWaypoint ((waypoints _group) select 0);
};

_count = 5;
_start = _center getDir _pos;
_angle = _start;
_sign = selectRandom [1, -1];
_arc = _sign * 360/_count;
for "_i" from 1 to _count do
{
	_angle = _angle + _arc;
	_p2 = _center getPos [(_minDis + random(_maxDis - _minDis)),_angle];
	_wp = _group addWaypoint [_p2, 25];
	_wp setWaypointType "MOVE";
	_wp = _group addWaypoint [_p2, 25];
	_wp setWaypointType "SENTRY";
	_wp setWaypointTimeout [10,17.5,25];
};
_wp = _group addWaypoint [_pos, 25];
_wp setWaypointType "CYCLE";

_veh
