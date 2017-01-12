/*
	AI Mission for Epoch Mod for Arma 3
	By Ghostrider
	Functions and global variables used by the mission system.
	Last modified 1/12/17
*/
blck_functionsCompiled = false;

// General functions
blck_fnc_waitTimer = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_waitTimer.sqf";
blck_fnc_FindSafePosn = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_findSafePosn.sqf"; 
blck_fnc_randomPosition = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_randomPosn.sqf";// find a randomPosn. see script for details.
blck_fnc_findPositionsAlongARadius  = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_findPositionsAlongARadius.sqf";
blck_fnc_giveTakeCrypto = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_giveTakeCrypto.sqf";
blck_fnc_monitorHC = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_monitorHC.sqf";
blck_fnc_timeAcceleration = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\TimeAccel\GMS_fnc_Time.sqf";
blck_fnc_getModType = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_getModType.sqf";  // Test if Epoch or Exile is loaded
blck_fnc_groupsOnAISide = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_GroupsOnAISide.sqf";  // Returns the number of groups on the side used by AI
blck_fnc_deleteFromArray = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_deleteFromArray.sqf"; 

// Player-related functions
blck_fnc_rewardKiller = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_rewardKiller.sqf";
blck_fnc_MessagePlayers = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_AIM.sqf";  // Send messages to players regarding Missions
//blck_fnc_sendRewardMessage = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_sendRewardMessage.sqf"; 

// Mission-related functions
blck_fnc_missionTimer = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionTimer.sqf";
blck_fnc_addMissionToQue  = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_addMissionToQue.sqf";  // 
blck_fnc_updateMissionQue  = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_updateMissionQue.sqf";  // 
blck_fnc_addLiveAItoQue = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_addLiveAItoQue.sqf"; 
blck_fnc_addObjToQue = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_addObjToQue.sqf";  //
blck_fnc_playerInRange = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_playerInRange.sqf";
blck_fnc_spawnCrate = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_spawnCrate.sqf"; // Simply spawns a crate of a specified type at a specific position.
blck_fnc_spawnMissionCrates = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_spawnMissionCrates.sqf";  // Spawn loot crates at specific positions relative to the mission center; these will be filled with loot following the parameters in the composition array for the mission
blck_fnc_cleanupObjects = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_cleanUpObjects.sqf";
blck_fnc_spawnCompositionObjects = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_spawnBaseObjects.sqf";
blck_fnc_spawnRandomLandscape = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_spawnRandomLandscape.sqf";
blck_fnc_addItemToCrate = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_addItemToCrate.sqf";
blck_fnc_loadLootItemsFromArray = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc__loadLootItemsFromArray.sqf";
blck_fnc_fillBoxes = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_fillBoxes.sqf"; // Adds items to an object according to passed parameters. See the script for details.
blck_fnc_smokeAtCrates = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_smokeAtCrates.sqf"; // Spawns a wreck and adds smoke to it
blck_fnc_spawnMines = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_spawnMines.sqf";  // Deploys mines at random locations around the mission center
blck_fnc_clearMines = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_clearMines.sqf"; // clears mines in an array passed as a parameter
blck_fnc_signalEnd = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Missions\GMS_fnc_signalEnd.sqf"; // deploy smoke grenades at loot crates at the end of the mission.

// Reinforcement-related functions
blck_fnc_callInReinforcements = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_callInReinforcements.sqf"; 
blck_fnc_dropReinforcements  = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_dropReinforcements.sqf"; 
blck_fnc_spawnHeliParaCrate  = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_spawnParaCrate.sqf"; 
blck_fnc_spawnParaCrate = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_spawnParaUnits.sqf"; 
blck_fnc_sendHeliHome = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_sendHeliHome.sqf"; 
//blck_fnc_spawnHeliPatrol = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_spawnParaUnits.sqf"; 
//blck_fnc_spawnHeliPatrol = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Reinforcements\GMS_fnc_spawnParaUnits.sqf"; 

// Group-related functions
blck_fnc_spawnGroup = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Groups\GMS_fnc_spawnGroup.sqf";  // Spawn a single group and populate it with AI units]
blck_fnc_setupWaypoints = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Groups\GMS_fnc_setWaypoints.sqf";  // Set default waypoints for a group
blck_fnc_cleanEmptyGroups = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Functions\GMS_fnc_cleanEmptyGroups.sqf";  // GMS_fnc_cleanEmptyGroups

// Functions specific to vehicles, whether wheeled or static
blck_fnc_spawnEmplacedWeapon = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_spawnEmplaced.sqf";  // Self-evident
blck_fnc_spawnVehicle = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_spawnVehicle.sqf";            //  Spawn a temporary vehicle of a specified type at a specific position
blck_fnc_spawnVehiclePatrol = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_spawnVehiclePatrol.sqf";  // Spawn an AI vehicle control and have it patrol the mission perimeter
blck_fnc_protectVehicle = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_protectVehicle.sqf";
blck_fnc_configureMissionVehicle = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_configureMissionVehicle.sqf";
blck_fnc_vehicleMonitor = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Vehicles\GMS_fnc_vehicleMonitor.sqf";   // Checks for vehicles for which all AI are dead and handles any changes needed when this is true.

// functions to support Units
blck_fnc_removeGear = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_removeGear.sqf"; // Strip an AI unit of all gear.
blck_fnc_spawnAI = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_spawnUnit.sqf"; // spawn individual AI
blck_EH_AIKilled = "\q\addons\custom_server\Compiles\Units\GMS_EH_AIKilled.sqf";  // Event handler to process AI deaths	
//blck_EH_AIHandleDamage = "\q\addons\custom_server\Compiles\Units\GMS_EH_AIHandleDamage.sqf"; //  GRMS_EH_AIHandleDamage
blck_fnc_processAIKill = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_processAIKill.sqf";
blck_fnc_removeLaunchers = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_removeLaunchers.sqf";
blck_fnc_removeNVG = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_removeNVG.sqf";
blck_fnc_alertNearbyUnits = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_alertNearbyUnits.sqf";
blck_fnc_processIlleagalAIKills = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_processIlleagalAIKills.sqf";
GMS_fnc_cleanupDeadAI = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_cleanupDeadAI.sqf"; // handles deletion of AI bodies and gear when it is time.
blck_fnc_setSkill = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_setSkill.sqf";
blck_fnc_cleanupAliveAI = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\Units\GMS_fnc_cleanupAliveAI.sqf";

diag_log "[blckeagls] Functions Loaded";
blck_functionsCompiled = true;
