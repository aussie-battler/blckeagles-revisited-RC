//////////////////////////////////////////////////////
// test if a timeout condition exists.
// by Ghostrider-DBD- 
// Last modified 1/22/17
// [_startTime] call blck_fnc_timedOut
// Returns true (timed out) or false (not timed out)
/////////////////////////////////////////////////////

params["_startTime"];
private["_return"];
if ((diag_tickTime - _startTime) > blck_MissionTimout ) then {_return = true} else {_return = false};
//diag_log format["fnc_timedOut:: blck_MissionTimout = %2 || _return = %1",_return,blck_MissionTimout];
_return;
