#define tMin 600
#define tMax 900

params["_pos","_mission","_startTime"];

private["_dynamicMissions"];
_dynamicMissions = + blck_UMS_dynamicMissions;
{
	if (diag_tickTime > _timeAdded + round( tMin + (tMax - tMin) ) then
	{
		_pos = _x select 0;
		_mission = _x select 1;
		_timeAdded = _x select 2;
		blck_UMS_dynamicMissions = blck_UMS_dynamicMissions - _x;
		_pos call compileFinal preprocessFileLineNumbers format["q\addons\custom_server\Missions\UMS\dynamicMissions\%1.sqf",_mission];
	};
} forEach _dynamicMissions;