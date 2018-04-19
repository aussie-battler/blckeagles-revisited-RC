/*
	Mission Template by Ghostrider [GRG]
	Mission Compositions by Bill prepared for ghostridergaming
	Copyright 2016
	Last modified 3/20/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\privateVars.sqf";

//diag_log "[blckeagls] Spawning Red Mission with template = default";
_crateLoot = blck_BoxLoot_Red;
_lootCounts = blck_lootCountsRed;
_startMsg = "A group of Bandits was sighted in a nearby sector! Check the Red marker on your map for the location!";
_endMsg = "The Sector at the Red Marker is under survivor control!";
_markerLabel = "";
_markerType = ["ELIPSE",[200,200],"GRID"];
_markerColor = "ColorRed";
_markerMissionName = "Bandit Patrol";
_missionLandscapeMode = "random"; // acceptable values are "none","random","precise"
_missionLandscape = ["Land_WoodPile_F","Land_BagFence_Short_F","Land_WoodPile_F","Land_BagFence_Short_F","Land_WoodPile_F","Land_BagFence_Short_F","Land_FieldToilet_F","Land_TentDome_F","Land_TentDome_F","Land_TentDome_F","Land_TentDome_F","Land_CargoBox_V1_F","Land_CargoBox_V1_F"]; // list of objects to spawn as landscape

_missionLootBoxes = [];  //  Parameters are "Box Item Code", array defining the loot to be spawned, and position.
_missionLootVehicles = []; //  Parameters are "Box Item Code", array defining the loot to be spawned, and position.
_missionEmplacedWeapons = []; // can be used to define the precise placement of static weapons [[1,2,3] /*loc 1*/, [2,3,4] /*loc 2*/]; if blank random locations will be used
_minNoAI = blck_MinAI_Red;
_maxNoAI = blck_MaxAI_Red;
_noAIGroups = blck_AIGrps_Red;
_noVehiclePatrols = blck_SpawnVeh_Red;
_noEmplacedWeapons = blck_SpawnEmplaced_Red;
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;
_uniforms = blck_SkinList;
_headgear = blck_headgear;

_endCondition = "playerNear";  // Options are "allUnitsKilled", "playerNear", "allKilledOrPlayerNear"
//_timeOut = -1;
#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf"; 
