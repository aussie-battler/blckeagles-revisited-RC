

	params["_veh"];
	//blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
	_veh setVehicleLock "UNLOCKED" ;
	//_v setVariable["releasedToPlayers",true];
	//[_v] call blck_fnc_emptyObject;
	{
		_veh removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	{
		_veh removeAllMPEventHandlers _x;
	} forEach ["MPHit","MPKilled"];
	_veh setVariable["blck_releasedAt",diag_tickTime,true];
	_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer,true];
	if ((damage _veh) > 0.5) then {_veh setDamage 0.5};
	//diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1 and blck_deleteAT = %2",_veh, _veh getVariable["blck_DeleteAt",0]];	
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_veh];
	};
	#endif
