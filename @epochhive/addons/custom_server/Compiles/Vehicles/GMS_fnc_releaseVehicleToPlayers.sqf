/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle.
	
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 1-22-17
*/

	params["_v"];
	//diag_log format["vehicleMonitor.sqf: make vehicle available to players; stripping eventHandlers from _v %1",_v];	
	blck_missionVehicles = blck_missionVehicles - [_v];
	_v removealleventhandlers "GetIn";
	_v removealleventhandlers "GetOut";
	_v setVehicleLock "UNLOCKED" ;
	_v setVariable["releasedToPlayers",true];
	[_v] call blck_fnc_emptyObject;
	{
		_v removealleventhandlers _x;
	}forEach["fired","hit","hitpart","reloaded","dammaged","HandleDamage","getin","getout"];
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_v];
	};
	#endif




