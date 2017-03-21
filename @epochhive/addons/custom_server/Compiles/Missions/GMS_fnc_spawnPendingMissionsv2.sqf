/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/19/17
	checks the status of each entry in 
*/

if (blck_debugLevel > 1) then {
	diag_log format["_fnc_spawnPendingMissions:: blck_pendingMissions = %1", blck_pendingMissions];
	diag_log format["_fnc_spawnPendingMissions: -- >> blck_missionsRunning = %1",blck_missionsRunning];
};
if (blck_missionsRunning > blck_maxSpawnedMissions) exitWith {
	if (blck_debugLevel > 1) then {
		diag_log "_fnc_spawnPendingMissions:: --- >> Maximum number of missions is running; function exited without attempting to find a new mission to spawn";
	};
};

private["_coords","_missionName","_missionPath","_readyToSpawnQue","_missionToSpawn","_allowReinforcements","_selectNew","_tries"];

_selectNew = true;
_tries = 0;
while {_selectNew && (_tries < 20)} do
{
	_missionToSpawn = selectRandom blck_pendingMissions;
	if (blck_debugLevel > 2) then 
	{
		diag_log format["_fnc_spawnPendingMissions: - > checking mission %1 for try %2", _missionToSpawn,_tries];
	};
	if (diag_tickTime > (_missionToSpawn select 6) && (_missionToSpawn select 6 > 0)) exitWith 
	{
		if (blck_debugLevel > 2) then 
		{
			diag_log format["_fnc_spawnPendingMissions: - > spawning mission %1", _missionToSpawn];
		};
		_coords = [] call blck_fnc_FindSafePosn;
		_coords pushback 0;	
		_missionName = selectRandom (_missionToSpawn select 0);
		_missionPath = _missionToSpawn select 1;
		_allowReinforcements = _missionToSpawn select 8;
		[_coords,_missionToSpawn,_allowReinforcements] execVM format["\q\addons\custom_server\Missions\%1\%2.sqf",_missionPath,_missionName];
		blck_missionsRunning = blck_missionsRunning + 1;
	};
	_tries = _tries + 1;
};

true
