/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
diag_log "[blckeagls] GMS_fnc_sm_init_functions.sqf <Defining Variables and Compiling Functions>";
//blck_sm_Groups = [];
blck_sm_Infantry = [];
blck_sm_Vehicles = [];
blck_sm_Aircraft = [];
blck_sm_Emplaced = [];
blck_sm_scubaGroups = [];
blck_sm_surfaceShips = [];
blck_sm_submarines = [];

blck_sm_lootContainers = [];

blck_fnc_sm_AddGroupToArray = compileFinal  preprocessFileLineNumbers  "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_AddGroupToArray.sqf";

/*
blck_fnc_sm_AddGroup = compileFinal  preprocessFileLineNumbers  "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_AddGroup.sqf";
blck_fnc_sm_AddVehicle = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_AddVehicle.sqf";
blck_fnc_sm_AddAircraft = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_AddAircraft.sqf";
blck_fnc_sm_AddEmplaced = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_AddEmplaced.sqf";
*/

blck_fnc_sm_monitorStaticUnits = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorStaticPatrols.sqf";
blck_fnc_sm_monitorInfantry = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorInfantry.sqf";
blck_fnc_sm_monitorScuba = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorScuba.sqf";
blck_fnc_sm_monitorVehicles = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorVehicles.sqf";
blck_fnc_sm_monitorAircraft = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorAircraft.sqf";
blck_fnc_sm_monitorShips = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorShips.sqf";
blck_fnc_sm_monitorSubs = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorSubs.sqf";
blck_fnc_sm_monitorEmplaced = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorEmplaced.sqf";

blck_fnc_sm_spawnVehiclePatrol = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnVehiclePatrol.sqf";
blck_fnc_sm_spawnAirPatrol = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnAirPatrol.sqf";
blck_fnc_sm_spawnEmplaced = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnEmplaced.sqf";
//blck_fnc_sm_spawnInfantryPatrol = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnInfantryPatrol.sqf";
blck_fnc_sm_missionPatrolMonitor = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_monitorStaticPatrols.sqf";
//blck_fnc_sm_checkForPlayerNearMission = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_checkForPlayerNearMission.sqf";
blck_fnc_sm_spawnAirPatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnAirPatrols.sqf";
blck_fnc_sm_spawnEmplaceds = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnEmplaced.sqf";
blck_fnc_sm_spawnInfantryPatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnInfantryPatrols.sqf";
blck_fnc_sm_spawnLootContainers = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnLootContainers.sqf";
blck_fnc_sm_spawnObjects = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnObjects.sqf";
blck_fnc_sm_spawnVehiclePatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnVehiclePatrols.sqf";

diag_log "[blckeagls] GMS_sm_init_functions.sqf <Variables Defined and Functions Loaded>";

blck_sm_functionsLoaded = true;
