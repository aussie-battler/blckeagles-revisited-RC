/*
	[_crates,_mines,_objects,_blck_AllMissionAI,_blck_localMissionMarker] call blck_fnc_missionEnd;
*/

params["_crates","_mines","_objects","_blck_AllMissionAI","_blck_localMissionMarker"];
diag_log format["[blckeagls] _fnc_missionEnd (6):-> _blck_AllMissionAI = %1",_blck_AllMissionAI];
if (blck_useSignalEnd) then
{
	//diag_log format["**** Minor\SM1.sqf::    _crate = %1",_crates select 0];
	[_crates select 0] spawn blck_fnc_signalEnd;
	
	if (blck_debugLevel > 2) then
	{
		diag_log format["[blckeagls] missionSpawner:: SignalEnd called: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
};

[_mines] spawn blck_fnc_clearMines;
[_objects, blck_cleanupCompositionTimer] call blck_fnc_addObjToQue;
[_blck_AllMissionAI,blck_AliveAICleanUpTime] call blck_fnc_addLiveAItoQue;
[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
[_blck_localMissionMarker select 1, _missionType] call compile preprocessfilelinenumbers "debug\missionCompleteMarker.sqf";
[_blck_localMissionMarker select 0] call compile preprocessfilelinenumbers "debug\deleteMarker.sqf";
[_blck_localMissionMarker select 0,"Completed"] call blck_fnc_updateMissionQue;