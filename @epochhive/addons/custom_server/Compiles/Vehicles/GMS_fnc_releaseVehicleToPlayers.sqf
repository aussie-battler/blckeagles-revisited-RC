/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle.
	
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 3-24-17
*/

	params["_v"];
	//diag_log format["_fnc_releastVehicletoPlayers.sqf: removing vehicle %1 from ",_v,blck_missionVehicles];	
	//blck_missionVehicles = blck_missionVehicles - [_v];
	_v removeAllEventHandlers "GetIn";
	_v removeAllEventHandlers "GetOut";
	_v removeAllEventHandlers "Fired";
	_v removeAllEventHandlers "Reloaded";	
	_v setVehicleLock "UNLOCKED" ;
	_v setVariable["releasedToPlayers",true];
	[_v] call blck_fnc_emptyObject;
	
	
	//{
		//_v removealleventhandlers _x;
	//}forEach["Fired","Hit","HitPart","Reloaded","Dammaged","HandleDamage","GetIn","GetOut"];
	
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_v];
	};
	#endif




