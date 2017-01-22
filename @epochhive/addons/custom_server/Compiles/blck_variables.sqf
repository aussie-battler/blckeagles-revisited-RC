/*
	AI Mission for Epoch Mod for Arma 3
	For the Mission System originally coded by blckeagls
	By Ghostrider
	Functions and global variables used by the mission system.
	Last modified 10/25/16
*/
//blck_variablesLoaded = false;
blck_debugON = true;
blck_debugLevel = 3;  // Sets level of detail for debugging info - WIP.
blck_minFPS = 10;

////////////////////////////////////////////////
//  Do Not Touch Anything Below This Line
///////////////////////////////////////////////
blck_townLocations = []; //nearestLocations [blck_mapCenter, ["NameCity","NameCityCapital"], 30000];
blck_ActiveMissionCoords = [];
blck_recentMissionCoords = [];
blck_locationBlackList = [];
blck_monitoredVehicles = [];
blck_liveMissionAI = [];
blck_oldMissionObjects = [];
blck_pendingMissions = [];
blck_activeMissions = [];
blck_deadAI = [];
blck_missionVehicles = [];

// Arrays for use during cleanup of alive AI at some time after the end of a mission
DBD_HeliCrashSites = [];

// radius within whih missions are triggered. The trigger causes the crate and AI to spawn.
blck_TriggerDistance = 1000;
blck_mainThreadUpdateInterval = 60;
//blck_missionSpawning = false;
diag_log "[blckeagls] Variables Loaded";
blck_variablesLoaded = true;
