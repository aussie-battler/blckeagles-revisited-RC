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

private ["_markerLabel","_endMsg","_startMsg","_lootCounts","_crateLoot","_markerMissionName","_missionLandscapeMode","_missionLandscape",
	"_missionLootBoxes","_missionLootVehicles","_missionEmplacedWeapons","_minNoAI","_maxNoAI","_noAIGroups","_noVehiclePatrols","_noEmplacedWeapons",
	"_uniforms","_headgear","_chanceReinforcements","_noPara","_helipatrol","_endCondition","_markerColor","_markerType","_useMines"];

//diag_log "[blckeagls] Spawning Blue Mission with template = default2";

_crateLoot = blck_BoxLoot_Blue;
_lootCounts = blck_lootCountsBlue;
_startMsg = "A group of Bandits was sighted in a nearby sector! Check the Blue marker on your map for the location!";
_endMsg = "The Sector at the Blue Marker is under survivor control!";
_markerLabel = "";
_markerType = ["ELIPSE",[175,175],"GRID"];
_markerColor = "ColorBlue";
_markerMissionName = "Bandit Patrol";
_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"
_missionLandscape = [
		["Flag_AAF_F",[0,0,0],0,[false,false]],
		["Land_dp_transformer_F",[1.698242,-10.4668,-0.00763702],271.32,1,0,[],"","",true,false], 
		["Land_Wreck_BRDM2_F",[1.37012,13.498,0.00109863],184.487,0.00819469,0.830999,[],"","",true,false], 
		["Land_BagBunker_Small_F",[18.4512,-3.66406,0.00780487],305.003,1,0,[],"","",true,false], 
		["Land_Cargo_HQ_V1_F",[-20.1367,11.7539,0],90.8565,1,0,[],"","",true,false], 
		["Land_BagBunker_Small_F",[-22.707,-3.75586,-0.0130234],44.9901,1,0,[],"","",true,false], 
		["Land_Cargo_House_V1_F",[24.3584,7.45313,0.00111389],91.6329,1,0,[],"","",true,false], 
		["StorageBladder_01_fuel_forest_F",[1.29492,29.3184,0.000999451],179.65,1,0,[],"","",true,false], 
		["Land_GarbageBags_F",[-9.45996,31.252,0.02005],184.595,1,0,[],"","",true,false], 
		["Land_GarbageBags_F",[-13.0459,32.668,-0.0283051],184.595,1,0,[],"","",true,false], 
		["Land_GarbageBags_F",[-11.5957,33.125,-0.598007],184.595,1,0,[],"","",true,false], 
		["Land_GarbageBags_F",[-8.98145,34.5801,-0.00514221],184.592,1,0,[],"","",true,false], 
		["Land_Addon_02_V1_ruins_F",[24.8369,24.6582,-0.00820923],90.9637,1,0,[],"","",true,false], 
		["Land_GarbageBags_F",[-10.9443,35.0449,0.577057],184.592,1,0,[],"","",true,false], 
		["Land_Cargo20_military_green_F",[14.6533,32.9004,0.000480652],90.0989,1,0,[],"","",true,false], 
		["Land_BagBunker_Small_F",[-23.0186,28.6738,-0.0271301],120.012,1,0,[],"","",true,false], 
		["Land_BagBunker_Small_F",[37.1504,34.5742,0.0146866],255,1,0,[],"","",true,false]
		]; // list of objects to spawn as landscape; // list of objects to spawn as landscape
_missionLootBoxes = [
		["Box_NATO_Wps_F",[3,-3,0],_crateLoot,[4,10,2,5,5,1]],  // Standard loot crate with standard loadout
		["Land_PaperBox_C_EPOCH",[-4,-3,0],_crateLoot,[0,0,0,10,10,3]],  	// No Weapons, Magazines, or optics; 10 each construction supplies and food/drink items, 3 backpacks
		["Land_CargoBox_V1_F",[3,4,0],_crateLoot,[0,10,2,5,5,1]]
		];  //  Parameters are "Box Item Code", array defining the loot to be spawned, and position.
		// blck_lootCountsBlue= [4,12,3,6,6,1];
_missionLootVehicles = [
	//["I_G_Offroad_01_armed_F",[-8,8,0],_crateLoot,[0,10,2,5,5,1]],
	//["I_G_Offroad_01_armed_F",[8,17,0],_crateLoot,[0,10,2,5,5,1]]
	]; //  Parameters are "vehiclel type", offset relative to mission center, loot array, items to load from each category of the loot array.
	//  ["B_HMG_01_high_F"/*,"B_GMG_01_high_F","O_static_AT_F"*/];
_missionGroups = 
	[
	//_x params["_position","_minAI","_maxAI","_skillLevel","_minPatrolRadius","_maxPatrolRadius"];
	[[-10.9121,-10.9824,-1.20243],5,7,"Green",5,12],
	[[-10.2305,10.0215,-0.941586],5,7,"Green",5,12],
	[[10.5605,-10.4043,-0.00143886],5,7,"Green",5,12],
	[[10.61133,10.5918,-0.001438863],5,7,"Green",5,12]
	]; // Can be used to define spawn positions of AI patrols
	
_missionEmplacedWeapons = [
	//["B_HMG_01_high_F",[-10,-15,0]],
	//["B_GMG_01_high_F",[10,12,0]],
	//["O_static_AT_F",[-10,10,0]]
	]; // can be used to define the type and precise placement of static weapons [["wep",[1,2,3]] /*loc 1*/, [2,3,4] /*loc 2*/]; if blank random locations will be used
_missionPatrolVehicles = [
	["B_MRAP_01_hmg_F",[27.8945,100.275,0],0,[true,false]],
	["B_MRAP_01_hmg_F",[-84.7793,72.2617,9.53674e-007],0,[true,false]],
	["B_MRAP_01_gmg_F",[-87.8457,-109.947,7.15256e-007],0,[true,false]],
];	
//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;
_minNoAI = blck_MinAI_Blue;
_maxNoAI = blck_MaxAI_Blue;
_noAIGroups = blck_AIGrps_Blue;
_noVehiclePatrols = blck_SpawnVeh_Blue;
_noEmplacedWeapons = blck_SpawnEmplaced_Blue;
_uniforms = blck_SkinList;
_headgear = blck_headgear;
_chanceReinforcements = blck_chanceParaBlue; 
_noPara = blck_noParaBlue;  
_chanceHeliPatrol = blck_chanceHeliPatrolBlue;
_endCondition = "playerNear";  // Options are "allUnitsKilled", "playerNear", "allKilledOrPlayerNear"
//_timeOut = -1;
#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf";
