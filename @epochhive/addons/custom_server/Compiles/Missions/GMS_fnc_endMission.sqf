/*
	
	[_mines,_objects,_blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission] call blck_fnc_endMission;
	schedules deletion of all remaining alive AI and mission objects.
	Updates the mission que.
	Updates mission markers.
	By Ghostrider-DbD-
	3/17/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_mines","_objects","_crates","_blck_AllMissionAI","_endMsg","_blck_localMissionMarker","_coords","_mission",["_aborted",false]];
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then {
		diag_log format["_fnc_endMission:  _aborted = %1",_aborted];
	};
	#endif

	private["_cleanupAliveAITimer","_cleanupCompositionTimer"];
	if (blck_useSignalEnd && !_aborted) then
	{
		//diag_log format["**** Minor\SM1.sqf::    _crate = %1",_crates select 0];
		[_crates select 0] spawn blck_fnc_signalEnd;

		#ifdef blck_debugMode	
		if (blck_debugLevel > 2) then
		{
			diag_log format["[blckeagls] _fnc_endMission:: (18) SignalEnd called: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};
		#endif

	};

	if (_aborted) then
	{
		#ifdef blck_debugMode
		if (blck_debugLevel > 2) then {
			diag_log format["_fnc_endMission: Mission Aborted, setting all timers to 0"];
		};
		#endif

		_cleanupCompositionTimer = 0;
		_cleanupAliveAITimer = 0;
	} else {

		#ifdef blck_debugMode
		if (blck_debugLevel > 2) then {
			diag_log format["_fnc_endMission:  Mission Completed without errors, setting all timers to default values"];
		};
		#endif
		
		_cleanupCompositionTimer = blck_cleanupCompositionTimer;
		_cleanupAliveAITimer = blck_AliveAICleanUpTimer;
		[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
		[_blck_localMissionMarker select 1, _markerClass] execVM "debug\missionCompleteMarker.sqf";		
	};
	[_mines] spawn blck_fnc_clearMines;
	//diag_log format["_fnc_endMission: (23) _objects = %1",_objects];
	[_objects, _cleanupCompositionTimer] spawn blck_fnc_addObjToQue;
	//diag_log format["_fnc_endMission:: (26) _blck_AllMissionAI = %1",_blck_AllMissionAI];
	[_blck_AllMissionAI, (_cleanupAliveAITimer)] spawn blck_fnc_addLiveAItoQue;
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];
	blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
	//diag_log format["_fnc_endMission:: (34) _mission = %1",_mission];
	[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;
	blck_missionsRunning = blck_missionsRunning - 1;
