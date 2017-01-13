/*
	Call as : [] call blck_fnc_mainThread;
	
	Run a loop that checks data arrays regarding:
	- whether it is time to delete the mission objects at a specific location
	- whether it is time to delete live AI associated with a specific mission
	By Ghostrider-DbD-
	Last modified 1-13-17
*/
private ["_index","_timer10Min","_timer1min","_timer5min","_modType"];

_index = 0;
_timer5sec = diag_tickTime;
_timer1min = diag_tickTime;
_timer5min = diag_tickTime;
_timer10Min = diag_tickTime;
_modType = [] call blck_fnc_getModType;
_ai = [];
_obj = [];

while {true} do
{
	uiSleep blck_mainThreadUpdateInterval;  //  defined in custom_server\compiles\blck_variables.sqf
	if ((diag_tickTime - _timer5sec) > 5) then
	{
		[] call blck_fnc_vehicleMonitor;
		_timer5sec = diag_tickTime;
	};
	if ((diag_tickTime - _timer1min) > 60) then
	{
		_ai = blck_liveMissionAI;
		{
			if (diag_tickTime > (_x select 1) ) then {
				//diag_log format["_fnc_mainTread:: cleaning up AI group %1",_x];
				[_x select 0] call blck_fnc_cleanupAliveAI;
			};
			blck_liveMissionAI = blck_liveMissionAI - [_x];  // Remove that list of live AI from the list.
		}forEach _ai;
		
		_obj = blck_oldMissionObjects;
		{
			//diag_log format["mainThread::-->> missionObjects  _x = %1",_x];
			if (diag_tickTime > (_x select 1) ) then {
				//diag_log format["_fnc_mainTread:: cleaning up mission objects %1",_x];
				[_x select 0] call blck_fnc_cleanupObjects;
			};
			blck_oldMissionObjects = blck_oldMissionObjects - [_x];
		}forEach _obj;
		
		[] call GMS_fnc_cleanupDeadAI;	
				
		if (_modType isEqualTo "Epoch") then {
			//diag_log "calling blck_fnc_cleanEmptyGroups";
			[] call blck_fnc_cleanEmptyGroups;
		};  // Exile cleans up empty groups automatically so this should not be needed with that mod.

		/*  [Jan 14, 2017] reverted the the approach based on mission timers for now
		{
			if (blck_debugLevel > 2) then {diag_log format["_fnc_mainThread:: -- >> _x = %1  and _x select 6 = %2",_x, _x select 6];};
			if (_x select 6 > 0) then // The mission is not running, check the time left till it is spawned
			{
				if (diag_tickTime > (_x select 6)) then // time to spawn the mission
				{
					private _coords = [] call blck_fnc_FindSafePosn;
					_coords pushback 0;	
					blck_ActiveMissionCoords pushback _coords;  // Note, old entries are delete in blck_fnc_FindSafePosn
					private["_markerClass","_missionName","_missionPath","_aiDifficultyLevel"];
					//diag_log format["_fnc_mainThread::  -->> _missionClass would = %1%2",_x select 2, _index];
					_markerClass = _x select 2;
					if (blck_debugLevel > 2) then {diag_log format["_fnc_mainThread:: -->> _markerClass = %1",_markerClass];};
					_aiDifficultyLevel = _x select 4;
					_missionName = selectRandom (_x select 0);
					_missionPath = _x select 1;
					// example: 
					//  [_missionListHunters,_pathHunters,"HunterMarker","green",blck_TMin_Hunter,blck_TMax_Hunter]
					[_coords,_markerClass,_aiDifficultyLevel] execVM format["\q\addons\custom_server\Missions\%1\%2.sqf",_missionPath,_missionName];
				};
			};
		}forEach blck_pendingMissions;
		_timer1min = diag_tickTime;		
	};
	*/
	if ((diag_tickTime - _timer5min) > 300) then {
		if (blck_timeAcceleration) then 
		{
			//if (blck_debugON) then {diag_log "[blckeagls] calling time acceleration module";};
			[] call blck_fnc_timeAcceleration;
		};
		if (blck_useHC) then {[] call blck_fnc_monitorHC;};  // Not working
		_timer5min = diag_tickTime;
	};
	
	/*
	if ((diag_tickTime - _timer10Min) > 600) then
	{
		// Reserved for future use
		_timer10Min = diag_tickTime;
	};
	*/
};
