/*

	vehicles = count blck_HC_monitoredVehicles;
 */
diag_log "_fnc_HC_monitor.sqf";
 _blckGroups = 0;
 _otherGroups = 0;
 _totalGroups = 0;
 _timerOneSec =0;
 _timerSixtySec = 0;
 _timer3min = 0;
 while {true} do
 {
	if (diag_tickTime > _timerOneSec) then
	{
		_timerOneSec = diag_tickTime + 1;
		[] call blck_fnc_HC_vehicleMonitor;
	};
	if (diag_tickTime > _timerSixtySec) then
	{
		_timerSixtySec = diag_tickTime + 60;
		private _theGroups = blck_HC_monitoredGroups;
		{
			if (isNull _x) then {blck_HC_monitoredGroups = blck_HC_monitoredGroups - [_x]};
			if ( {alive _x} count (units _x) == 0) then { blck_HC_monitoredGroups = blck_HC_monitoredGroups - [_x]};
		} forEach _theGroups;
		//_blckGroups = count blck_HC_monitoredGroups;
		//_totalGroups = {(groupOwner _x) isEqualTo clientOwner} count allGroups;
		//_totalGroups = _blckGroups + _otherGroups;
		//diag_log format["blckHC:: headless client %1 ",_blckGroups,_otherGroups];
	};
	if (diag_tickTime > _timer3min) then
	{
		_timer3min = diag_tickTime + 300;
		diag_log format["blckHC:: headless client %1 | time stamp %2 | %3 fps | _blckGroups = %4 _otherGroups = %5 | vehicles %6",clientOwner,diag_tickTime,diag_fps, count blck_HC_monitoredGroups,{ ((groupOwner _x) isEqualTo clientOwner) && !(_x getVariable["blck_group",true])} count allGroups, count blck_HC_monitoredVehicles  ];	
	};
	uiSleep 1;
 };
