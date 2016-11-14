	
/* 
	Place any overrides of the default configurations here.
	This is a convenient way to specify the configuration you like without worrying about going through the individual config files with each update.
    Several Examples are shown below.
*/

diag_log "[blckeagls] Loading Configuration Overides";

switch (toLower (worldName)) do
{
	case"tanoa": {blck_maxCrashSites = 2};
	case"namalsk": {
					blck_enableOrangeMissions = 1;  
					blck_enableGreenMissions = -1;
					blck_enableRedMissions = 1;
					blck_enableBlueMissions = -1;
					blck_enableHunterMissions = 1;
					blck_enableScoutsMissions = -1;
	
					// Define the maximum number of crash sites on the map at any one time
					blck_maxCrashSites = -1;  // recommended settings: 3 for Altis, 2 for Tanoa, 1 for smaller maps. Set to -1 to disable
	}

};

if (blck_debugON) then 
{
	// Used primarily for debugging.
	diag_log "[blckeagls] Debug seting is ON, Custom configurations used";
	
	blck_mainThreadUpdateInterval = 10;
	blck_enableOrangeMissions = 1;  
	blck_enableGreenMissions = 1;
	blck_enableRedMissions = 1;
	blck_enableBlueMissions = 1;
	blck_enableHunterMissions = 1;
	blck_enableScoutsMissions = 1;
	blck_maxCrashSites = 3; 
	
	blck_enabeUnderwaterMissions = -1;
	
	blck_cleanupCompositionTimer = 10;  // Time after mission completion at which items in the composition are deleted.
	blck_AliveAICleanUpTime = 10;  // Time after mission completion at which any remaining live AI are deleted.
	blck_bodyCleanUpTimer = 20;
	
	blck_SpawnEmplaced_Orange = 4; // Number of static weapons at Orange Missions
	blck_SpawnEmplaced_Green = 3; // Number of static weapons at Green Missions
	blck_SpawnEmplaced_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnEmplaced_Red = 2; 
	
	blck_SpawnVeh_Orange = 4; // Number of static weapons at Orange Missions
	blck_SpawnVeh_Green = 3; // Number of static weapons at Green Missions
	blck_SpawnVeh_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnVeh_Red = 2;
	
	//blck_reinforcementsBlue = [0, 0, 0.0, 0];  // Chance of reinforcements, number of reinforcements, Chance of reinforcing heli patrols, chance of dropping supplies for the reinforcements
	
	//blck_AIGrps_Blue = 1;
	//blck_AIGrps_Red = 2;
	//blck_AIGrps_Green = 3;
	
	//blck_TMin_Major = 5;
	//blck_TMin_Major2 = 6;
	blck_TMin_Blue = 7;
	blck_TMin_Red = 20;
	blck_TMin_Green = 23;	
	blck_TMin_Orange = 20;	
	blck_TMin_Hunter = 15;
	blck_TMin_Scouts = 20;
	blck_TMin_Crashes = 5;
	
	//Maximum Spawn time between missions in seconds
	//blck_TMax_Major = 10;
	//blck_TMax_Major2 = 11;
	blck_TMax_Blue = 12;
	blck_TMax_Red = 35;
	blck_TMax_Green = 38;
	blck_TMax_Orange = 31;
	blck_TMax_Hunter = 40;
	blck_TMax_Scouts = 45;
	blck_TMax_Crashes = 15;
	
	//blck_MissionTimout = 120;  // 40 min
	blck_SkillsBlue = [
		["aimingAccuracy",0.01],
		["aimingShake",0.01],
		["aimingSpeed",0.01],
		["endurance",0.01],
		["spotDistance",0.01],
		["spotTime",0.01],
		["courage",0.01],
		["reloadSpeed",0.80],
		["commanding",0.8],
		["general",1.00]
	];
	
};



