	// Delete objects in a list after a certain time.
	// code to delete any smoking or on fire objects adapted from kalania 
	//http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page1
	// http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page2
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 1-24-17
*/

_fn_deleteObjects = {
	params["_objects"];
	if (blck_debugLevel > 0) then {diag_log format["_fn_deleteObjects:: -> _objects = %1",_objects];};
	{
		if ((typeOf _x) isKindOf "LandVehicle") then
		{
			if !(_x getVariable["releasedToPlayers",false]) then
			{
				private _crew = crew _x;
				{
					[_x] call blck_fnc_deleteAI;
				}forEach _crew;
			};
			_x setVariable["blck_DeleteAt",0];  // Schedule it to be deleted by fnc_vehicleMonitor immediately
		} else {
			if (blck_debugLevel > 1) then {diag_log format["_fnc_cleanUpObjects: -> deleting object %1",_x];};
			deleteVehicle _x;
		};
	} forEach _objects;
};

//diag_log format["_fnc_cleanUpObjects called at %1",diag_tickTime];
private["_oldObjs"];
for "_i" from 1 to (count blck_oldMissionObjects) do
{
	if (_i <= count blck_oldMissionObjects) then
	{
		_oldObjs = blck_oldMissionObjects select (_i - 1);
		//diag_log format["_fnc_cleanUpObjects ::-->> evaluating missionObjects = %1 with delete time of %3 and diag_tickTime %2",_oldObjs,diag_tickTime, _oldObjs select 1];
		if (diag_tickTime > (_oldObjs select 1) ) then {
			//diag_log format["_fn_deleteObjects:: (50) cleaning up mission objects %1",_oldObjs];
			[_oldObjs select 0] call  _fn_deleteObjects;
			uiSleep 0.1;
			blck_oldMissionObjects set[(_i - 1), -1];
			blck_oldMissionObjects = blck_oldMissionObjects - [-1];
			//diag_log format["_fn_deleteObjects:: blck_oldMissionObjects updated from %1",_obj];
			if (blck_debugLevel > 1) then {diag_log format["_fn_deleteObjects:: (48)  blck_oldMissionObjects updated to %1",blck_oldMissionObjects];};
		};
	};
};


 



