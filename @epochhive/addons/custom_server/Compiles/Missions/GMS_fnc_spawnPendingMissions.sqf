/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 1/24/17
	checks the status of each entry in 
*/

diag_log format["_fnc_spawnPendingMissions:: blck_pendingMissions = %1", blck_pendingMissions];
private["_coords","_missionName","_missionPath"];
{
	if (blck_debugLevel > 2) then {diag_log format["_fnc_spawnPendingMissions:: -- >> _x = %1  and _x select 6 = %2",_x, _x select 6];};
	if (_x select 6 > 0) then // The mission is not running, check the time left till it is spawned
	{
		if (diag_tickTime > (_x select 6)) then // time to spawn the mission
		{
			_coords = [] call blck_fnc_FindSafePosn;
			_coords pushback 0;	
			_missionName = selectRandom (_x select 0);
			_missionPath = _x select 1;
			[_coords,_x] execVM format["\q\addons\custom_server\Missions\%1\%2.sqf",_missionPath,_missionName];
		};
	};
}forEach blck_pendingMissions;