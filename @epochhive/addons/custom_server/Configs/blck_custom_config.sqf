	
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 3-14-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Compiles\blck_defines.hpp";

diag_log "[blckeagls] Loading Configuration Overides";

switch (toLower (worldName)) do
{
	case"tanoa": {blck_maxCrashSites = 2};
	case"namalsk": {
					blck_enableOrangeMissions = -1;  
					blck_enableGreenMissions = -1;
					blck_enableRedMissions = -1;
					blck_enableBlueMissions = 1;
	}

};

if (blck_debugON) then 
{
	// Used primarily for debugging.
	diag_log "[blckeagls] Debug seting is ON, Custom configurations used";
	
	blck_enableOrangeMissions = 1;  
	blck_enableGreenMissions = 1;
	blck_enableRedMissions = 1;
	blck_enableBlueMissions = 1;

	
	blck_cleanupCompositionTimer = 10;  // Time after mission completion at which items in the composition are deleted.
	blck_AliveAICleanUpTimer = 10;  // Time after mission completion at which any remaining live AI are deleted.
	blck_bodyCleanUpTimer = 10;
	
	blck_SpawnEmplaced_Orange = 3; // Number of static weapons at Orange Missions
	blck_SpawnEmplaced_Green = 2; // Number of static weapons at Green Missions
	blck_SpawnEmplaced_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnEmplaced_Red = 2; 
	
	blck_SpawnVeh_Orange = 4; // Number of static weapons at Orange Missions
	blck_SpawnVeh_Green = 3; // Number of static weapons at Green Missions
	blck_SpawnVeh_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnVeh_Red = 2;
	
	//blck_reinforcementsBlue = [0, 0, 0.0, 0];  // Chance of reinforcements, number of reinforcements, Chance of reinforcing heli patrols, chance of dropping supplies for the reinforcements

	blck_TMin_Blue = 7;
	blck_TMin_Red = 20;
	blck_TMin_Green = 23;	
	blck_TMin_Orange = 20;	

	
	//Maximum Spawn time between missions in seconds
	blck_TMax_Blue = 12;
	blck_TMax_Red = 35;
	blck_TMax_Green = 38;
	blck_TMax_Orange = 31;

	//blck_reinforceBlue = [0.999, 2, 0.001];
	//blck_MissionTimout = 10;  // 40 min
	
	blck_SkillsBlue = [
		["aimingAccuracy",0.01],
		["aimingShake",0.3],
		["aimingSpeed",0.01],
		["endurance",0.5],
		["spotDistance",0.7],
		["spotTime",0.7],
		["courage",0.7],
		["reloadSpeed",0.80],
		["commanding",0.8],
		["general",1.00]
	];
	
};



