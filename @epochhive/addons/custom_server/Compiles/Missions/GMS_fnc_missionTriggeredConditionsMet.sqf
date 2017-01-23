/*
	test if either of two conditions is true:
		player within a specific range of the coordinates
		mission has timed out
	
	By Ghostrider-DbD-
	1/21/17
*/


params["_coords"];
private["_result"];
#define GMS_playerInRange 1
#define GMS_missionTimeOut 2

_result = 0;
if (blck_debugLevel > 2) then
{
	_result = GMS_playerInRange;
	diag_log format["_fnc_missionTriggeredConditionsMet::  -> Trigger conditions met with blck_debugLevel > 2 and _result set to %1",_result];
} else {		
	if ({ (isPlayer _x) && (_x distance _coords < blck_TriggerDistance) } count allPlayers > 0) then
	{
		_result = GMS_playerInRange;
		diag_log format["_fnc_missionTriggeredConditionsMet::  -> Trigger conditions met with player in range and _result set to %1",_result];
		
	} else
	{
		if ((diag_tickTime - _missionStartTime) > blck_MissionTimout) then
		{
			_result = GMS_missionTimeOut;
			diag_log format["_fnc_missionTriggeredConditionsMet::  -> Trigger conditions met with mission timed out and _result set to %1",_result];
		};
	};
};
if (blck_debugLevel > 0) then {diag_log format["_fnc_missionTriggeredConditionsMet:: _result returned = %1 at time %2:",_result,_diag_tickTime]; 

_result