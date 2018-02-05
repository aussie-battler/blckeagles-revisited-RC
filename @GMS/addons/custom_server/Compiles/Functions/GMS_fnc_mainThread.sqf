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

private["_modType","_timer1sec","_timer5sec","_timer20sec","_timer5min","_timer5min"];
_timer1sec = diag_tickTime;
_timer5sec = diag_tickTime;
_timer20sec = diag_tickTime;
_timer1min = diag_tickTime;
_timer5min = diag_tickTime;
_modType = [] call blck_fnc_getModType;
while {true} do
{
	uiSleep 1;
	//diag_log format["mainThread:: -- > time = %1",diag_tickTime];
	if (diag_tickTime - _timer1sec > 1) then 
	{
		[] call blck_fnc_vehicleMonitor;
		#ifdef GRGserver
		[] call blck_fnc_broadcastServerFPS;
		#endif
		_timer1sec = diag_tickTime;
	};
	if (diag_tickTime - _timer5sec > 5) then
	{
		_timer5sec = diag_tickTime;
		[] call blck_fnc_missionGroupMonitor;
		[] call blck_fnc_sm_monitorStaticMissionUnits;
		//[] call blck_fnc_sm_checkForPlayerNearMission;
	};
	if (diag_tickTime - _timer20sec > 20) then
	{
		[] call blck_fnc_cleanupAliveAI;
		[] call blck_fnc_cleanupObjects;
		[] call blck_fnc_cleanupDeadAI;
		_timer20sec = diag_tickTime;
		//diag_log format["_mainThread::-->> 20 second events run: diag_tickTime = %1",diag_tickTime];
	};
	if ((diag_tickTime - _timer1min) > 60) then
	{
		//diag_log format["_fnc_mainThread:  60 second events run at %1",diag_tickTime];
		_timer1min = diag_tickTime;
		[] call blck_fnc_spawnPendingMissions;
		//diag_log format["_fnc_spawnPendingMissions: blck_numberUnderwaterDynamicMissions = %1 | 
		if (blck_dynamicUMS_MissionsRuning < blck_numberUnderwaterDynamicMissions) then
		{
			//diag_log "Adding dyanamic UMS Mission";
			private ["_spawnPos"];
			_spawnPos = call blck_fnc_findShoreLocation;
			[_spawnPos] spawn blck_fnc_addDyanamicUMS_Mission;
			//_spawnPos call compileFinal preprocessFileLineNumbers format["q\addons\custom_server\Missions\UMS\dynamicMissiones\%1.sqf";
		};
		//diag_log format["_fnc_mainThread:  control returned to _fnc_mainThread from _fnc_addDynamicUMS_Mission at %1",diag_tickTime];
		if (blck_useHC) then
		{
			//diag_log format["_mainThread:: calling blck_fnc_passToHCs at diag_tickTime = %1",diag_tickTime];
			[] call blck_fnc_passToHCs;
		};
		//[] call blck_fnc_missionGroupMonitor;
		/*
		// No longer needed 
		if (_modType isEqualTo "Epoch") then 
		{
			[] call blck_fnc_cleanEmptyGroups;
		};  // Exile cleans up empty groups automatically so this should not be needed with that mod.		
		*/
		#ifdef blck_debugMode
		//diag_log format["_fnc_mainThread: active SQFscripts include: %1",diag_activeSQFScripts];
		diag_log format["_fnc_mainThread: active scripts include: %1",diag_activeScripts];
		#endif
	};
	if (diag_tickTime - _timer5min > 300) then 
	{
		if (blck_useTimeAcceleration) then
		{
			_timer5min = diag_tickTime;
			[] call blck_fnc_timeAcceleration;
		};
	};
};
