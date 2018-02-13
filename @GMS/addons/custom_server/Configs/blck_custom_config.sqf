	
/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last Modified 3-14-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

diag_log "[blckeagls] Loading Configuration Overides";

private["_startTime"];
_startTime = diag_tickTime;
_world = toLower format ["%1", worldName];
private["_nightAccel","_dayAccel","_duskAccel"];
switch (_world) do {
	case "altis":{_nightAccel = 3;_dayAccel=0.5; _duskAccel = 3;};
	case "napf":{_nightAccel = 12; _dayAccel = 2;_duskAccel = 6;};
	case "namalsk":{_nightAccel = 12; _dayAccel = 2;_duskAccel = 6;};
	case "tanoa":{_nightAccel = 12; _dayAccel = 3.2;_duskAccel = 6;};
};

switch (toLower (worldName)) do
{
	case "altis":
	{
		private ["_arr","_sunrise","_sunset","_time"];
		_arr = date call BIS_fnc_sunriseSunsetTime;
		_sunrise = _arr select 0;
		_sunset = _arr select 1;
		_daylight = _sunset - _sunrise;
		_nightTime = abs(24 - _daylight);
		_time = dayTime;
		
		//blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		//blck_timeAccelerationDay = (_daylight)/6;  // Daytime time accelearation
		//blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		//blck_timeAccelerationNight = _nightTime / 6;  // Nighttim time acceleration	
		blck_maxCrashSites = 3;
	};
	case"tanoa": 
	{
		blck_maxCrashSites = 2;
		//blck_timeAcceleration = false; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		//blck_timeAccelerationDay = 1.4;  // Daytime time accelearation
		//blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		//blck_timeAccelerationNight = 8;  // Nighttim time acceleration		
	};
	case"namalsk": 
	{
		blck_enableOrangeMissions = 1;  
		blck_enableGreenMissions = -1;
		blck_enableRedMissions = 1;
		blck_enableBlueMissions = -1;
		blck_enableHunterMissions = 1;
		blck_enableScoutsMissions = -1;
		blck_maxCrashSites = 1;  // recommended settings: 3 for Altis, 2 for Tanoa, 1 for smaller maps. Set to -1 to disable
		
		//blck_timeAcceleration = false; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		//blck_timeAccelerationDay = 1;  // Daytime time accelearation
		//blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		//blck_timeAccelerationNight = 8;  // Nighttim time acceleration		
	};
	case "esseker": 
	{
		blck_enableOrangeMissions = 1;  
		blck_enableGreenMissions = -1;
		blck_enableRedMissions = 1;
		blck_enableBlueMissions = -1;
		blck_enableHunterMissions = 1;
		blck_enableScoutsMissions = -1;
		blck_maxCrashSites = 1;
		
		//blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		//blck_timeAccelerationDay = 1;  // Daytime time accelearation
		//blck_timeAccelerationDusk = 3; // Dawn/dusk time accelearation
		//blck_timeAccelerationNight = 6;  // Nighttim time acceleration		
	};
	case "panthera3":
	{
		blck_maxCrashSites = 2;
		//blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		//blck_timeAccelerationDay = 1.4;  // Daytime time accelearation
		//blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		//blck_timeAccelerationNight = 8;  // Nighttim time acceleration		
	};
	case "malden":
	{
		_arr = date call BIS_fnc_sunriseSunsetTime;
		_sunrise = _arr select 0;
		_sunset = _arr select 1;
		_time = dayTime;
		_daylight = _sunset - _sunrise;
		
		//blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = (_daylight / 2.5);  // Daytime time accelearation
		blck_timeAccelerationDusk = 8; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = ((24 - _daylight) / 1.5);  // Nighttim time acceleration		
	};		
};

if (blck_debugON || (blck_debugLevel > 0)) then // These variables are found in \custom_server\compiles\blck_variables.sqf
{
	// Used primarily for debugging.
	diag_log "[blckeagls] Debug seting is ON, Custom configurations used";

	//blck_useTimeAcceleration = false; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
	//blck_timeAccelerationDay = 1;  // Daytime time accelearation
	//blck_timeAccelerationDusk = 18; // Dawn/dusk time accelearation
	//blck_timeAccelerationNight = 24;  // Nighttim time acceleration	
	
	//blck_useHC = true;
	blck_maxSpawnedMissions = 10;
	blck_mainThreadUpdateInterval = 10;
	blck_enableOrangeMissions = 1;  
	blck_enableGreenMissions = 1;
	blck_enableRedMissions = -2;
	blck_enableBlueMissions = -2;
	blck_numberUnderwaterDynamicMissions = -3;	
	blck_enableHunterMissions = -1;
	blck_enableScoutsMissions = -1;
	blck_maxCrashSites = 0; 
	
	//blck_enabeUnderwaterMissions = 1;
	
	blck_cleanupCompositionTimer = 10;  // Time after mission completion at which items in the composition are deleted.
	blck_AliveAICleanUpTimer = 10;  // Time after mission completion at which any remaining live AI are deleted.
	blck_bodyCleanUpTimer = 10;
	blck_vehicleDeleteTimer = 60; 
	
	blck_noPatrolHelisOrange = 0;	

	//blck_chanceHeliPatrolBlue = 1;
	blck_SpawnEmplaced_Orange = 0; // Number of static weapons at Orange Missions
	blck_SpawnEmplaced_Green = 0; // Number of static weapons at Green Missions
	blck_SpawnEmplaced_Blue = 0;  // Number of static weapons at Blue Missions
	blck_SpawnEmplaced_Red = 0; 

	blck_SpawnVeh_Orange = [2,4]; // Number of static weapons at Orange Missions
	blck_SpawnVeh_Green = 3; // Number of static weapons at Green Missions
	blck_SpawnVeh_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnVeh_Red = 2;
	
	blck_TMin_Blue = 7;
	blck_TMin_Red = 10;
	blck_TMin_Green = 13;	
	blck_TMin_Orange = 16;	
	blck_TMin_Hunter = 20;
	blck_TMin_Scouts = 20;
	blck_TMin_Crashes = 5;
	blck_TMin_UMS = 20;
	//Maximum Spawn time between missions in seconds
	blck_TMax_Blue = 12;
	blck_TMax_Red = 15;
	blck_TMax_Green = 17;
	blck_TMax_Orange = 21;
	blck_TMax_Hunter = 22;
	blck_TMax_Scouts = 22;
	blck_TMax_Crashes = 15;
	blck_TMax_UMS = 25;
	//blck_MissionTimout = 360;  // 40 min
	/*
	blck_MinAI_Blue = 3;	
	blck_MaxAI_Blue = 5;
	blck_AIGrps_Blue = 1;
	*/
	/*
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
	*/
};



