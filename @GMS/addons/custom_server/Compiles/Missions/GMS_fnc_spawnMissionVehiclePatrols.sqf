/*
	[_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionVehiclePatrols
	by Ghostrider [GRG]
	3/17/17
	returns [] if no groups could be created
	returns [_AI_Vehicles,_missionAI] otherwise;
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_uniforms","_headGear","_missionPatrolVehicles",["_useRelativePos",true],["_weapons",[]],["_vests",blck_vests],["_isScubaGroup",false]];
if (count _weapons == 0) then {_weapons = [_aiDifficultyLevel] call blck_fnc_selectAILoadout};
#ifdef blck_debugMode
if (blck_debugLevel > 1) then 
{
	diag_log format["_fnc_spawnMissionVehiclePatrols: _this = %1",_this];
	diag_log format["_fnc_spawnMissionVehiclePatrols:: _coords = %1 | _noVehiclePatrols = %2 | _aiDifficultyLevel = %3",_coords,_noVehiclePatrols,_aiDifficultyLevel];
};
#endif

private["_vehGroup","_patrolVehicle","_vehiclePatrolSpawns","_missionAI","_missiongroups","_vehicles","_return","_vehiclePatrolSpawns","_vehicle","_return","_abort","_spawnPos","_v"];
_vehicles = [];
_missionAI = [];
_abort = false;
//_useRelativePos = false;
if (_missionPatrolVehicles isEqualTo []) then
{
	_useRelativePos = false;
	_vehiclePatrolSpawns = [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
	{
		_v = [_aiDifficultyLevel] call blck_fnc_selectPatrolVehicle;
		//diag_log format["_fnc_spawnMissionVehiclePatrols (36):: position = %1 and vehicle = %2",_x, _v];
		_missionPatrolVehicles pushBack [_v, _x];
	}forEach _vehiclePatrolSpawns;
};

{
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then 
	{
		diag_log format["_fnc_spawnMissionVehiclePatrols:: _x = %1 and _coords = %2",_x,_coords];
	};
	#endif

	if (_useRelativePos) then
	{
		_spawnPos = _coords vectorAdd (_x select 1)
	} else {
		_spawnPos = _x select 1;
	};
	_vehicle = _x select 0;

	_vehGroup = [_spawnPos,3,3,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear,false,_weapons,_vests,_isScubaGroup] call blck_fnc_spawnGroup;
	if (isNull _vehGroup) exitWith 
	{
		_abort = true;
	};
	if !(isNull _vehGroup) then
	{
		blck_monitoredMissionAIGroups pushBack _vehGroup;
	};

	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then 
	{
		diag_log format["_fnc_spawnMissionVehiclePatrols (73): group spawned = %1",_vehGroup];
		//diag_log format["_fnc_spawnMissionVehiclePatrols (74):: -> _missionType = %3 _vehGroup = %1 and units _vehGroup = %2",_vehGroup, units _vehGroup,_missionType];
	};
	#endif
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then 
	{
		diag_log format["_fnc_spawnMissionVehiclePatrols(66): will spawn vehicle %1 at position %2",_vehicle,_spawnPos];
	};	
	#endif

	//params["_center","_pos",["_vehType","I_G_Offroad_01_armed_F"],["_minDis",30],["_maxDis",45],["_group",grpNull]];
	_patrolVehicle = [_coords,_spawnPos,_vehicle,30,45,_vehGroup] call blck_fnc_spawnVehiclePatrol;
	_vehGroup setVariable["groupVehicle",_vehicle];
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionVehiclePatrols (76):: - > patrol vehicle spawned was %1",_patrolVehicle];
	};
	#endif

	if !(isNull _patrolVehicle) then
	{
		_patrolVehicle setVariable["vehicleGroup",_vehGroup];
		_vehicles pushback _patrolVehicle;
		_missionAI append (units _vehGroup);
	};

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionVehiclePatrols(91):: -- > _vehicles updated to %1",_vehicles];
	};
	#endif
	
} forEach _missionPatrolVehicles;

blck_monitoredVehicles append _vehicles; 
_return = [_vehicles, _missionAI, _abort];

_return
