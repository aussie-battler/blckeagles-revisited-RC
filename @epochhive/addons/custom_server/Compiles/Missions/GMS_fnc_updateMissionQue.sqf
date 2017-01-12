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
		private _temp = [];
		// first, remove the element from the array
		{
			if !(_mission isEqualTo (_x select 2)) then {_temp pushback _x};
		} forEach blck_pendingMissions;
		//[_element,blck_pendingMissions] call blck_fnc_deleteFromArray;
		blck_pendingMissions = _temp;
		if (blck_debugON) then {diag_log format ["_fnc_updateMissionQue :: _element = %1",_element];};
		//  update the mission information
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
		//  re-insert the mission information into the array
		blck_pendingMissions pushback _element;
		if (blck_debugON) then {diag_log format ["_fnc_updateMissionQue :: blck_pendingMissions updated to %1",blck_pendingMissions];};
	};
}forEach blck_pendingMissions;

