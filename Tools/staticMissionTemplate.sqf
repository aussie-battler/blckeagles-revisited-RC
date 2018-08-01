/*
	This is a simple mission using precisely placed loot crates and infantry, static weapons and vehicle patrols.
	See the accompanying example mission in the exampleMission folder to get an idea how I laid this out.
	Note that I laid out the mission in EDEN editor, exported the mission using the exportAll function of M3EDEN editor. then copied, pasted and apporpriately edidet the specific categories of items to be spawned.
*/
/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
private ["_markerLabel","_endMsg","_startMsg","_lootCounts","_crateLoot","_markerMissionName","_missionLandscapeMode","_missionLandscape",
	"_missionLootBoxes","_missionLootVehicles","_missionEmplacedWeapons","_minNoAI","_maxNoAI","_noAIGroups","_noVehiclePatrols","_noEmplacedWeapons",
	"_uniforms","_headgear","_chanceReinforcements","_noPara","_helipatrol","_endCondition","_markerColor","_markerType","_useMines","_difficulty","_mission","_missionCenter"];

_mission = "UMS mission example #2";  //  Included for additional documentation. Not intended to be spawned as a mission per se.
_difficulty = "red";  // Skill level of AI (blue, red, green etc)
diag_log format["[blckeagls UMS missions] STARTED initializing mission %1 position at %2 difficulty %3",_mission,_missionCenter,_difficulty];
_crateLoot = blck_BoxLoot_Orange;  // You can use a customized _crateLoot configuration by defining an array here. It must follow the following format shown for a hypothetical loot array called _customLootArray
	/*
	_customLootArray = 
		// Loot is grouped as [weapons],[magazines],[items] in order to be able to use the correct function to load the item into the crate later on.
		// Each item consist of the following information ["ItemName",minNum, maxNum] where min is the smallest number added and min+max is the largest number added.
		
		[  
			[// Weapons	

				["srifle_DMR_06_olive_F","20Rnd_762x51_Mag"]				
			],
			[//Magazines
				["10Rnd_93x64_DMR_05_Mag" ,1,5]				
			],			
			[  // Optics
				["optic_KHS_tan",1,3]
			],
			[// Materials and supplies				
				["Exile_Item_MetalScrews",3,10]
				//
			],
			[//Items
				["Exile_Item_MountainDupe",1,3]				
			],
			[ // Backpacks
				["B_OutdoorPack_tan",1,2]
			]
	];	
	*/

_lootCounts = blck_lootCountsRed; // You can use a customized set of loot counts or one that is predefined but it must follow the following format:
								  // values are: number of things from the weapons, magazines, optics, materials(cinder etc), items (food etc) and backpacks arrays to add, respectively.
								  //  blck_lootCountsOrange = [[6,8],[24,32],[5,10],[25,35],16,1];   // Orange
_missionCenter = [22584.9,15304.8,0];  // I pulled this from the position of the marker.
_markerLabel = "";
//_markerType = ["ELIPSE",[200,200],"GRID"];
// An alternative would be:
_markerType = ["mil_triangle",[0,0]];  // You can replace mil_triangle with any other valid Arma 3 marker type https://community.bistudio.com/wiki/cfgMarkers
_markerColor = "ColorRed";  //  This can be any valid Arma Marker Color  
_markerMissionName = "Bad Fishermen Live Here";
_missionLandscapeMode = "precise"; // acceptable values are "random","precise"
									// In precise mode objects will be spawned at the relative positions specified.
									// In the random mode, objects will be randomly spawned within the mission area.
_missionLandscape = [  //  Paste appropriate lines from M3EDEN output here.

]; // list of objects to spawn as landscape using output from M3EDEN editor.

_missionLootBoxes = [  //  Paste appropriate lines from M3EDEN editor output here, then add the appropriate lootArray

];  // If this array is empty a single loot chest will be added at the center. If you add items loot chest(s) will be spawned in specific positions.



_missionLootVehicles = [  // Paste appropriate lines from the output of M3EDEN Editor here and add the loot crate type and loot counts at the end of each entry as shown in the example below.

]; //  [ ["vehicleClassName", [px, py, pz] /* possition at which to spawn*/, _loot /* pointer to array of loot (see below)]; 
// When blank nothing is spawned.
// You can use the same format used for _missionLootBoxes to add vehicles with/without loot.

_noEmplacedWeapons = blck_SpawnEmplaced_Red; // Modified as needed; can be a numberic value (e.g. 3) or range presented as [2,4]
//format: _noEmplacedWeapons  = [2,3]; // a range of values
// or _noEmplacedWeapons = 3; // a constant number of emplaced weps per misison
// Note that this value is ignored if you define static weapon positions and types in the array below.
_missionEmplacedWeapons = [

];
// example [ ["emplacedClassName",[px, py, pz] /* position to spawn weapon */, difficulty /* difficulty of AI manning weapon (blue, red etc)] ];
// can be used to define the precise placement of static weapons [[1,2,3] /*loc 1*/, [2,3,4] /*loc 2*/]; if blank random locations will be used
// If the number of possible locations exceeds the number of emplaced weapons specified above then only some of the locations in the array will have emplaced weapons spawned.
// If you leave this array blank then emplaced weapons will be spawned at random locations around the mission using the default list of emplace weapons.
								
_minNoAI = blck_MinAI_Red;  //  Modify as needed
_maxNoAI = blck_MaxAI_Red;	// Modify as needed.
_noAIGroups = blck_AIGrps_Red;  // Modify as needed; note that these values are ignored of you specify AI patrols in the array below.
_aiGroupParameters = [
	// [ [px, py, pz] /* position*/, "difficulty", 4 /*Number to Spawn*/, 150 /*radius of patrol*/]

];
_aiScubaGroupParameters = [

];
_noVehiclePatrols = blck_SpawnVeh_Red; // Modified as needed; can be a numberic value (e.g. 3) or range presented as [2,4]; 
										//  Note that this value is ignored if you define vehicle patrols in the array below.
_vehiclePatrolParameters = [

]; 							//[ ["vehicleClassName",[px,py,pz] /* center of patrol area */, difficulty /* blue, red etc*/, patrol radius] ]
							// When this array is empty, vehicle patrols will be scattered randomely around the mission.
							// Allows you to define the location of the center of the patrol, vehicle type spawned, radius to patrol, and AI difficulty (blue, red, green etc).

_submarinePatrolParameters = [

];

_aircraftTypes = blck_patrolHelisRed;  //  You can use one of the pre-defined lists in blck_configs or your own custom array.
_noAirPatrols =	blck_noPatrolHelisRed; // You can use one of the pre-defined values or a custom one. acceptable values are integers (1,2,3) or a range such as [2,4]; 
										//  Note: this value is ignored if you specify air patrols in the array below.
_airPatrols = [

];

//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = false;  // Set to false if you have vehicles patrolling nearby.

#include "\q\addons\custom_server\Missions\UMS\code\GMS_fnc_sm_initializeUMSStaticMission.sqf"; 

diag_log format["[blckeagls static missions] COMPLETED initializing misions %1 position at %2 difficulty %3",_mission,_missionCenter,_difficulty];
