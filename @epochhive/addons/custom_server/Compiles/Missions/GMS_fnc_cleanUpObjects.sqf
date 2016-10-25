	// Delete objects in a list after a certain time.
	// code to delete any smoking or on fire objects adapted from kalania 
	//http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page1
	// http://forums.bistudio.com/showthread.php?165184-Delete-Fire-Effect/page2
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 8-13-16
*/
	params["_buildings"];
	{
			//diag_log format["cleanupObjects.sqf: -- >> object %1 is typeOf %2",_x, typeOf _x];		
			deleteVehicle _x;
	} forEach _buildings;

	


 



