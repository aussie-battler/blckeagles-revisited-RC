//////////////////////////////////////////////////////
// test if a timeout condition exists.
// by Ghostrider [GRG] 
// Last modified 1/22/17
// [_startTime] call blck_fnc_timedOut
// Returns true (timed out) or false (not timed out)
/*
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
/////////////////////////////////////////////////////

params["_startTime",["_timeoutTime",blck_MissionTimout]];
private["_return"];
if ((diag_tickTime - _startTime) > _timeoutTime) then {_return = true} else {_return = false};
//diag_log format["fnc_timedOut:: blck_MissionTimout = %2 || _return = %1",_return,blck_MissionTimout];
_return;
