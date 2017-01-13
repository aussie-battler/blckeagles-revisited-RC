/*
	Update the parameters for a mission in the list of missions running at that time.
	Call with the name of the marker associated with the mission and either "Active" or "Completed"
	by Ghostrider-DbD-
	Last modified 1-12-17
*/

params["_mission","_status",["_coords",[0,0,0]] ];
if (blck_debugON) then {diag_log format["_fnc_updateMissionQue :: _mission = %1 | _status = %2 | _coords = %3",_mission,_status,_coords];};
{
	if (_mission isEqualTo (_x select 2)) exitWith
	{
		private _element = _x;
		if (blck_debugON) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions began as %1",blck_pendingMissions];};
		blck_pendingMissions set[_forEachIndex, -1];
		blck_pendingMissions = blck_pendingMissions - [-1];
		if (blck_debugON) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions after deleteing element = %1 resulted in %2",_element,blck_pendingMissions];};
		if (toLower(_status) isEqualTo "active") then {
			_element set[6, -1];
			_element set[7,_coords];
		};
		if (toLower(_status) isEqualTo "completed") then 
		{
			private _waitTime = (_element select 4) + random((_element select 5) - (_element select 4));
			_element set[6, _waitTime];
			_element set [7,[0,0,0]];
		};
		if (blck_debugON) then {diag_log format["_fnc_updateMissionQue::  -- >> _element updated to %1",_x,_element];};
		blck_pendingMissions pushback _element;
		if (blck_debugON) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions updated to %1",blck_pendingMissions];};
	};
}forEach blck_pendingMissions;

