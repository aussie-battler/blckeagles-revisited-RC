//////////////////////////////////////////////////////
// test whether the start conditions for a mission have been met
// returns true when either a player is within _range meters of _pos or the time elapsed is greater than _timeoutTime
// by Ghostrider-DBD- 
// Last modified 1/12/17
/////////////////////////////////////////////////////

params ["_pos","_range","_timeoutInterval","_endCondition"];
private["_missionComplete","_timeoutTime"]; 
_startTime = diag_tickTime;
_timeoutTime = _startTime + _timeoutInterval;

if (blck_debugLevel isEqualTo 3) then
{
	uiSleep 60;
	diag_log "_fnc_missionStartConditionsMet::-> bypassing start conditions with blck_debugLevel == 3";
} else {
	waitUntil{uiSleep 1; (diag_tickTime - _startTime) > _timeoutTime || {(isPlayer _x) && (_pos distance _x) < _range} count allPlayers > 0};
};
true
