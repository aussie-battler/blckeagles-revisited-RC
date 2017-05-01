/*
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 3-17-17
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_vehType","_safepos","_veh"];
params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",30],["_maxDis",45],["_group",grpNull]];


//_center  Center of the mission area - this is usuall the position treated as the center by the mission spawner. Vehicles will patrol the perimeter of the mission area.
// _pos the approximate spawn point for the vehicle
//_vehType = [_this,1,"I_G_Offroad_01_armed_F"] call BIS_fnc_param; 
//_minDis = minimum distance from the center of the mission for vehicle waypoints
//_maxDis = maximum distance from the center of the mission for vehicle waypoints
//_groupForVehiclePatrol = The group with which to man the vehicle

//#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnVehiclePatrol:: _center = %1 | _pos = %2 | _vehType = %3 | _group = %4",_center,_pos,_vehType,_group];
};
//#endif

if !(isNull _group) then 
{  // exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnVehiclePatrol"; objNull;};
	_veh = [_vehType,_pos] call blck_fnc_spawnVehicle;
	_group setVariable["groupVehicle",_veh];
	//#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["spawnVehiclePatrol:: vehicle spawned is %1 of typeof %2",_veh, typeOf _veh];
	};
	//#endif

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

	// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_pattern",["MOVE","SAD"]]];
	_group setcombatmode "RED";
	_group setBehaviour "COMBAT";
	[_center,_minDis,_maxDis,_group,"perimeter","SAD","vehicle"] spawn blck_fnc_setupWaypoints;
};
//#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnVehiclePatrol::->> _veh = %1",_veh];
};
//#endif
_veh
	/*
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

		
		if (_i isEqualTo 1) then
		{
			_wp = [_group, 0];
			_wp setWaypointPosition [_p2, 25];
		} else {
			_wp = _group addWaypoint [_p2, 25];
		};
		_wp setWaypointType "MOVE";
		_wp setWaypointName "move";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode blck_combatMode;
		_wp setWaypointTimeout [1,1.1,1.2];	
		_wp = _group addWaypoint [_p2, 25];
		_wp setWaypointType "SAD";
		_wp setWaypointName "sentry";	
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode blck_combatMode;	
		_wp setWaypointTimeout [10,17.5,25]; 
	};
	_wp = _group addWaypoint [_pos, 25];
	_wp setWaypointType "CYCLE";
	_group setVariable["wpIndex",0];
	
};


*/

