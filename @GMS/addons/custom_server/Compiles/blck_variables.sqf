/*
	AI Mission for Epoch Mod for Arma 3
	For the Mission System originally coded by blckeagls
	By Ghostrider
	Functions and global variables used by the mission system.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include"\q\addons\custom_server\Configs\blck_defines.hpp";

blck_debugON = true;
blck_debugLevel = 1;  // Sets level of detail for debugging info - WIP.
blck_minFPS = 8; 

////////////////////////////////////////////////
//  Do Not Touch Anything Below This Line
///////////////////////////////////////////////
blck_townLocations = []; //nearestLocations [blck_mapCenter, ["NameCity","NameCityCapital"], 30000];
blck_ActiveMissionCoords = [];
blck_recentMissionCoords = [];
blck_locationBlackList = [];
blck_monitoredVehicles = [];
blck_livemissionai = [];
blck_monitoredMissionAIGroups = [];  //  Used to track groups in active missions for whatever purpose
blck_oldMissionObjects = [];
blck_pendingMissions = [];
blck_missionsRunning = 0;
blck_activeMissions = [];
blck_deadAI = [];
blck_connectedHCs = [];
blck_missionMarkers = [];
#ifdef useDynamicSimulation
"Group" setDynamicSimulationDistance 1800;
enableDynamicSimulationSystem true;
#endif
// Arrays for use during cleanup of alive AI at some time after the end of a mission
DBD_HeliCrashSites = [];

// radius within whih missions are triggered. The trigger causes the crate and AI to spawn.
blck_TriggerDistance = 1000;
blck_mainThreadUpdateInterval = 60;
//blck_missionSpawning = false;
diag_log "[blckeagls] Variables Loaded";
blck_variablesLoaded = true;
