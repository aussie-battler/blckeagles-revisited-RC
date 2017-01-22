/*
	[_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionVehiclePatrols
	by Ghostrider-DbD-
	1/22/17
	returns [] if no groups could be created
	returns [_AI_Vehicles,_missionAI] otherwise;
*/
params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_uniforms","_headGear",["_missionType","unspecified"]];
private["_vehGroup","_patrolVehicle","_vehiclePatrolSpawns","_missionAI","_missiongroups","_AI_Vehicles","_abort","_vehiclePatrolSpawns","_randomVehicle","_return"];
_missionAI = [];

_vehiclePatrolSpawns= [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
{
	_vehGroup = [_x,3,3,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	//if (isNull _vehGroup) exitWith {_abort = true;};
	if (blck_debugLevel > 0) then {diag_log format["_fnc_spawnMissionVehiclePatrols:: -> _missionType = %3 _vehGroup = %1 and units _vehGroup = %2",_vehGroup, units _vehGroup,_missionType];};
	if (typename (units _vehGroup) isEqualTo "ARRAY") then
	{
		_randomVehicle = selectRandom blck_AIPatrolVehicles;
		_patrolVehicle = [_coords,_x,_randomVehicle,(_x distance _coords) -5,(_x distance _coords) + 5,_vehGroup] call blck_fnc_spawnVehiclePatrol;
		_vehGroup setVariable["groupVehicle",_patrolVehicle,true];
		_missionAI append (units _vehGroup);
	};
}forEach _vehiclePatrolSpawns;
if (blck_debugLevel > 1) then
{
	diag_log format["[blckeagls] _fnc_spawnMissionVehiclePatrols :: Vehicle Patrols Spawned: _coords %1 : _missionType %2 :  _aiDifficultyLevel %3",_coords,_aiDifficultyLevel];
};
 
_missionAI;