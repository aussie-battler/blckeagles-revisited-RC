/*
	Mission Template by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

private ["_markerLabel","_endMsg","_startMsg","_lootCounts","_crateLoot","_markerMissionName","_missionLandscapeMode","_missionLandscape",
	"_missionLootBoxes","_missionLootVehicles","_missionEmplacedWeapons","_minNoAI","_maxNoAI","_noAIGroups","_noVehiclePatrols","_noEmplacedWeapons",
	"_uniforms","_headgear","_chanceReinforcements","_noPara","_helipatrol","_endCondition","_markerColor","_markerType","_useMines","_hostageConfig"];

//diag_log "[blckeagls] Spawning Blue Mission with template = default2";

_crateLoot = blck_BoxLoot_Blue;
_lootCounts = blck_lootCountsBlue;
_startMsg = "A local town mayor is being held hostage! Free him and earn a reward!";
_endMsg = "The Sector at the Blue Marker is under survivor control!";
_assetKilledMsg = "Hostage Killed and Bandits Fled with All Loot: Mission Aborted";
_markerLabel = "";
_markerType = ["ELIPSE",[175,175],"GRID"];
_markerColor = "ColorBlue";
_markerMissionName = "Rescue Hostage";
_missionLandscapeMode = "precise"; // acceptable values are "none","random","precise"
_missionLandscape = [
		//["Land_i_House_Small_01_V2_F",[-2.27148,15.7852,0],0,[true,false]],
		["Flag_AAF_F",[0.851563,-32.0098,0],0,[true,false]]
	]; // list of objects to spawn as landscape; // list of objects to spawn as landscape
	
_hostageConfig = ["C_man_polo_6_F",[1.27344,15.3379,-0.299711],126.345,[true,false],
	["AmovPercMstpSnonWnonDnon_Scared"],
	["H_Cap_red"], // array of headgear choices
	["U_NikosBody"] // array of uniform choices
	];  //  Sitting Animation
		// Use the animation view to see other choices: http://killzonekid.com/arma-3-animation-viewer-jumping-animation/
_missionLootBoxes = [
		//["Box_NATO_Wps_F",[3,-3,0],_crateLoot,[4,10,2,5,5,1]],  // Standard loot crate with standard loadout
		//["Land_PaperBox_C_EPOCH",[-4,-3,0],_crateLoot,[0,0,0,10,10,3]],  	// No Weapons, Magazines, or optics; 10 each construction supplies and food/drink items, 3 backpacks
		//["Land_CargoBox_V1_F",[3,4,0],_crateLoot,[0,10,2,5,5,1]]
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
	//[[-10.9121,-10.9824,-1.20243],5,7,"Green",5,12],
	//[[-10.2305,10.0215,-0.941586],5,7,"Green",5,12],
	//[[10.5605,-10.4043,-0.00143886],5,7,"Green",5,12],
	//[[10.61133,10.5918,-0.001438863],5,7,"blue",5,12]
	]; // Can be used to define spawn positions of AI patrols
	
_missionEmplacedWeapons = [
	//["B_HMG_01_high_F",[-10,-15,0]],
	//["B_GMG_01_high_F",[10,12,0]],
	//["O_static_AT_F",[-10,10,0]]
	]; // can be used to define the type and precise placement of static weapons [["wep",[1,2,3]] /*loc 1*/, [2,3,4] /*loc 2*/]; if blank random locations will be used

	_missionPatrolVehicles = [
	//["B_MRAP_01_hmg_F",[27.8945,100.275,0],0,[true,false]],
	//["B_MRAP_01_hmg_F",[-84.7793,72.2617,9.53674e-007],0,[true,false]],
	//["B_MRAP_01_gmg_F",[-87.8457,-109.947,7.15256e-007],0,[true,false]]
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
_endCondition = "assetSecured";  // Options are "allUnitsKilled", "playerNear", "allKilledOrPlayerNear", "assetSecured"
//_timeOut = -1;
#include "\q\addons\custom_server\Compiles\Missions\GMS_fnc_missionSpawner.sqf";
