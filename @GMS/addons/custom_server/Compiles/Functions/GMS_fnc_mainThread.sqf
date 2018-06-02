/*
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//diag_log format["starting _fnc_mainThread with time = %1",diag_tickTime];

#ifdef GRGserver
diag_log "running GRGserver version of _fnc_mainThread";
#endif

private["_timer1sec","_timer5sec","_timer20sec","_timer5min","_timer5min"];
_timer1sec = diag_tickTime;
_timer5sec = diag_tickTime;
_timer20sec = diag_tickTime;
_timer1min = diag_tickTime;
_timer5min = diag_tickTime;

while {true} do
{
	uiSleep 1;
	//diag_log format["mainThread:: -- > time = %1",diag_tickTime];
	if (diag_tickTime > _timer1sec) then 
	{
		[] call blck_fnc_vehicleMonitor;
		#ifdef GRGserver
		[] call blck_fnc_broadcastServerFPS;
		#endif
		_timer1sec = diag_tickTime + 1;
		//diag_log format["[blckeagls] _fnc_mainThread 1 Second Timer Handled | Timstamp %1",diag_tickTime];
	};
	if (diag_tickTime > _timer5sec) then
	{
		_timer5sec = diag_tickTime + 5;
		[] call blck_fnc_missionGroupMonitor;
		[] call blck_fnc_sm_monitorStaticMissionUnits;
		//[] call blck_fnc_sm_checkForPlayerNearMission;
		//diag_log format["[blckeagls] _fnc_mainThread 5 Second Timer Handled | Timstamp %1",diag_tickTime];
	};
	if (diag_tickTime > _timer20sec) then
	{
		[] call blck_fnc_cleanupAliveAI;
		[] call blck_fnc_cleanupObjects;
		[] call blck_fnc_cleanupDeadAI;
		_timer20sec = diag_tickTime + 20;
		//diag_log format["[blckeagls] _fnc_mainThread 20 Second Timer Handled | Timstamp %1",diag_tickTime];
	};
	if ((diag_tickTime > _timer1min)) then
	{
		//diag_log format["_fnc_mainThread:  60 second events run at %1",diag_tickTime];
		_timer1min = diag_tickTime + 60;
		//diag_log format["_fnc_mainThread: blck_missionsRunning = %1 | blck_maxSpawnedMissions = %2", blck_missionsRunning,blck_maxSpawnedMissions];
		[] call blck_fnc_spawnPendingMissions;
		//diag_log format["_fnc_mainThread: blck_numberUnderwaterDynamicMissions = %1 | blck_dynamicUMS_MissionsRuning = %2",blck_numberUnderwaterDynamicMissions,blck_dynamicUMS_MissionsRuning];
		if (blck_dynamicUMS_MissionsRuning < blck_numberUnderwaterDynamicMissions) then
		{
			//diag_log "Adding dynamic UMS Mission";
			[] spawn blck_fnc_addDyanamicUMS_Mission;
		};
		//diag_log format["_fnc_mainThread:  control returned to _fnc_mainThread from _fnc_addDynamicUMS_Mission at %1",diag_tickTime];
		if (blck_useHC) then
		{
			//diag_log format["_mainThread:: calling blck_fnc_passToHCs at diag_tickTime = %1",diag_tickTime];
			[] call blck_fnc_HC_passToHCs;
		};
		if (blck_useTimeAcceleration) then
		{
			[] call blck_fnc_timeAcceleration;
		};
		#ifdef blck_debugMode
		//diag_log format["_fnc_mainThread: active SQFscripts include: %1",diag_activeSQFScripts];
		diag_log format["_fnc_mainThread: active scripts include: %1",diag_activeScripts];
		#endif
		//diag_log format["[blckeagls] _fnc_mainThread 60 Second Timer Handled | Timstamp %1",diag_tickTime];
	};
	if (diag_tickTime > _timer5min) then 
	{
		diag_log format["[blckeagls] Timstamp %8 |Dynamic Missions Running %1 | UMS Running %2 | Vehicles %3 | Groups %4 | Server FPS %5 | Server Uptime %6 Min | Missions Run %7",blck_missionsRunning,blck_dynamicUMS_MissionsRuning,count blck_monitoredVehicles,count blck_monitoredMissionAIGroups,diag_FPS,floor(diag_tickTime/60),blck_missionsRun, diag_tickTime];
		_timer5min = diag_tickTime + 300;
	};
};
