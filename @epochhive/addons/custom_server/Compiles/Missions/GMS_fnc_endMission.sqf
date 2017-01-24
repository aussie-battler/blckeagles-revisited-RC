/*
	
	[_mines,_objects,_blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission] call blck_fnc_endMission;
	schedules deletion of all remaining alive AI and mission objects.
	Updates the mission que.
	Updates mission markers.
	By Ghostrider-DbD-
	1/22/17
*/

	if (blck_useSignalEnd) then
	{
		//diag_log format["**** Minor\SM1.sqf::    _crate = %1",_crates select 0];
		[_crates select 0] spawn blck_fnc_signalEnd;
		
		if (blck_debugLevel > 1) then
		{
			diag_log format["[blckeagls] _fnc_endMission:: (18) SignalEnd called: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};
	};
	params["_mines","_objects","_blck_AllMissionAI","_endMsg","_blck_localMissionMarker","_coords","_mission"];
	[_mines] spawn blck_fnc_clearMines;
	//diag_log format["_fnc_endMission: (23) _objects = %1",_objects];
	uisleep 0.1;
	[_objects, blck_cleanupCompositionTimer] spawn blck_fnc_addObjToQue;
	//diag_log format["_fnc_endMission:: (26) _blck_AllMissionAI = %1",_blck_AllMissionAI];
	uisleep 0.1;
	[_blck_AllMissionAI,blck_AliveAICleanUpTimer] spawn blck_fnc_addLiveAItoQue;
	[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
	[_blck_localMissionMarker select 1, _markerClass] execVM "debug\missionCompleteMarker.sqf";
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];
	blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
	//diag_log format["_fnc_endMission:: (34) _mission = %1",_mission];
	[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;