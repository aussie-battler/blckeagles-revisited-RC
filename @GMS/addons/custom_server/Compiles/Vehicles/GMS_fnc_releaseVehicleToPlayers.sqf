/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle.
	
	By Ghostrider [GRG]
	Copyright 2016
	Last updated 3-24-17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_v"];
	//diag_log format["_fnc_releastVehicletoPlayers.sqf: removing vehicle %1 from ",_v,blck_monitoredVehicles];	
	//blck_monitoredVehicles = blck_monitoredVehicles - [_v];
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




