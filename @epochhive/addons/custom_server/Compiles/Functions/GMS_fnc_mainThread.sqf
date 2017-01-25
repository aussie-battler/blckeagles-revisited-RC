/*
	Call as : [] call blck_fnc_mainThread;
	
	Run a loop that checks data arrays regarding:
	- whether it is time to delete the mission objects at a specific location
	- whether it is time to delete live AI associated with a specific mission
	By Ghostrider-DbD-
	Last modified 1-24-17
*/
diag_log format["starting _fnc_mainThread with time = %1",diag_tickTime];
private["_modType","_timer1sec","_timer20sec","_timer5min"];
_timer1sec = diag_tickTime;
_timer20sec = diag_tickTime;
_timer5min = diag_tickTime;
_modType = [] call blck_fnc_getModType;
while {true} do
{
	uiSleep 1;
	diag_log format["mainThread:: -- > time = %1",diag_tickTime];
	if (diag_tickTime - _timer1sec > 1000) then 
	{
		[] call blck_fnc_vehicleMonitor;
		_timer1sec - diag_tickTime;
	};
	if (diag_tickTime - _timer20sec > 20) then
	{
		[] call blck_fnc_cleanupAliveAI;
		[] call blck_fnc_cleanupObjects;
		[] call blck_fnc_cleanupDeadAI;
		[] call blck_fnc_spawnPendingMissions;
		if (_modType isEqualTo "Epoch") then 
		{
			[] call blck_fnc_cleanEmptyGroups;
		};  // Exile cleans up empty groups automatically so this should not be needed with that mod.		
		_timer20sec = diag_tickTime;
	};
	if (diag_tickTime - _timer5min > 300) then
	{
		[] call blck_fnc_timeAcceleration;	
	};

};
