/*
	[_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call _fnc_spawnMissionVehiclePatrols
	by Ghostrider-DbD-
	1/9/17
	returns [] if no groups could be created
	returns [_AI_Vehicles,_missionAI] otherwise;
*/
params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_uniforms","_headGear"];
private["_vehGroup","_patrolVehicle","_vehiclePatrolSpawns","_missionAI","_missiongroups","_AI_Vehicles","_abort","_vehiclePatrolSpawns","_randomVehicle","_return"];
_missionAI = [];
_missiongroups = [];
_AI_Vehicles = [];
_return = [];
_abort = false;
_vehiclePatrolSpawns= [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
{
	_vehGroup = [_x,3,3,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	if (isNull _vehGroup) exitWith {_abort = true;};
	_missiongroups pushback _vehGroup;
	_randomVehicle = blck_AIPatrolVehicles call BIS_fnc_selectRandom;
	_patrolVehicle = [_coords,_x,_randomVehicle,(_x distance _coords) -5,(_x distance _coords) + 5,_vehGroup] call blck_fnc_spawnVehiclePatrol;
	_vehGroup setVariable["groupVehicle",_patrolVehicle,true];
	_AI_Vehicles pushback _patrolVehicle;
}forEach _vehiclePatrolSpawns;
if (blck_debugLevel > 1) then
{
	diag_log format["[blckeagls] missionSpawner:: Vehicle Patrols Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};
if (_abort) then 
{
	{deleteVehicle _x} forEach _AI_Vehicles;
	{
		{deleteVehicle _x} forEach (units _x);
		deleteGroup _x;
	} forEach _missiongroups;
	
};
if !(_abort) then 
{
	{
		_missionAI append (units _x);
	}forEach _missiongroups;
	_return = [_missionAI,_AI_Vehicles];
}; 

_return;