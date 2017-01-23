/*
	Update the parameters for a mission in the list of missions running at that time.
	Call with the name of the marker associated with the mission and either "Active" or "Completed"
	by Ghostrider-DbD-
	Last modified 1-22-17
*/

params["_mission","_status",["_coords",[0,0,0]] ];
if (blck_debugON) then {diag_log format["_fnc_updateMissionQue :: _mission = %1 | _status = %2 | _coords = %3",_mission,_status,_coords];};
private["_index","_element","_waitTime"];

_index = blck_pendingMissions find _mission;
if (_index > -1) then
{	
	if (blck_debuglevel > 0) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions began as %1",blck_pendingMissions];};
	_element = blck_pendingMissions select _index;
	if (blck_debuglevel > 0) then {diag_log format["_fnc_updateMissionQue::  -- >> _element before update = %1",_element];}; 
	if (toLower(_status) isEqualTo "active") then {
		_element set[6, -1];
		_element set[7,_coords];
	};
	if (toLower(_status) isEqualTo "inactive") then 
	{
		_waitTime = (_element select 4) + random((_element select 5) - (_element select 4));
		_element set[6, diag_tickTime + _waitTime];
		_element set [7,[0,0,0]];
	};
	if (blck_debuglevel > 0) then {diag_log format["_fnc_updateMissionQue::  -- >> _element after update = %1",_element];}; 
	blck_pendingMissions set [_index, _element];
	if (blck_debuglevel > 0) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions after update = %1",blck_pendingMissions];};	
}; 


