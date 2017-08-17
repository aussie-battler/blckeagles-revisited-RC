/*
	This is a simple mission using randomly placed AI infantry, static weapons and vehicle patrols.
	Please see staticMissionExample2.sqf for a more complete overview of how to configure static missions.
*/
private ["_markerLabel","_endMsg","_startMsg","_lootCounts","_crateLoot","_markerMissionName","_missionLandscapeMode","_missionLandscape",
	"_missionLootBoxes","_missionLootVehicles","_missionEmplacedWeapons","_minNoAI","_maxNoAI","_noAIGroups","_noVehiclePatrols","_noEmplacedWeapons",
	"_uniforms","_headgear","_chanceReinforcements","_noPara","_helipatrol","_endCondition","_markerColor","_markerType","_useMines"];

_mission = "static mission example 1";
_missionCenter = [24415,18909,0];  // I pulled this from the position of the marker.
_difficulty = "red";  // Skill level of AI (blue, red, green etc)
_crateLoot = blck_BoxLoot_Red;
_lootCounts = blck_lootCountsRed;

_markerLabel = "";
_markerType = ["ELIPSE",[200,200],"GRID"];
// An alternative would be:
// _markerType = ["mil_triangle",[0,0]];  // You can replace mil_triangle with any other valid Arma 3 marker type https://community.bistudio.com/wiki/cfgMarkers
_markerColor = "ColorRed";  //  This can be any valid Arma Marker Color  
_markerMissionName = "Bad Guys Town";
_missionLandscapeMode = "precise"; // acceptable values are "random","precise"
									// In precise mode objects will be spawned at the relative positions specified.
									// In the random mode, objects will be randomly spawned within the mission area.
_missionLandscape = [
	
]; // list of objects to spawn as landscape
_missionLootBoxes = [];  //  Parameters are "Box Item Code", array defining the loot to be spawned, and position.
// If this array is empty a single loot chest will be added at the center. If you add items loot chest(s) will be spawned in specific positions.
// 
// [["box_classname1",_customLootArray1,[px,py,pz],["box_classname2",_customLootArray2,[px2,py2,pz2]]
//  where _customLootArray follows the same format as blck_BoxLoot_Red and the other pre-defined arrays and
//  where _customlootcountsarray1 also follows the same format as the predefined arrays like blck_lootCountsRed

_missionLootVehicles = []; //  [ ["vehicleClassName", [px, py, pz] /* possition at which to spawn*/, _loot /* pointer to array of loot (see below)]; 
// When blank nothing is spawned.
// You can use the same format used for _missionLootBoxes to add vehicles with/without loot.

_noEmplacedWeapons  = [2,3];
_missionEmplacedWeapons = []; // example [ ["emplacedClassName",[px, py, pz] /* position to spawn weapon */, difficulty /* difficulty of AI manning weapon (blue, red etc)] ];
								// can be used to define the precise placement of static weapons [[1,2,3] /*loc 1*/, [2,3,4] /*loc 2*/]; if blank random locations will be used
								// If the number of possible locations exceeds the number of emplaced weapons specified above then only some of the locations in the array will have emplaced weapons spawned.
								// If you leave this array blank then emplaced weapons will be spawned at random locations around the mission using the default list of emplace weapons.
								
_minNoAI = blck_MinAI_Red;  //  Modify as needed
_maxNoAI = blck_MaxAI_Red;	// Modify as needed.
_noAIGroups = blck_AIGrps_Red;  // Modify as needed
_aiGroupParameters = [];

_noVehiclePatrols = blck_SpawnVeh_Red; // Modified as needed; can be a numberic value (e.g. 3) or range presented as [2,4]
_vehiclePatrolParameters = []; //[ ["vehicleClassName",[px,py,pz] /* center of patrol area */, difficulty /* blue, red etc*/] ]
							// When empty vehicle patrols will be scattered randomely around the mission.
							// Allows you to define the location of the center of the patrol, vehicle type spawned, radius to patrol, and AI difficulty (blue, red, green etc).
							// If _noVehiclePatrols is less than the number of locations specified only _noVehiclePatrols patrols will be spawned.
_noEmplacedWeapons = blck_SpawnEmplaced_Red; // Modified as needed; can be a numberic value (e.g. 3) or range presented as [2,4]

_aircraftTypes = blck_patrolHelisRed;  //  You can use one of the pre-defined lists in blck_configs or your own custom array.
_noAirPatrols =	blck_noPatrolHelisRed; // You can use one of the pre-defined values or a custom one. acceptable values are integers (1,2,3) or a range such as [2,4];
_airPatrols = [];

//  Change _useMines to true/false below to enable mission-specific settings.
_useMines = blck_useMines;  
_uniforms = blck_SkinList;  // You can replace this list with a custom list of uniforms if you like.
_headgear = blck_headgear;  // You can replace this list with a custom list of headgear.
_weapons = blck_WeaponList_Orange; // You can replace this list with a customized list of weapons, or another predifined list from blck_configs_epoch or blck_configs_exile as appropriate.

#include "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_spawnMission.sqf"; 
