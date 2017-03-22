/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/20/17
	checks the status of each entry in 
*/

#ifdef blck_debugMode
if (blck_debugLevel > 1) then {diag_log format["_fnc_spawnPendingMissions:: blck_pendingMissions = %1", blck_pendingMissions];};
diag_log format["_fnc_spawnPendingMissions: -- >> blck_missionsRunning = %1",blck_missionsRunning];
#endif

if (blck_missionsRunning >= blck_maxSpawnedMissions) exitWith {

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then {
		diag_log "_fnc_spawnPendingMissions:: --- >> Maximum number of missions is running; function exited without attempting to find a new mission to spawn";
	};
	#endif
};

private["_coords","_missionName","_missionPath","_search","_readyToSpawnQue","_missionToSpawn","_allowReinforcements"];
_readyToSpawnQue = [];
{
	if ( (diag_tickTime > (_x select 6)) && ((_x select 6) > 0) ) then 
	{
		_readyToSpawnQue pushback _x;
	};
} forEach blck_pendingMissions;

if (count _readyToSpawnQue < 1) exitWith {

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then {
		diag_log "_fnc_spawnPendingMissions:: --- >> There are no missions available to spawn at this time";
	};
	#endif
};
_missionToSpawn = selectRandom _readyToSpawnQue;

#ifdef blck_debugMode
if (blck_debugLevel > 2) then 
{
	diag_log format["_fnc_spawnPendingMissions:: -- >> blck_missionsRunning = %1  and blck_maxSpawnedMissions = %2 so _canSpawn = %3",blck_missionsRunning,blck_maxSpawnedMissions, (blck_maxSpawnedMissions - blck_missionsRunning)];
};
#endif

_coords = [] call blck_fnc_FindSafePosn;
_coords pushback 0;	
_missionName = selectRandom (_missionToSpawn select 0);
_missionPath = _missionToSpawn select 1;
_allowReinforcements = _missionToSpawn select 8;
[_coords,_missionToSpawn,_allowReinforcements] execVM format["\q\addons\custom_server\Missions\%1\%2.sqf",_missionPath,_missionName];
blck_missionsRunning = blck_missionsRunning + 1;

true
