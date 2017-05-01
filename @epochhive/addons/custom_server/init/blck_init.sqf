/*
	AI Mission for Epoch and Exile Mods to Arma 3
	Credist to blckeagls who wrote the initial mission script for A3 Epoch 
	To Narines for debugging that original version
	To cynwncler for many helpful comments along the way
	And mostly importantly, 
	To Vampire, KiloSwiss, blckeagls, theFUCHS, lazylink, Mark311 and Buttface (Face) who wrote the pionering mission and roaming AI systems upon which this one is based and who's code is used with modification in some parts of this addon.

	By Ghostrider-DbD
	Last Modified 3-18-17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if !(isNil "blck_Initialized") exitWith{};
private["_blck_loadingStartTime"];
_blck_loadingStartTime = diag_tickTime;
#include "\q\addons\custom_server\init\build.sqf";
diag_log format["[blckeagls] Loading version %1 Build %2",_blck_versionDate,_blck_version];

#ifdef DBDserver
diag_log "[blckegls] Running DBD Clan Version";
#endif

call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\blck_variables.sqf";
waitUntil {(isNil "blck_variablesLoaded") isEqualTo false;};
waitUntil{blck_variablesLoaded};
blck_variablesLoaded = nil;
//if !(blck_debugON) then {uiSleep 60;};

// compile functions
call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\blck_functions.sqf";
waitUntil {(isNil "blck_functionsCompiled") isEqualTo false;};
waitUntil{blck_functionsCompiled};
blck_functionsCompiled = nil;
diag_log format["[blckeagls] debug mode settings:blck_debugON = %1 blck_debugLevel = %2",blck_debugON,blck_debugLevel];

execVM "\q\addons\custom_server\Configs\blck_configs.sqf";
waitUntil {(isNil "blck_configsLoaded") isEqualTo false;};
waitUntil{blck_configsLoaded};
blck_configsLoaded = nil;

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

#ifdef DBDserver
//start the dynamic loot crate system
[] execVM "\q\addons\custom_server\DLS\DLS_init.sqf";
waitUntil {(isNil "blck_DLSComplete") isEqualTo false;};
waitUntil{blck_DLSComplete};
blck_DLSComplete = nil;
#endif

// Load any user-defined specifications or overrides
call compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Configs\blck_custom_config.sqf";

diag_log format["[blckeagls] version %1 Build %2 Loaded in %3 seconds",_blck_versionDate,_blck_version,diag_tickTime - _blck_loadingStartTime]; //,blck_modType];
diag_log format["blckeagls] waiting for players to join ----    >>>>"];

if !(blck_debugON || (blck_debugLevel isEqualTo 0)) then
{
	waitUntil{{isPlayer _x}count playableUnits > 0};
	diag_log "[blckeagls] Player Connected, spawning missions";
} else {
	diag_log "[blckeagls] spawning Missions";
};

if (blck_spawnStaticLootCrates) then
{
	// Start the static loot crate spawner
	diag_log "[blckeagls] SLS::  -- >>  Static Loot Spawner Started";
	[] execVM "\q\addons\custom_server\SLS\SLS_init.sqf";
	waitUntil {(isNil "blck_SLSComplete") isEqualTo false;};
	waitUntil{blck_SLSComplete};
	blck_SLSComplete = nil;
	diag_log "[blckeagls] SLS::  -- >>  Static Loot Spawner Done";
}else{
	diag_log "[blckeagls] SLS::  -- >>  Static Loot Spawner disabled";
};

//Start the mission timers
if (blck_enableOrangeMissions > 0) then
{
	//[_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange] spawn blck_fnc_missionTimer;//Starts major mission system (Orange Map Markers)
	[_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange,blck_enableOrangeMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableGreenMissions > 0) then
{
	//[_missionListGreen,_pathGreen,"GreenMarker","green",blck_TMin_Green,blck_TMax_Green] spawn blck_fnc_missionTimer;//Starts major mission system 2 (Green Map Markers)
	[_missionListGreen,_pathGreen,"GreenMarker","green",blck_TMin_Green,blck_TMax_Green,blck_enableGreenMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableRedMissions > 0) then
{
	//[_missionListRed,_pathRed,"RedMarker","red",blck_TMin_Red,blck_TMax_Red] spawn blck_fnc_missionTimer;//Starts minor mission system (Red Map Markers)//Starts minor mission system 2 (Red Map Markers)
	[_missionListRed,_pathRed,"RedMarker","red",blck_TMin_Red,blck_TMax_Red,blck_enableRedMissions] call blck_fnc_addMissionToQue;
};
if (blck_enableBlueMissions > 0) then
{
	//[_missionListBlue,_pathBlue,"BlueMarker","blue",blck_TMin_Blue,blck_TMax_Blue] spawn blck_fnc_missionTimer;//Starts minor mission system (Blue Map Markers)
	[_missionListBlue,_pathBlue,"BlueMarker","blue",blck_TMin_Blue,blck_TMax_Blue,blck_enableBlueMissions] call blck_fnc_addMissionToQue;
};
#ifdef DBDserver
if (blck_enableScoutsMissions > 0) then
{
	//[_missionListScouts,_pathScouts,"ScoutsMarker","red",blck_TMin_Scouts,blck_TMax_Scouts] spawn blck_fnc_missionTimer;
	[_missionListScouts,_pathScouts,"ScoutsMarker","red",blck_TMin_Scouts,blck_TMax_Scouts,blck_enableScoutsMissions, false] call blck_fnc_addMissionToQue;
};
if (blck_enableHunterMissions > 0) then
{
	//[_missionListHunters,_pathHunters,"HunterMarker","green",blck_TMin_Hunter,blck_TMax_Hunter] spawn blck_fnc_missionTimer;
	//  params["_missionList","_path","_marker","_difficulty","_tMin","_tMax","_noMissions"];
	[_missionListHunters,_pathHunters,"HunterMarker","green",blck_TMin_Hunter,blck_TMax_Hunter,blck_enableHunterMissions, false] call blck_fnc_addMissionToQue;
};

// Running new version of Crash sites.
if (blck_maxCrashSites > 0) then
{
	[] execVM "\q\addons\custom_server\Missions\HeliCrashs\Crashes2.sqf";
};
#endif

//  start the main thread for the mission system which monitors missions running and stuff to be cleaned up
[] spawn blck_fnc_mainThread;
diag_log "[blckeagls] Mission spawner started";