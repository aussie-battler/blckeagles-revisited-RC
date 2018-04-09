/*

 */
diag_log "_fnc_HCmonitor.sqf";
 _blckGroups = 0;
 _otherGroups = 0;
 _totalGroups = 0;
 
 while {true} do
 {
	_blckGroups = {_x getVariable["blck_group",false] && (groupOwner _x isEqualTo clientOwner)} count allGroups;
	_totalGroups = {(groupOwner _x) isEqualTo clientOwner} count allGroups;
	_totalGroups = _blckGroups + _otherGroups;
	diag_log format["blckHC:: headless client %1 at diag_tickTime running %3 fps",clientOwner,diag_tickTime,diag_fps];
	diag_log format["blckHC:: headless client %1 _blckGroups = %1 and _otherGroups = %2",_blckGroups,_otherGroups];
	uiSleep 60;
 };
