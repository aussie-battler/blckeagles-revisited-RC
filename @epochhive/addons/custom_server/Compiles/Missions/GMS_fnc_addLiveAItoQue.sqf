/*
	Adds a list of live AI associated with a mission to a que of live AI that will be deleted at a later time by the main thread
	call as [ [list of AI], time] call blck_fnc_addLiveAItoQue; where time is the time delay before deletion occurs
	
	by Ghostrider-DbD-
	Last modified 3-13-17
*/
//diag_log format["_fnc_addLiveAIToQue:: -> when called, blck_liveMissionAI = %1",blck_liveMissionAI];
params["_aiGroupsList","_timeDelay"];
//diag_log format["_fnc_addLiveAIToQue::  -->> _aiList = %1 || _timeDelay = %2 || diag_tickTime %3",_aiGroupsList,_timeDelay, diag_tickTime];
blck_liveMissionAIGroups pushback [_aiGroupsList, (diag_tickTime + _timeDelay)];
//diag_log format["_fnc_addLiveAIToQue:: -> blck_fnc_addLiveAI updated to %1",blck_liveMissionAI];

