/*

 */
diag_log "_fnc_HCmonitor.sqf";
 _blckGroups = 0;
 _otherGroups = 0;
 _totalGroups = 0;
 _timerOneSec =0;
 _timerSixtySec = 0;
 while {true} do
 {
	if (diag_tickTime > _timerOneSec) then
	{
		_timerOneSec = diag_tickTime;
		[] call blck_fnc_HC_vehicleMonitor;
	};
	if (diag_tickTime > _timerSixtySec) then
	{
		_timerSixtySec = diag_tickTime;
		_blckGroups = {_x getVariable["blck_group",false] && (groupOwner _x isEqualTo clientOwner)} count allGroups;
		_totalGroups = {(groupOwner _x) isEqualTo clientOwner} count allGroups;
		_totalGroups = _blckGroups + _otherGroups;
		diag_log format["blckHC:: headless client %1 at diag_tickTime running %3 fps",clientOwner,diag_tickTime,diag_fps];
		diag_log format["blckHC:: headless client %1 _blckGroups = %1 and _otherGroups = %2",_blckGroups,_otherGroups];
	};
	uiSleep 1;
 };
