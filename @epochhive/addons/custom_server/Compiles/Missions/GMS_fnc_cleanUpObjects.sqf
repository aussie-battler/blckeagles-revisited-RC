	// Delete objects in a list after a certain time.
	// code to delete any smoking or on fire objects adapted from kalania 
	//http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page1
	// http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page2
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 1-22-17
*/

params["_objects"];
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
		deleteVehicle _x;
	};
} forEach _objects;

	


 



