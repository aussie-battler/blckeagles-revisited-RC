//////////////////////////////////////////////////////
// test if a timeout condition exists.
// by Ghostrider-DBD- 
// Last modified 1/9/17
// [_startTime] call blck_fnc_timedOut
// Returns true (timed out) or false (not timed out)
/////////////////////////////////////////////////////

params["_startTime"];
private["_return"];
_return = ( (diag_tickTime - _startTime) > blck_MissionTimout );
_return;
