/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last modified 4/29/17
	checks the status of each entry in 
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#ifdef blck_debugMode
if (blck_debugLevel > 3) then {
	diag_log format["_fnc_spawnPendingMissions:: blck_pendingMissions = %1", blck_pendingMissions];
};
#endif

if (blck_missionsRunning >= blck_maxSpawnedMissions) exitWith {

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then {
		diag_log "_fnc_spawnPendingMissions:: --- >> Maximum number of missions is running; function exited without attempting to find a new mission to spawn";
	};
	#endif
};

private["_coords","_compiledMission","_search","_readyToSpawnQue","_missionToSpawn","_allowReinforcements"];
_readyToSpawnQue = [];
{                      //          0                 1                2          3     3      5         6     
	// _mission = [_compiledMissionsList,format["%1%2",_marker,_i],_difficulty,_tMin,_tMax,_waitTime,[0,0,0]];
	if ( (diag_tickTime > (_x select 5)) && ((_x select 5) > 0) ) then 
	{
		_readyToSpawnQue pushback _x;
	};
} forEach blck_pendingMissions;
#ifdef blck_debugMode
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_spawnPendingMissions:: --- >> _readyToSpawnQue = %1",_readyToSpawnQue];
};
#endif
if (count _readyToSpawnQue > 0) then
{
	_missionToSpawn = selectRandom _readyToSpawnQue;
	//{
		//if (_foreachindex > 0) then {diag_log format["_fnc_spawnPendingMissions: _missionToSpawn %1 = %2",_foreachindex, _missionToSpawn select _foreachindex]};
	//}forEach _missionToSpawn;
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then 
	{
		diag_log format["_fnc_spawnPendingMissions:: -- >> blck_missionsRunning = %1  and blck_maxSpawnedMissions = %2 so _canSpawn = %3",blck_missionsRunning,blck_maxSpawnedMissions, (blck_maxSpawnedMissions - blck_missionsRunning)];
	};
	#endif

	_coords = [] call blck_fnc_FindSafePosn;
	_coords pushback 0;	
	_compiledMission = selectRandom (_missionToSpawn select 0);
	// 	_mission = [_compiledMissionsList,format["%1%2",_marker,_i],_difficulty,_tMin,_tMax,_waitTime,[0,0,0]];
	_missionMarker = _missionToSpawn select 1;
	_missionDifficulty = _missionToSpawn select 2;
	//diag_log format["_fnc_spawnPendingMissions: _missionParameters = %1",_missionParameters];
	//[_coords,_missionToSpawn,_allowReinforcements] execVM format["\q\addons\custom_server\Missions\%1\%2.sqf",_missionPath,_missionName];
	[_coords,_missionMarker,_missionDifficulty] spawn _compiledMission;
	blck_missionsRunning = blck_missionsRunning + 1;
};

true
