

	params["_veh"];
	//diag_log format["blck_fnc_deleteAIvehicle:  _veh %1 deleted",_veh];
	{
		_veh removeAllEventHandlers _x;
	}forEach ["Hit","HitPart","GetIn","GetOut","Fired","FiredNear","HandleDamage","Reloaded"];
	blck_monitoredVehicles = blck_monitoredVehicles - [_veh];			
	deleteVehicle _veh;
