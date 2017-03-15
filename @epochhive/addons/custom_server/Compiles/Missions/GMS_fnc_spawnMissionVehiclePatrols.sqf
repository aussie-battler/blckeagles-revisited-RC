/*
	[_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionVehiclePatrols
	by Ghostrider-DbD-
	3/13/17
	returns [] if no groups could be created
	returns [_AI_Vehicles,_missionAIGroups] otherwise;
*/
params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_uniforms","_headGear",["_missionType","unspecified"]];
private["_vehGroup","_patrolVehicle","_vehiclePatrolSpawns","_missionAIGroups","_missiongroups","_vehicles","_return","_vehiclePatrolSpawns","_randomVehicle","_return"];
_vehicles = [];
_missionAIGroups = [];
_vehiclePatrolSpawns= [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
{
	_vehGroup = [_x,3,3,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	//if (isNull _vehGroup) exitWith {_abort = true;};
	//if (blck_debugLevel > 0) then {diag_log format["_fnc_spawnMissionVehiclePatrols:: -> _missionType = %3 _vehGroup = %1 and units _vehGroup = %2",_vehGroup, units _vehGroup,_missionType];};
	if (typename (_vehGroup) isEqualTo "GROUP") then
	{
		_randomVehicle = selectRandom blck_AIPatrolVehicles;
		_patrolVehicle = [_coords,_x,_randomVehicle,(_x distance _coords) -5,(_x distance _coords) + 5,_vehGroup] call blck_fnc_spawnVehiclePatrol;
		//diag_log format["_fnc_spawnMissionVehiclePatrols:: - > patrol vehicle spawned was %1 with type of %2",_patrolVehicle,_randomVehicle];
		_vehicles pushback _patrolVehicle;
		_missionAIGroups pushback _vehGroup;
		//diag_log format["_fnc_spawnMissionVehiclePatrols:: -- > _vehicles updated to %1",_vehicles];
	};
}forEach _vehiclePatrolSpawns;
blck_missionVehicles append _vehicles; 
{
	_x setVariable["blck_stuckMonitor",0];
}forEach _missionAIGroups;
_return = [_vehicles,_missionAIGroups];

_return
