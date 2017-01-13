/*
AI Mission for Epoch and Exile Mods to Arma 3
Credist to blckeagls who wrote the initial mission script for A3 Epoch 
To Narines for debugging that original version
To cynwncler for many helpful comments along the way
And mostly importantly, 
To Vampire, KiloSwiss, blckeagls, theFUCHS, lazylink, Mark311 and Buttface (Face) who wrote the pionering mission and roaming AI systems upon which this one is based and who's code is used with modification in some parts of this addon.
*/
if !(isNil "blck_Initialized") exitWith{};
private["_blck_loadingStartTime"];
_blck_loadingStartTime = diag_tickTime;
#include "\q\addons\custom_server\init\build.sqf";
diag_log format["[blckeagls] Loading version %1 Build %2",_blck_versionDate,_blck_version];

call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\blck_variables.sqf";
waitUntil {(isNil "blck_variablesLoaded") isEqualTo false;};
waitUntil{blck_variablesLoaded};
blck_variablesLoaded = nil;
if !(blck_debugON) then {uiSleep 60;};

// compile functions
call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\blck_functions.sqf";
waitUntil {(isNil "blck_functionsCompiled") isEqualTo false;};
waitUntil{blck_functionsCompiled};
blck_functionsCompiled = nil;
diag_log format["[blckeagls] debug mode settings:blck_debugON = %1",blck_debugON];

private["_modType"];
_modType = [] call blck_fnc_getModType;

if (_modType isEqualTo "Epoch") then
{
	diag_log format["[blckeagls] Loading Mission System using Parameters for %1",_modType];
	execVM "\q\addons\custom_server\Configs\blck_configs_epoch.sqf";
	waitUntil {(isNil "blck_configsLoaded") isEqualTo false;};
	waitUntil{blck_configsLoaded};
	blck_configsLoaded = nil;
	diag_log "[blckeagles] Running getTraderCitiesEpoch to get location of trader cities";
	execVM "\q\addons\custom_server\Compiles\Functions\getTraderCitesEpoch.sqf";;
};
if (_modType isEqualTo "Exile") then
{
	diag_log format["[blckeagls] Loading Mission System using Parameters for %1",_modType];
	call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Configs\blck_configs_exile.sqf";
	waitUntil {(isNil "blck_configsLoaded") isEqualTo false;};
	waitUntil{blck_configsLoaded};
	blck_configsLoaded = nil;
	if (blck_blacklistTraderCities || blck_blacklistSpawns || blcklistConcreteMixerZones) then {execVM "\q\addons\custom_server\Compiles\Functions\getTraderCitesExile.sqf";};
};

// spawn map addons to give the server time to position them before spawning in crates etc.
if (blck_spawnMapAddons) then
{
	call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\MapAddons\MapAddons_init.sqf";
}else{
	diag_log "[blckegls] Map Addons disabled";
};
blck_spawnMapAddons = nil;

diag_log "[blckeagls] Loading Map-specific information";
execVM "\q\addons\custom_server\Compiles\Functions\GMS_fnc_findWorld.sqf";
waitUntil {(isNil "blck_worldSet") isEqualTo false;};
waitUntil{blck_worldSet};
blck_worldSet = nil;

// set up the lists of available missions for each mission category
diag_log "[blckeagls] Loading Mission Lists";
#include "\q\addons\custom_server\Missions\GMS_missionLists.sqf";

// Load any user-defined specifications or overrides
call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Configs\blck_custom_config.sqf";

diag_log format["[blckeagls] version %1 Build %2 for mod = %3 Loaded in %4 seconds",_blck_versionDate,_blck_version,_modType,diag_tickTime - _blck_loadingStartTime]; //,blck_modType];
diag_log format["blckeagls] waiting for players to join ----    >>>>"];
if (!blck_debugON || (blck_debugLevel isEqualTo 0)) then
{
	waitUntil{{isPlayer _x}count playableUnits > 0};
};
diag_log "[blckeagls] Player Connected, loading mission system";

if (blck_spawnStaticLootCrates) then
{
	blck_SLSComplete = false;
	// Start the static loot crate spawner
	[] execVM "\q\addons\custom_server\SLS\SLS_init.sqf";
	waitUntil {(isNil "blck_SLSComplete") isEqualTo false;};
	waitUntil{blck_SLSComplete};
	blck_SLSComplete = nil;
}else{
	diag_log "[blckeagls] SLS::  -- >>  Static Loot Spawner disabled";
};
blck_spawnStaticLootCrates = nil;

//Start the mission timers
if (blck_enableOrangeMissions > 0) then
{
	[_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange] spawn blck_fnc_missionTimer;//Starts major mission system (Orange Map Markers)
	//[_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange,blck_enableOrangeMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableGreenMissions > 0) then
{
	[_missionListGreen,_pathGreen,"GreenMarker","green",blck_TMin_Green,blck_TMax_Green] spawn blck_fnc_missionTimer;//Starts major mission system 2 (Green Map Markers)
	//[_missionListGreen,_pathGreen,"GreenMarker","green",blck_TMin_Green,blck_TMax_Green,blck_enableGreenMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableRedMissions > 0) then
{
	[_missionListRed,_pathRed,"RedMarker","red",blck_TMin_Red,blck_TMax_Red] spawn blck_fnc_missionTimer;//Starts minor mission system (Red Map Markers)//Starts minor mission system 2 (Red Map Markers)
	//[_missionListRed,_pathRed,"RedMarker","red",blck_TMin_Red,blck_TMax_Red,blck_enableRedMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableBlueMissions > 0) then
{
	[_missionListBlue,_pathBlue,"BlueMarker","blue",blck_TMin_Blue,blck_TMax_Blue] spawn blck_fnc_missionTimer;//Starts minor mission system (Blue Map Markers)
	//[_missionListBlue,_pathBlue,"BlueMarker","blue",blck_TMin_Blue,blck_TMax_Blue,blck_enableBlueMissions] call blck_fnc_addMissionToQue;
};

//  start the main thread for the mission system which monitors missions running and stuff to be cleaned up
call compile preprocessfilelinenumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_mainThread.sqf";
//call compile preprocessfilelinenumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_vehicleMonitorLoop.sqf";

// start a little loop that sends clients the current serverFPS
//[] execVM "\q\addons\custom_server\Compiles\Functions\broadcastServerFPS.sqf";
diag_log "[blckeagls] >>--- Completed initialization"; 

blck_Initialized = true;
publicVariable "blck_Initialized";
