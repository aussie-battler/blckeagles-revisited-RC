	
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
	case "namalsk":{_nightAccel = 12; _dayAccel = 2; _duskAccel = 6;};
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
		#ifdef blck_milServer
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = (_daylight)/3;  // Daytime time accelearation
		blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = _nightTime / 6;  // Nighttim time acceleration	
		#else
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = (_daylight)/8;  // Daytime time accelearation
		blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = _nightTime / 8;  // Nighttim time acceleration		
		#endif
		//blck_maxCrashSites = 3;
	};
	case"tanoa": 
	{
		blck_maxCrashSites = 2;
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = 1.4;  // Daytime time accelearation
		blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = 8;  // Nighttim time acceleration		
	};
	case"namalsk": 
	{
		private ["_arr","_sunrise","_sunset","_time"];
		_arr = date call BIS_fnc_sunriseSunsetTime;
		_sunrise = _arr select 0;
		_sunset = _arr select 1;
		_daylight = _sunset - _sunrise;
		_nightTime = abs(24 - _daylight);
		_time = dayTime;
		_serverUpTime = 8;
		blck_enableOrangeMissions = 1;  
		blck_enableGreenMissions = -1;
		blck_enableRedMissions = 1;
		blck_enableBlueMissions = -1;
		blck_enableHunterMissions = 1;
		blck_enableScoutsMissions = -1;
		blck_maxCrashSites = 1;  // recommended settings: 3 for Altis, 2 for Tanoa, 1 for smaller maps. Set to -1 to disable
		
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = 2;  // Daytime time accelearation
		blck_timeAccelerationDusk = 6; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = (12);  // Nighttim time acceleration		
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
		
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = 1;  // Daytime time accelearation
		blck_timeAccelerationDusk = 3; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = 6;  // Nighttim time acceleration		
	};
	case "panthera3":
	{
		blck_maxCrashSites = 2;
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = 1.4;  // Daytime time accelearation
		blck_timeAccelerationDusk = 4; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = 8;  // Nighttim time acceleration		
	};
	case "malden":
	{
		_arr = date call BIS_fnc_sunriseSunsetTime;
		_sunrise = _arr select 0;
		_sunset = _arr select 1;
		_time = dayTime;
		_daylight = _sunset - _sunrise;
		
		blck_timeAcceleration = true; // When true, time acceleration will be periodically updated based on amount of daylight at that time according to the values below.
		blck_timeAccelerationDay = (_daylight / 2.5);  // Daytime time accelearation
		blck_timeAccelerationDusk = 8; // Dawn/dusk time accelearation
		blck_timeAccelerationNight = ((24 - _daylight) / 1.5);  // Nighttim time acceleration
		blck_enableOrangeMissions = -1;  
		blck_enableGreenMissions = -1;
		blck_enableRedMissions = -2;
		blck_enableBlueMissions = -1;
		blck_numberUnderwaterDynamicMissions = -3;	
		blck_enableHunterMissions = -1;
		blck_enableScoutsMissions = -1;
		blck_maxCrashSites = 3; 		
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
	
	blck_useHC = true;

	blck_maxSpawnedMissions = 15;
	blck_mainThreadUpdateInterval = 10;
	blck_enableOrangeMissions = 1;  
	blck_enableGreenMissions = 1;
	blck_enableRedMissions = 1;
	blck_enableBlueMissions = 1;
	blck_numberUnderwaterDynamicMissions = 1;	
	blck_enableHunterMissions = 1;
	blck_enableScoutsMissions = 1;
	blck_maxCrashSites = 3; 
	
	blck_cleanupCompositionTimer = 20;  // Time after mission completion at which items in the composition are deleted.
	blck_AliveAICleanUpTimer = 20;  // Time after mission completion at which any remaining live AI are deleted.
	blck_bodyCleanUpTimer = 20;
	blck_vehicleDeleteTimer = 20; 
	//blck_MissionTimeout = 30;
	
	blck_noPatrolHelisOrange = 1;
	blck_chanceHeliPatrolOrange = 1;
	blck_chanceParaOrange = 1;
	blck_chanceHeliPatrolBlue = -1;
	blck_noPatrolHelisBlue = -1;
	blck_chanceParaBlue = -1; // [0 - 1] set to 0 to deactivate and 1 to always have paratroops spawn over the center of the mission. This value can be a range as well [0.1,0.3]
	blck_noParaBlue = 3; //  [1-N]	
	blck_paraTriggerDistanceBlue = 400;
	
	//blck_chanceHeliPatrolBlue = 1;
	blck_SpawnEmplaced_Orange = 1; // Number of static weapons at Orange Missions
	blck_SpawnEmplaced_Green = 1; // Number of static weapons at Green Missions
	blck_SpawnEmplaced_Blue = 1;  // Number of static weapons at Blue Missions
	blck_SpawnEmplaced_Red = 1; 

	blck_SpawnVeh_Orange = 1; // Number of vehicles at Orange Missions
	blck_SpawnVeh_Green = 1; // Number of vehicles at Green Missions
	blck_SpawnVeh_Blue = 1;  // Number of vehicles at Blue Missions
	blck_SpawnVeh_Red = 1;
	
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

	//blck_MinAI_Orange = 1;
	//blck_MaxAI_Orange = 2;
	//blck_AIGrps_Orange = 1;
	
	blck_MinAI_Blue = 1;	
	blck_MaxAI_Blue = 2;
	blck_AIGrps_Blue = 1;
	
	blck_AIPatrolVehicles = ["Exile_Car_MB4WDOpen"];
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

blck_CUPWeapons = [
	"CUP_lmg_L7A2",
	"CUP_lmg_L110A1",
	"CUP_lmg_M240",
	"CUP_lmg_M249",
	"CUP_lmg_M249_ElcanM145_Laser",
	"CUP_lmg_Mk48_des",
	"CUP_lmg_Mk48_wdl",
	"CUP_lmg_PKM",
	"CUP_lmg_UK59",
	"CUP_lmg_Pecheneg",
	"CUP_arifle_AK74",
	"CUP_arifle_AK107",
	"CUP_arifle_AK107_GL",
	"CUP_arifle_AKS74",
	"CUP_arifle_AKS74U",
	"CUP_arifle_AK74_GL",
	"CUP_arifle_AKM",
	"CUP_arifle_AKS",
	"CUP_arifle_AKS_Gold",
	"CUP_arifle_RPK74",
	"CUP_arifle_CZ805_A2",
	"CUP_arifle_FNFAL",
	"CUP_arifle_G36A",
	"CUP_arifle_G36A_camo",
	"CUP_arifle_G36K",
	"CUP_arifle_G36K_camo",
	"CUP_arifle_G36C",
	"CUP_arifle_G36C_camo",
	"CUP_arifle_MG36",
	"CUP_arifle_MG36_camo",
	"CUP_arifle_L85A2",
	"CUP_arifle_L85A2_GL",
	"CUP_arifle_L86A2",
	"CUP_arifle_M16A2",
	"CUP_arifle_M16A2_GL",
	"CUP_arifle_M4A1",
	"CUP_arifle_M4A1_camo",
	"CUP_arifle_M4A3_desert_Aim_Flashlight",
	"CUP_arifle_M16A4_Base",
	"CUP_arifle_M4A1_BUIS_GL",
	"CUP_arifle_M4A1_BUIS_camo_GL",
	"CUP_arifle_M4A1_BUIS_desert_GL",
	"CUP_arifle_M4A1_desert",
	"CUP_arifle_Sa58P",
	"CUP_arifle_Sa58V",
	"CUP_arifle_Mk16_CQC",
	"CUP_arifle_XM8_Railed",
	"CUP_arifle_XM8_Carbine",
	"CUP_arifle_XM8_Carbine_FG",
	"CUP_arifle_XM8_Carbine_GL",
	"CUP_arifle_XM8_Compact",
	"CUP_arifle_xm8_SAW",
	"CUP_arifle_xm8_sharpshooter",
	"CUP_arifle_CZ805_A1",
	"CUP_arifle_CZ805_GL",
	"CUP_arifle_CZ805_B_GL",
	"CUP_arifle_CZ805_B",
	"CUP_arifle_Sa58P_des",
	"CUP_arifle_Sa58V_camo",
	"CUP_arifle_Sa58RIS1",
	"CUP_arifle_Sa58RIS2",
	"CUP_arifle_Mk16_CQC_FG",
	"CUP_arifle_Mk16_CQC_SFG",
	"CUP_arifle_Mk16_CQC_EGLM",
	"CUP_arifle_Mk16_STD",
	"CUP_arifle_Mk16_STD_FG",
	"CUP_arifle_Mk16_STD_SFG",
	"CUP_arifle_Mk16_STD_EGLM",
	"CUP_arifle_Mk16_SV",
	"CUP_arifle_Mk17_CQC",
	"CUP_arifle_Mk17_CQC_FG",
	"CUP_arifle_Mk17_CQC_SFG",
	"CUP_arifle_Mk17_CQC_EGLM",
	"CUP_arifle_Mk17_STD",
	"CUP_arifle_Mk17_STD_FG",
	"CUP_arifle_Mk17_STD_SFG",
	"CUP_arifle_Mk17_STD_EGLM",
	"CUP_arifle_Mk20",
	"CUP_srifle_AWM_des",
	"CUP_srifle_AWM_wdl",
	"CUP_srifle_CZ750",
	"CUP_srifle_DMR",
	"CUP_srifle_CZ550",
	"CUP_srifle_LeeEnfield",
	"CUP_srifle_M14",
	"CUP_srifle_Mk12SPR",
	"CUP_srifle_M24_des",
	"CUP_srifle_M24_wdl",
	"CUP_srifle_M24_ghillie",
	"CUP_srifle_M40A3",
	"CUP_srifle_M107_Base",
	"CUP_srifle_M110",
	"CUP_srifle_SVD",
	"CUP_srifle_SVD_des",
	"CUP_srifle_SVD_wdl_ghillie",
	"CUP_srifle_SVD_NSPU",
	"CUP_srifle_ksvk",
	"CUP_srifle_VSSVintorez",
	"CUP_srifle_AS50"						
];

blck_CUPUniforms = [
	"CUP_U_B_CZ_WDL_TShirt",
	"CUP_U_I_GUE_Anorak_01",
	"CUP_U_I_GUE_Anorak_03",
	"CUP_U_I_GUE_Anorak_02",
	"CUP_U_B_BAF_DDPM_S2_UnRolled",
	"CUP_U_B_BAF_DDPM_S1_RolledUp",
	"CUP_U_B_BAF_DDPM_Tshirt",
	"CUP_U_B_BAF_DPM_S2_UnRolled",
	"CUP_U_B_BAF_DPM_S1_RolledUp",
	"CUP_U_B_BAF_DPM_Tshirt",
	"CUP_U_B_BAF_MTP_S2_UnRolled",
	"CUP_U_B_BAF_MTP_S1_RolledUp",
	"CUP_U_B_BAF_MTP_Tshirt",
	"CUP_U_B_BAF_MTP_S4_UnRolled",
	"CUP_U_B_BAF_MTP_S3_RolledUp",
	"CUP_U_B_BAF_MTP_S5_UnRolled",
	"CUP_U_B_BAF_MTP_S6_UnRolled",
	"CUP_U_O_CHDKZ_Bardak",
	"CUP_U_O_CHDKZ_Lopotev",
	"CUP_U_O_CHDKZ_Kam_03",
	"CUP_U_O_CHDKZ_Kam_01",
	"CUP_U_O_CHDKZ_Kam_04",
	"CUP_U_O_CHDKZ_Kam_02",
	"CUP_U_O_CHDKZ_Commander",
	"CUP_U_O_CHDKZ_Kam_08",
	"CUP_U_O_CHDKZ_Kam_05",
	"CUP_U_O_CHDKZ_Kam_07",
	"CUP_U_O_CHDKZ_Kam_06",
	"CUP_U_C_Citizen_02",
	"CUP_U_C_Citizen_01",
	"CUP_U_C_Citizen_04",
	"CUP_U_C_Citizen_03",
	"CUP_U_C_Fireman_01",
	"CUP_U_B_GER_Flecktarn_2",
	"CUP_U_B_GER_Tropentarn_2",
	"CUP_U_B_GER_Flecktarn_1",
	"CUP_U_B_GER_Tropentarn_1",
	"CUP_O_TKI_Khet_Jeans_04",
	"CUP_O_TKI_Khet_Jeans_02",
	"CUP_O_TKI_Khet_Jeans_01",
	"CUP_O_TKI_Khet_Jeans_03",
	"CUP_O_TKI_Khet_Partug_04",
	"CUP_O_TKI_Khet_Partug_02",
	"CUP_O_TKI_Khet_Partug_01",
	"CUP_O_TKI_Khet_Partug_07",
	"CUP_O_TKI_Khet_Partug_08",
	"CUP_O_TKI_Khet_Partug_05",
	"CUP_O_TKI_Khet_Partug_06",
	"CUP_O_TKI_Khet_Partug_03",
	"CUP_U_C_Labcoat_02",
	"CUP_U_C_Labcoat_03",
	"CUP_U_C_Labcoat_01",
	"CUP_U_B_USMC_Officer",
	"CUP_U_B_USMC_MARPAT_WDL_RollUpKneepad",
	"CUP_U_B_USMC_MARPAT_WDL_RolledUp",
	"CUP_U_B_USMC_MARPAT_WDL_Kneepad",
	"CUP_U_B_USMC_MARPAT_WDL_TwoKneepads",
	"CUP_U_B_USMC_MARPAT_WDL_Sleeves",
	"CUP_U_C_Mechanic_02",
	"CUP_U_C_Mechanic_03",
	"CUP_U_C_Mechanic_01",
	"CUP_U_I_GUE_Flecktarn2",
	"CUP_U_I_GUE_Flecktarn3",
	"CUP_U_I_GUE_Flecktarn",
	"CUP_U_I_GUE_Woodland1",
	"CUP_B_USMC_Navy_Blue",
	"CUP_B_USMC_Navy_Brown",
	"CUP_B_USMC_Navy_Green",
	"CUP_B_USMC_Navy_Red",
	"CUP_B_USMC_Navy_Violet",
	"CUP_B_USMC_Navy_White",
	"CUP_B_USMC_Navy_Yellow",
	"CUP_U_C_Rescuer_01",
	"CUP_U_O_Partisan_TTsKO",
	"CUP_U_O_Partisan_TTsKO_Mixed",
	"CUP_U_O_Partisan_VSR_Mixed1",
	"CUP_U_O_Partisan_VSR_Mixed2",
	"CUP_U_C_Pilot_01",
	"CUP_U_C_Policeman_01",
	"CUP_U_C_Priest_01",
	"CUP_U_C_Profiteer_02",
	"CUP_U_C_Profiteer_03",
	"CUP_U_C_Profiteer_01",
	"CUP_U_C_Profiteer_04",
	"CUP_U_I_RACS_Desert_2",
	"CUP_U_I_RACS_Urban_2",
	"CUP_U_I_RACS_PilotOverall",
	"CUP_U_I_RACS_Desert_1",
	"CUP_U_I_RACS_Urban_1",
	"CUP_U_C_Rocker_01",
	"CUP_U_C_Rocker_03",
	"CUP_U_C_Rocker_02",
	"CUP_U_C_Rocker_04",
	"CUP_U_O_RUS_Gorka_Green",
	"CUP_U_O_RUS_Gorka_Partizan_A",
	"CUP_U_O_RUS_Gorka_Partizan",
	"CUP_U_O_RUS_EMR_1_VDV",
	"CUP_U_O_RUS_EMR_1",
	"CUP_U_O_RUS_Flora_1_VDV",
	"CUP_U_O_RUS_Flora_1",
	"CUP_U_O_RUS_Commander",
	"CUP_U_O_RUS_EMR_2_VDV",
	"CUP_U_O_RUS_EMR_2",
	"CUP_U_O_RUS_Flora_2_VDV",
	"CUP_U_O_RUS_Flora_2",
	"CUP_U_O_SLA_Officer_Suit",
	"CUP_U_O_SLA_Overalls_Pilot",
	"CUP_U_O_SLA_Overalls_Tank",
	"CUP_U_O_SLA_MixedCamo",
	"CUP_U_O_SLA_Desert",
	"CUP_U_O_SLA_Green",
	"CUP_U_O_SLA_Urban",
	"CUP_U_B_FR_SpecOps",
	"CUP_U_B_FR_Officer",
	"CUP_U_B_FR_DirAction",
	"CUP_U_B_FR_DirAction2",
	"CUP_U_B_FR_Corpsman",
	"CUP_U_B_FR_Light",
	"CUP_U_B_FR_Scout1",
	"CUP_U_B_FR_Scout2",
	"CUP_U_B_FR_Scout3",
	"CUP_U_B_FR_Scout",
	"CUP_U_C_Suit_01",
	"CUP_U_C_Suit_02",
	"CUP_U_O_TK_Officer",
	"CUP_U_O_SLA_Officer",
	"CUP_U_O_TK_Green",
	"CUP_U_O_TK_MixedCamo",
	"CUP_U_B_USArmy_TwoKnee",
	"CUP_U_B_USArmy_Base",
	"CUP_U_B_USArmy_Soft",
	"CUP_U_B_USArmy_UBACS",
	"CUP_U_B_USArmy_PilotOverall",
	"CUP_U_B_USMC_PilotOverall",
	"CUP_U_C_Villager_01",
	"CUP_U_C_Villager_04",
	"CUP_U_C_Villager_02",
	"CUP_U_C_Villager_03",
	"CUP_U_C_Woodlander_01",
	"CUP_U_C_Woodlander_02",
	"CUP_U_C_Woodlander_03",
	"CUP_U_C_Woodlander_04",
	"CUP_U_C_Worker_03",
	"CUP_U_C_Worker_04",
	"CUP_U_C_Worker_02",
	"CUP_U_C_Worker_01",
	"CUP_U_B_BAF_DDPM_Ghillie",
	"CUP_U_B_BAF_MTP_Ghillie",
	"CUP_U_B_BAF_DPM_Ghillie",
	"CUP_U_B_GER_Ghillie",
	"CUP_U_B_GER_Fleck_Ghillie",
	"CUP_U_B_USMC_Ghillie_WDL",
	"CUP_U_I_Ghillie_Top",
	"CUP_U_O_RUS_Ghillie",
	"CUP_U_O_TK_Ghillie",
	"CUP_U_O_TK_Ghillie_Top",
	"CUP_U_B_USArmy_Ghillie"
];

blck_CUPVests = [
	"CUP_V_BAF_Osprey_Mk2_DDPM_Grenadier",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Medic",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Officer",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Sapper",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Scout",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Soldier1",
	"CUP_V_BAF_Osprey_Mk2_DDPM_Soldier2",
	"CUP_V_BAF_Osprey_Mk2_DPM_Grenadier",
	"CUP_V_BAF_Osprey_Mk2_DPM_Medic",
	"CUP_V_BAF_Osprey_Mk2_DPM_Officer",
	"CUP_V_BAF_Osprey_Mk2_DPM_Sapper",
	"CUP_V_BAF_Osprey_Mk2_DPM_Scout",
	"CUP_V_BAF_Osprey_Mk2_DPM_Soldier1",
	"CUP_V_BAF_Osprey_Mk2_DPM_Soldier2",
	"CUP_V_BAF_Osprey_Mk4_MTP_Grenadier",
	"CUP_V_BAF_Osprey_Mk4_MTP_MachineGunner",
	"CUP_V_BAF_Osprey_Mk4_MTP_Rifleman",
	"CUP_V_BAF_Osprey_Mk4_MTP_SquadLeader",
	"CUP_V_B_GER_Carrier_Rig",
	"CUP_V_B_GER_Carrier_Rig_2",
	"CUP_V_B_GER_Carrier_Vest",
	"CUP_V_B_GER_Carrier_Vest_2",
	"CUP_V_B_GER_Carrier_Vest_3",
	"CUP_V_B_GER_Vest_1",
	"CUP_V_B_GER_Vest_2",
	"CUP_V_B_LHDVest_Blue",
	"CUP_V_B_LHDVest_Brown",
	"CUP_V_B_LHDVest_Green",
	"CUP_V_B_LHDVest_Red",
	"CUP_V_B_LHDVest_Violet",
	"CUP_V_B_LHDVest_White",
	"CUP_V_B_LHDVest_Yellow",
	"CUP_V_B_MTV",
	"CUP_V_B_MTV_LegPouch",
	"CUP_V_B_MTV_MG",
	"CUP_V_B_MTV_Marksman",
	"CUP_V_B_MTV_Mine",
	"CUP_V_B_MTV_Patrol",
	"CUP_V_B_MTV_PistolBlack",
	"CUP_V_B_MTV_Pouches",
	"CUP_V_B_MTV_TL",
	"CUP_V_B_MTV_noCB",
	"CUP_V_B_PilotVest",
	"CUP_V_B_RRV_DA1",
	"CUP_V_B_RRV_DA2",
	"CUP_V_B_RRV_Light",
	"CUP_V_B_RRV_MG",
	"CUP_V_B_RRV_Medic",
	"CUP_V_B_RRV_Officer",
	"CUP_V_B_RRV_Scout",
	"CUP_V_B_RRV_Scout2",
	"CUP_V_B_RRV_Scout3",
	"CUP_V_B_RRV_TL",
	"CUP_V_I_Carrier_Belt",
	"CUP_V_I_Guerilla_Jacket",
	"CUP_V_I_RACS_Carrier_Vest",
	"CUP_V_I_RACS_Carrier_Vest_2",
	"CUP_V_I_RACS_Carrier_Vest_3",
	"CUP_V_OI_TKI_Jacket1_01",
	"CUP_V_OI_TKI_Jacket1_02",
	"CUP_V_OI_TKI_Jacket1_03",
	"CUP_V_OI_TKI_Jacket1_04",
	"CUP_V_OI_TKI_Jacket1_05",
	"CUP_V_OI_TKI_Jacket1_06",
	"CUP_V_OI_TKI_Jacket2_01",
	"CUP_V_OI_TKI_Jacket2_02",
	"CUP_V_OI_TKI_Jacket2_03",
	"CUP_V_OI_TKI_Jacket2_04",
	"CUP_V_OI_TKI_Jacket2_05",
	"CUP_V_OI_TKI_Jacket2_06",
	"CUP_V_OI_TKI_Jacket3_01",
	"CUP_V_OI_TKI_Jacket3_02",
	"CUP_V_OI_TKI_Jacket3_03",
	"CUP_V_OI_TKI_Jacket3_04",
	"CUP_V_OI_TKI_Jacket3_05",
	"CUP_V_OI_TKI_Jacket3_06",
	"CUP_V_OI_TKI_Jacket4_01",
	"CUP_V_OI_TKI_Jacket4_02",
	"CUP_V_OI_TKI_Jacket4_03",
	"CUP_V_OI_TKI_Jacket4_04",
	"CUP_V_OI_TKI_Jacket4_05",
	"CUP_V_OI_TKI_Jacket4_06",
	"CUP_V_O_SLA_Carrier_Belt",
	"CUP_V_O_SLA_Carrier_Belt02",
	"CUP_V_O_SLA_Carrier_Belt03",
	"CUP_V_O_SLA_Flak_Vest01",
	"CUP_V_O_SLA_Flak_Vest02",
	"CUP_V_O_SLA_Flak_Vest03",
	"CUP_V_O_TK_CrewBelt",
	"CUP_V_O_TK_OfficerBelt",
	"CUP_V_O_TK_OfficerBelt2",
	"CUP_V_O_TK_Vest_1",
	"CUP_V_O_TK_Vest_2"
];

blck_CUPBackpacks = [
	"CUP_B_ACRPara_m95",
	"CUP_B_AssaultPack_ACU",
	"CUP_B_AssaultPack_Black",
	"CUP_B_AssaultPack_Coyote",
	"CUP_B_Bergen_BAF",
	"CUP_B_CivPack_WDL",
	"CUP_B_GER_Pack_Flecktarn",
	"CUP_B_GER_Pack_Tropentarn",
	"CUP_B_HikingPack_Civ",
	"CUP_B_MOLLE_WDL",
	"CUP_B_RUS_Backpack",
	"CUP_B_USMC_AssaultPack",
	"CUP_B_USMC_MOLLE",
	"CUP_B_USPack_Black",
	"CUP_B_USPack_Coyote"
];

blck_CUPHeadgear = [
	"CUP_H_BAF_Helmet_1_DDPM",
	"CUP_H_BAF_Helmet_1_DPM",
	"CUP_H_BAF_Helmet_1_MTP",
	"CUP_H_BAF_Helmet_2_DDPM",
	"CUP_H_BAF_Helmet_2_DPM",
	"CUP_H_BAF_Helmet_2_MTP",
	"CUP_H_BAF_Helmet_3_DDPM",
	"CUP_H_BAF_Helmet_3_DPM",
	"CUP_H_BAF_Helmet_3_MTP",
	"CUP_H_BAF_Helmet_4_DDPM",
	"CUP_H_BAF_Helmet_4_DPM",
	"CUP_H_BAF_Helmet_4_MTP",
	"CUP_H_BAF_Officer_Beret_PRR_O",
	"CUP_H_C_Beanie_01",
	"CUP_H_C_Beanie_02",
	"CUP_H_C_Beanie_03",
	"CUP_H_C_Beanie_04",
	"CUP_H_C_Beret_01",
	"CUP_H_C_Beret_02",
	"CUP_H_C_Beret_03",
	"CUP_H_C_Beret_04",
	"CUP_H_C_Ushanka_01",
	"CUP_H_C_Ushanka_02",
	"CUP_H_C_Ushanka_03",
	"CUP_H_C_Ushanka_04",
	"CUP_H_FR_BandanaGreen",
	"CUP_H_FR_BandanaWdl",
	"CUP_H_FR_Bandana_Headset",
	"CUP_H_FR_BeanieGreen",
	"CUP_H_FR_BoonieMARPAT",
	"CUP_H_FR_BoonieWDL",
	"CUP_H_FR_Cap_Headset_Green",
	"CUP_H_FR_Cap_Officer_Headset",
	"CUP_H_FR_ECH",
	"CUP_H_FR_Headband_Headset",
	"CUP_H_FR_Headset",
	"CUP_H_FR_PRR_BoonieWDL",
	"CUP_H_GER_Boonie_Flecktarn",
	"CUP_H_GER_Boonie_desert",
	"CUP_H_NAPA_Fedora",
	"CUP_H_Navy_CrewHelmet_Blue",
	"CUP_H_Navy_CrewHelmet_Brown",
	"CUP_H_Navy_CrewHelmet_Green",
	"CUP_H_Navy_CrewHelmet_Red",
	"CUP_H_Navy_CrewHelmet_Violet",
	"CUP_H_Navy_CrewHelmet_White",
	"CUP_H_Navy_CrewHelmet_Yellow",
	"CUP_H_PMC_Cap_Grey",
	"CUP_H_PMC_Cap_PRR_Grey",
	"CUP_H_PMC_Cap_PRR_Tan",
	"CUP_H_PMC_Cap_Tan",
	"CUP_H_PMC_EP_Headset",
	"CUP_H_PMC_PRR_Headset",
	"CUP_H_RACS_Beret_Blue",
	"CUP_H_RACS_Helmet_DPAT",
	"CUP_H_RACS_Helmet_Des",
	"CUP_H_RACS_Helmet_Goggles_DPAT",
	"CUP_H_RACS_Helmet_Goggles_Des",
	"CUP_H_RACS_Helmet_Headset_DPAT",
	"CUP_H_RACS_Helmet_Headset_Des",
	"CUP_H_SLA_BeenieGreen",
	"CUP_H_SLA_Beret",
	"CUP_H_SLA_Boonie",
	"CUP_H_SLA_Helmet",
	"CUP_H_SLA_OfficerCap",
	"CUP_H_SLA_Pilot_Helmet",
	"CUP_H_SLA_SLCap",
	"CUP_H_SLA_TankerHelmet",
	"CUP_H_TKI_Lungee_01",
	"CUP_H_TKI_Lungee_02",
	"CUP_H_TKI_Lungee_03",
	"CUP_H_TKI_Lungee_04",
	"CUP_H_TKI_Lungee_05",
	"CUP_H_TKI_Lungee_06",
	"CUP_H_TKI_Lungee_Open_01",
	"CUP_H_TKI_Lungee_Open_02",
	"CUP_H_TKI_Lungee_Open_03",
	"CUP_H_TKI_Lungee_Open_04",
	"CUP_H_TKI_Lungee_Open_05",
	"CUP_H_TKI_Lungee_Open_06",
	"CUP_H_TKI_Pakol_1_01",
	"CUP_H_TKI_Pakol_1_02",
	"CUP_H_TKI_Pakol_1_03",
	"CUP_H_TKI_Pakol_1_04",
	"CUP_H_TKI_Pakol_1_05",
	"CUP_H_TKI_Pakol_1_06",
	"CUP_H_TKI_Pakol_2_01",
	"CUP_H_TKI_Pakol_2_02",
	"CUP_H_TKI_Pakol_2_03",
	"CUP_H_TKI_Pakol_2_04",
	"CUP_H_TKI_Pakol_2_05",
	"CUP_H_TKI_Pakol_2_06",
	"CUP_H_TKI_SkullCap_01",
	"CUP_H_TKI_SkullCap_02",
	"CUP_H_TKI_SkullCap_03",
	"CUP_H_TKI_SkullCap_04",
	"CUP_H_TKI_SkullCap_05",
	"CUP_H_TKI_SkullCap_06",
	"CUP_H_TK_Beret",
	"CUP_H_TK_Helmet",
	"CUP_H_TK_Lungee",
	"CUP_H_TK_PilotHelmet",
	"CUP_H_TK_TankerHelmet",
	"CUP_H_USMC_Crew_Helmet",
	"CUP_H_USMC_Goggles_HelmetWDL",
	"CUP_H_USMC_HeadSet_GoggleW_HelmetWDL",
	"CUP_H_USMC_HeadSet_HelmetWDL",
	"CUP_H_USMC_HelmetWDL",
	"CUP_H_USMC_Helmet_Pilot",
	"CUP_H_USMC_Officer_Cap"
];
blck_RHS_Weapons = [
	"rhs_weap_hk416d10",
	"rhs_weap_hk416d10_LMT",
	"rhs_weap_hk416d10_m320",
	"rhs_weap_hk416d145",
	"rhs_weap_hk416d145_m320",
	"rhs_weap_m16a4",
	"rhs_weap_m16a4_carryhandle",
	"rhs_weap_m16a4_carryhandle_M203",
	"rhs_weap_m16a4_carryhandle_pmag",
	"rhs_weap_m4_carryhandle",
	"rhs_weap_m4_carryhandle_pmag",
	"rhs_weap_m4_m203",
	"rhs_weap_m4_m320",
	"rhs_weap_m4a1",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_KAC",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII_KAC_d",
	"rhs_weap_m4a1_blockII_KAC_wd",
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_blockII_M203_bk",
	"rhs_weap_m4a1_blockII_M203_d",
	"rhs_weap_m4a1_blockII_M203_wd",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_blockII_d",
	"rhs_weap_m4a1_blockII_wd",
	"rhs_weap_m4a1_carryhandle",
	"rhs_weap_m4a1_carryhandle_m203",
	"rhs_weap_m4a1_carryhandle_pmag",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m320",
	"rhs_weap_mk18",
	"rhs_weap_mk18",
	"rhs_weap_mk18_KAC",
	"rhs_weap_mk18_KAC_bk",
	"rhs_weap_mk18_KAC_d",
	"rhs_weap_mk18_KAC_wd",
	"rhs_weap_mk18_bk",
	"rhs_weap_mk18_d",
	"rhs_weap_mk18_m320",
	"rhs_weap_mk18_wd",
	"rhs_weap_m249_pip_L",
	"rhs_weap_m249_pip_L_para",
	"rhs_weap_m249_pip_L_vfg",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m249_pip_S_para",
	"rhs_weap_m249_pip_S_vfg",
	"rhs_weap_m240B",
	"rhs_weap_m240B_CAP",
	"rhs_weap_m240G",
	"rhs_weap_pkm",
	"rhs_weap_pkp",
	// Added by ElShotte - 1 Item
	"rhs_weap_m27iar"
];

blck_RHS_UniformsUSAF = [
	"rhs_uniform_FROG01_m81",
	"rhs_uniform_FROG01_d",
	"rhs_uniform_FROG01_wd",
	"rhs_uniform_cu_ocp",
	"rhs_uniform_cu_ucp",
	"rhs_uniform_cu_ocp_101st",
	"rhs_uniform_cu_ocp_10th",
	"rhs_uniform_cu_ocp_1stcav",
	"rhs_uniform_cu_ocp_82nd",
	"rhs_uniform_cu_ucp_101st",
	"rhs_uniform_cu_ucp_10th",
	"rhs_uniform_cu_ucp_1stcav",
	"rhs_uniform_cu_ucp_82nd",
	"rhs_uniform_cu_ocp_patchless",
	"rhs_uniform_cu_ucp_patchless",
	// Added by ElShotte - 5 Items
	"rhs_uniform_g3_m81",
	"rhs_uniform_g3_blk",
	"rhs_uniform_g3_mc",
	"rhs_uniform_g3_rgr",
	"rhs_uniform_g3_tan"

];

blck_RHS_VestsUSAF = [
	"rhsusf_iotv_ucp",
	"rhsusf_iotv_ucp_grenadier",
	"rhsusf_iotv_ucp_medic",
	"rhsusf_iotv_ucp_repair",
	"rhsusf_iotv_ucp_rifleman",
	"rhsusf_iotv_ucp_SAW",
	"rhsusf_iotv_ucp_squadleader",
	"rhsusf_iotv_ucp_teamleader",
	"rhsusf_iotv_ocp",
	"rhsusf_iotv_ocp_grenadier",
	"rhsusf_iotv_ocp_medic",
	"rhsusf_iotv_ocp_repair",
	"rhsusf_iotv_ocp_rifleman",
	"rhsusf_iotv_ocp_SAW",
	"rhsusf_iotv_ocp_squadleader",
	"rhsusf_iotv_ocp_teamleader",
	//added by chainsaw - 2
	"rhsusf_spc",
	"rhsusf_spc_mg",
	// Added by ElShotte - 12 Items
	"rhsusf_spc_marksman",
	"rhsusf_spc_corpsman",
	"rhsusf_spc_patchless",
	"rhsusf_spc_squadleader",
	"rhsusf_spc_teamleader",
	"rhsusf_spc_light",
	"rhsusf_spc_rifleman",
	"rhsusf_spc_iar",
	"rhsusf_spcs_ocp_rifleman",
	"rhsusf_spcs_ocp",
	"rhsusf_spcs_ucp_rifleman",
	"rhsusf_spcs_ucp"

];

blck_RHS_BackpacksUSAF = [
	"rhsusf_assault_eagleaiii_coy",
	"rhsusf_assault_eagleaiii_ocp",
	"rhsusf_assault_eagleaiii_ucp",
	"rhsusf_falconii_coy",
	"rhsusf_falconii_mc",
	"rhsusf_falconii",
	"RHS_M2_Gun_Bag"

];

blck_RHS_HeadgearUSAF = [
	"rhs_Booniehat_m81",
	"rhs_Booniehat_marpatd",
	"rhs_Booniehat_marpatwd",
	"rhs_Booniehat_ocp",
	"rhs_Booniehat_ucp",
	"rhsusf_Bowman",
	"rhsusf_ach_bare",
	"rhsusf_ach_bare_des",
	"rhsusf_ach_bare_des_ess",
	"rhsusf_ach_bare_des_headset",
	"rhsusf_ach_bare_des_headset_ess",
	"rhsusf_ach_bare_ess",
	"rhsusf_ach_bare_headset",
	"rhsusf_ach_bare_headset_ess",
	"rhsusf_ach_bare_semi",
	"rhsusf_ach_bare_semi_ess",
	"rhsusf_ach_bare_semi_headset",
	"rhsusf_ach_bare_semi_headset_ess",
	"rhsusf_ach_bare_tan",
	"rhsusf_ach_bare_tan_ess",
	"rhsusf_ach_bare_tan_headset",
	"rhsusf_ach_bare_tan_headset_ess",
	"rhsusf_ach_bare_wood",
	"rhsusf_ach_bare_wood_ess",
	"rhsusf_ach_bare_wood_headset",
	"rhsusf_ach_bare_wood_headset_ess",
	"rhsusf_ach_helmet_ESS_ocp",
	"rhsusf_ach_helmet_ESS_ucp",
	"rhsusf_ach_helmet_M81",
	"rhsusf_ach_helmet_camo_ocp",
	"rhsusf_ach_helmet_headset_ess_ocp",
	"rhsusf_ach_helmet_headset_ess_ucp",
	"rhsusf_ach_helmet_headset_ocp",
	"rhsusf_ach_helmet_headset_ucp",
	"rhsusf_ach_helmet_ocp",
	"rhsusf_ach_helmet_ocp_norotos",
	"rhsusf_ach_helmet_ucp",
	"rhsusf_ach_helmet_ucp_norotos",
	"rhsusf_bowman_cap",
	"rhsusf_lwh_helmet_M1942",
	"rhsusf_lwh_helmet_marpatd",
	"rhsusf_lwh_helmet_marpatd_ess",
	"rhsusf_lwh_helmet_marpatd_headset",
	"rhsusf_lwh_helmet_marpatwd",
	"rhsusf_lwh_helmet_marpatwd_ess",
	"rhsusf_lwh_helmet_marpatwd_headset",
	"rhsusf_mich_bare",
	"rhsusf_mich_bare_alt",
	"rhsusf_mich_bare_alt_semi",
	"rhsusf_mich_bare_alt_tan",
	"rhsusf_mich_bare_headset",
	"rhsusf_mich_bare_norotos",
	"rhsusf_mich_bare_norotos_alt",
	"rhsusf_mich_bare_norotos_alt_headset",
	"rhsusf_mich_bare_norotos_alt_semi",
	"rhsusf_mich_bare_norotos_alt_semi_headset",
	"rhsusf_mich_bare_norotos_alt_tan",
	"rhsusf_mich_bare_norotos_alt_tan_headset",
	"rhsusf_mich_bare_norotos_arc",
	"rhsusf_mich_bare_norotos_arc_alt",
	"rhsusf_mich_bare_norotos_arc_alt_headset",
	"rhsusf_mich_bare_norotos_arc_alt_semi",
	"rhsusf_mich_bare_norotos_arc_alt_semi_headset",
	"rhsusf_mich_bare_norotos_arc_alt_tan",
	"rhsusf_mich_bare_norotos_arc_alt_tan_headset",
	"rhsusf_mich_bare_norotos_arc_headset",
	"rhsusf_mich_bare_norotos_arc_semi",
	"rhsusf_mich_bare_norotos_arc_semi_headset",
	"rhsusf_mich_bare_norotos_arc_tan",
	"rhsusf_mich_bare_norotos_headset",
	"rhsusf_mich_bare_norotos_semi",
	"rhsusf_mich_bare_norotos_semi_headset",
	"rhsusf_mich_bare_norotos_tan",
	"rhsusf_mich_bare_norotos_tan_headset",
	"rhsusf_mich_bare_semi",
	"rhsusf_mich_bare_semi_headset",
	"rhsusf_mich_bare_tan",
	"rhsusf_mich_bare_tan_headset",
	"rhsusf_mich_helmet_marpatd_alt_headset",
	"rhsusf_mich_helmet_marpatd_headset",
	"rhsusf_mich_helmet_marpatd_norotos",
	"rhsusf_mich_helmet_marpatd_norotos_arc",
	"rhsusf_mich_helmet_marpatd_norotos_arc_headset",
	"rhsusf_mich_helmet_marpatd_norotos_headset",
	"rhsusf_mich_helmet_marpatwd",
	"rhsusf_mich_helmet_marpatwd_alt",
	"rhsusf_mich_helmet_marpatwd_alt_headset",
	"rhsusf_mich_helmet_marpatwd_headset",
	"rhsusf_mich_helmet_marpatwd_norotos",
	"rhsusf_mich_helmet_marpatwd_norotos_arc",
	"rhsusf_mich_helmet_marpatwd_norotos_arc_headset",
	"rhsusf_mich_helmet_marpatwd_norotos_headset",
	// added by chainsaw - 13
	"rhsusf_patrolcap_ocp",
	"rhsusf_patrolcap_ucp",
	"rhsusf_opscore_01",
	"rhsusf_opscore_01_tan",
	"rhsusf_opscore_02_tan",
	"rhsusf_opscore_03_ocp",
	"rhsusf_opscore_04_ocp",
	"rhsusf_cvc_helmet",
	"rhsusf_cvc_ess",
	"rhsusf_hgu56p",
	"rhsusf_hgu56p_mask",
	"rhsusf_cvc_green_helmet",
	"rhsusf_cvc_green_ess",
	// Added by ElShotte - 41 Items
	"rhsusf_opscore_bk_pelt",
	"rhsusf_opscore_bk",
	"rhsusf_opscore_coy_cover",
	"rhsusf_opscore_coy_cover_pelt",
	"rhsusf_opscore_fg",
	"rhsusf_opscore_fg_pelt",
	"rhsusf_opscore_fg_pelt_cam",
	"rhsusf_opscore_fg_pelt_nsw",
	"rhsusf_opscore_mc",
	"rhsusf_opscore_mc_pelt",
	"rhsusf_opscore_mc_pelt_nsw",
	"rhsusf_opscore_mc_cover",
	"rhsusf_opscore_mc_cover_pelt",
	"rhsusf_opscore_mc_cover_pelt_nsw",
	"rhsusf_opscore_mc_cover_pelt_cam",
	"rhsusf_opscore_paint",
	"rhsusf_opscore_paint_pelt",
	"rhsusf_opscore_paint_pelt_nsw",
	"rhsusf_opscore_paint_pelt_nsw_cam",
	"rhsusf_opscore_rg_cover",
	"rhsusf_opscore_rg_cover_pelt",
	"rhsusf_opscore_ut",
	"rhsusf_opscore_ut_pelt",
	"rhsusf_opscore_ut_pelt_cam",
	"rhsusf_opscore_ut_pelt_nsw",
	"rhsusf_opscore_ut_pelt_nsw_cam",
	"rhsusf_opscore_mar_ut_pelt",
	"rhsusf_opscore_mar_ut",
	"rhsusf_opscore_mar_fg_pelt",
	"rhsusf_opscore_mar_fg",
	"rhsusf_protech_helmet",
	"rhsusf_protech_helmet_ess",
	"rhsusf_protech_helmet_rhino",
	"rhsusf_protech_helmet_rhino_ess"
];

blck_RHS_UniformsGREF = [
	"rhsgref_uniform_alpenflage",
	"rhsgref_uniform_flecktarn",
	"rhsgref_uniform_para_ttsko_mountain",
	"rhsgref_uniform_para_ttsko_oxblood",
	"rhsgref_uniform_para_ttsko_urban",
	"rhsgref_uniform_reed",
	"rhsgref_uniform_specter",
	"rhsgref_uniform_tigerstripe",
	"rhsgref_uniform_ttsko_forest",
	"rhsgref_uniform_ttsko_mountain",
	"rhsgref_uniform_ttsko_urban",
	"rhsgref_uniform_vsr",
	"rhsgref_uniform_woodland",
	"rhsgref_uniform_woodland_olive"
];

blck_RHS_VestsGREF = [
	"rhsgref_6b23",
	"rhsgref_6b23_khaki",
	"rhsgref_6b23_khaki_medic",
	"rhsgref_6b23_khaki_nco",
	"rhsgref_6b23_khaki_officer",
	"rhsgref_6b23_khaki_rifleman",
	"rhsgref_6b23_khaki_sniper",
	"rhsgref_6b23_ttsko_digi",
	"rhsgref_6b23_ttsko_digi_medic",
	"rhsgref_6b23_ttsko_digi_nco",
	"rhsgref_6b23_ttsko_digi_officer",
	"rhsgref_6b23_ttsko_digi_rifleman",
	"rhsgref_6b23_ttsko_digi_sniper",
	"rhsgref_6b23_ttsko_forest",
	"rhsgref_6b23_ttsko_forest_rifleman",
	"rhsgref_6b23_ttsko_mountain",
	"rhsgref_6b23_ttsko_mountain_medic",
	"rhsgref_6b23_ttsko_mountain_nco",
	"rhsgref_6b23_ttsko_mountain_officer",
	"rhsgref_6b23_ttsko_mountain_rifleman",
	"rhsgref_6b23_ttsko_mountain_sniper",
	"rhsgref_otv_digi",
	"rhsgref_otv_khaki"
];

blck_RHS_HeadgearGREF = [
	"rhsgref_6b27m",
	"rhsgref_6b27m_ttsko_digi",
	"rhsgref_6b27m_ttsko_forest",
	"rhsgref_6b27m_ttsko_mountain",
	"rhsgref_6b27m_ttsko_urban",
	"rhsgref_Booniehat_alpen",
	"rhsgref_fieldcap",
	"rhsgref_fieldcap_ttsko_digi",
	"rhsgref_fieldcap_ttsko_forest",
	"rhsgref_fieldcap_ttsko_mountain",
	"rhsgref_fieldcap_ttsko_urban",
	"rhsgref_patrolcap_specter",
	"rhsgref_ssh68",
	"rhsgref_ssh68_emr",
	"rhsgref_ssh68_ttsko_digi",
	"rhsgref_ssh68_ttsko_forest",
	"rhsgref_ssh68_ttsko_mountain",
	"rhsgref_ssh68_un"
];
blck_RHS_WeaponsGREF = [
	"rhs_weap_kar98k",
	"rhs_weap_m21a",
	"rhs_weap_m21a_fold",
	"rhs_weap_m21a_pr",
	"rhs_weap_m21s",
	"rhs_weap_m21s_fold",
	"rhs_weap_m21s_pr",
	"rhs_weap_m38",
	"rhs_weap_m70ab2",
	"rhs_weap_m70ab2_fold",
	"rhs_weap_m70b1",
	"rhs_weap_m76",
	"rhs_weap_m92",
	"rhs_weap_m92_fold"
];

blck_RHS_HeadgearSAF = [
	"rhssaf_helmet_m59_85_nocamo",
	"rhssaf_helmet_m59_85_oakleaf",
	"rhssaf_helmet_m97_olive_nocamo",
	"rhssaf_helmet_m97_olive_nocamo_black_ess",
	"rhssaf_helmet_m97_olive_nocamo_black_ess_bare",
	"rhssaf_helmet_m97_black_nocamo",
	"rhssaf_helmet_m97_black_nocamo_black_ess",
	"rhssaf_helmet_m97_black_nocamo_black_ess_bare",
	"rhssaf_Helmet_m97_woodland",
	"rhssaf_Helmet_m97_digital",
	"rhssaf_Helmet_m97_md2camo",
	"rhssaf_Helmet_m97_oakleaf",
	"rhssaf_helmet_m97_nostrap_blue",
	"rhssaf_helmet_m97_nostrap_blue_tan_ess",
	"rhssaf_helmet_m97_nostrap_blue_tan_ess_bare",
	"rhssaf_helmet_m97_woodland_black_ess",
	"rhssaf_helmet_m97_woodland_black_ess_bare",
	"rhssaf_helmet_m97_digital_black_ess",
	"rhssaf_helmet_m97_digital_black_ess_bare",
	"rhssaf_helmet_m97_md2camo_black_ess",
	"rhssaf_helmet_m97_md2camo_black_ess_bare",
	"rhssaf_helmet_m97_oakleaf_black_ess",
	"rhssaf_helmet_m97_oakleaf_black_ess_bare",
	"rhssaf_helmet_hgu56p",
	"rhssaf_beret_green",
	"rhssaf_beret_red",
	"rhssaf_beret_black",
	"rhssaf_beret_blue_un",
	"rhssaf_booniehat_digital",
	"rhssaf_booniehat_md2camo",
	"rhssaf_booniehat_woodland"
];

blck_RHS_UniformsSAF = [
	"rhssaf_uniform_m10_digital",
	"rhssaf_uniform_m10_digital_summer",
	"rhssaf_uniform_m10_digital_desert",
	"rhssaf_uniform_m10_digital_tan_boots",
	"rhssaf_uniform_m93_oakleaf",
	"rhssaf_uniform_m93_oakleaf_summer",
	"rhssaf_uniform_heli_pilot"
];

blck_RHS_VestsSAF = [
	"rhssaf_vest_md98_woodland",
	"rhssaf_vest_md98_md2camo",
	"rhssaf_vest_md98_digital",
	"rhssaf_vest_md98_officer",
	"rhssaf_vest_md98_rifleman",
	"rhssaf_vest_otv_md2camo",
	"rhssaf_vest_md99_md2camo_rifleman",
	"rhssaf_vest_md99_digital_rifleman",
	"rhssaf_vest_md99_woodland_rifleman",
	"rhssaf_vest_md99_md2camo",
	"rhssaf_vest_md99_digital",
	"rhssaf_vest_md99_woodland"
];

blck_RHS_BackpacksSAF = [
	"rhssaf_30rnd_556x45_EPR_G36",
	"rhssaf_30rnd_556x45_SOST_G36",
	"rhssaf_100rnd_556x45_EPR_G36",
	"rhssaf_30rnd_556x45_SPR_G36",
	"rhssaf_30rnd_556x45_Tracers_G36",
	"rhssaf_30rnd_556x45_MDIM_G36",
	"rhssaf_30rnd_556x45_TDIM_G36",
	"150Rnd_556x45_Drum_Mag_F",
	"150Rnd_556x45_Drum_Mag_Tracer_F",
	"rhs_30Rnd_762x39mm",
	"rhs_30Rnd_762x39mm_tracer",
	"rhs_30Rnd_762x39mm_89",
	"rhs_30Rnd_762x39mm_U",
	"rhsgref_30rnd_556x45_m21",
	"rhsgref_30rnd_556x45_m21_t",
	"rhs_100Rnd_762x54mmR",
	"rhs_100Rnd_762x54mmR_green",
	"rhssaf_250Rnd_762x54R"
];

blck_RHS_WeaponsSAF = [
	"rhs_weap_m70ab2_fold",
	"rhs_weap_m70b1",
	"rhs_weap_m70b1n",
	"rhs_weap_m70b3n",
	"rhs_weap_m70b3n_pbg40",
	"rhs_weap_m92",
	"rhs_weap_m92_fold",
	"rhs_weap_m76",
	"rhs_weap_m21a",
	"rhs_weap_m21a_pr",
	"rhs_weap_m21a_pr_pbg40",
	"rhs_weap_m21a_fold",
	"rhs_weap_m21a_pbg40",
	"rhs_weap_m21s",
	"rhs_weap_m21s_pr",
	"rhs_weap_m21s_fold",
	"rhs_weap_m82a1",
	"rhs_weap_minimi_para_railed",
	"rhs_weap_g36c",
	"rhs_weap_g36kv",
	"rhs_weap_g36kv_ag36",
	"rhs_weap_m84"
];	

blck_NIA_WeaponsLMG = [
	"hlc_lmg_M249E2",
	"hlc_lmg_M249E2",
	"hlc_lmg_M60E4",
	"hlc_lmg_MG3KWS_b",
	"hlc_lmg_MG3KWS_g",
	"hlc_lmg_MG42",
	"hlc_lmg_MG42KWS_t",
	"hlc_lmg_m249para",
	"hlc_lmg_m249para",
	"hlc_lmg_m60",
	"hlc_lmg_mg42kws_b",
	"hlc_lmg_mg42kws_g",
	"hlc_lmg_minimi",
	"hlc_lmg_minimi_railed",
	"hlc_lmg_minimipara",
	"hlc_lmg_mk48",
	"hlc_m249_pip1",
	"hlc_m249_pip2",
	"hlc_m249_pip3",
	"hlc_m249_pip4",
	"hlc_rifle_rpk",
	"hlc_rifle_rpk12",
	"hlc_rifle_rpk74n"
];

blck_NIA_WeaponsSMG = [
	"hlc_smg_9mmar",
	"hlc_smg_MP5N",
	"hlc_smg_mp510",
	"hlc_smg_mp5a2",
	"hlc_smg_mp5a3",
	"hlc_smg_mp5a4",
	"hlc_smg_mp5k",
	"hlc_smg_mp5k_PDW",
	"hlc_smg_mp5sd5",
	"hlc_smg_mp5sd6"
];

blck_NIA_WeaponsAR = [
	"HLC_Rifle_g3ka4_GL",
	"hlc_barrel_carbine",
	"hlc_barrel_hbar",
	"hlc_barrel_standard",
	"hlc_rifle_Bushmaster300",
	"hlc_rifle_Colt727",
	"hlc_rifle_Colt727_GL",
	"hlc_rifle_FAL5000",
	"hlc_rifle_FAL5000Rail",
	"hlc_rifle_FAL5000_RH",
	"hlc_rifle_FAL5061",
	"hlc_rifle_FAL5061Rail",
	"hlc_rifle_G36A1",
	"hlc_rifle_G36A1AG36",
	"hlc_rifle_G36C",
	"hlc_rifle_G36CMLIC",
	"hlc_rifle_G36CTAC",
	"hlc_rifle_G36CV",
	"hlc_rifle_G36E1",
	"hlc_rifle_G36E1AG36",
	"hlc_rifle_G36KA1",
	"hlc_rifle_G36KE1",
	"hlc_rifle_G36KMLIC",
	"hlc_rifle_G36KTAC",
	"hlc_rifle_G36KV",
	"hlc_rifle_G36MLIAG36",
	"hlc_rifle_G36MLIC",
	"hlc_rifle_G36TAC",
	"hlc_rifle_G36V",
	"hlc_rifle_G36VAG36",
	"hlc_rifle_LAR",
	"hlc_rifle_M14",
	"hlc_rifle_M14DMR",
	"hlc_rifle_M21",
	"hlc_rifle_MG36",
	"hlc_rifle_RK62",
	"hlc_rifle_RU556",
	"hlc_rifle_RU5562",
	"hlc_rifle_SAMR",
	"hlc_rifle_SLR",
	"hlc_rifle_SLRchopmod",
	"hlc_rifle_STG58F",
	"hlc_rifle_STGW57",
	"hlc_rifle_aek971",
	"hlc_rifle_aek971_mtk",
	"hlc_rifle_ak12",
	"hlc_rifle_ak12gl",
	"hlc_rifle_ak47",
	"hlc_rifle_ak74",
	"hlc_rifle_ak74_MTK",
	"hlc_rifle_ak74_dirty",
	"hlc_rifle_ak74_dirty2",
	"hlc_rifle_ak74m",
	"hlc_rifle_ak74m_MTK",
	"hlc_rifle_ak74m_gl",
	"hlc_rifle_akm",
	"hlc_rifle_akm_MTK",
	"hlc_rifle_akmgl",
	"hlc_rifle_aks74",
	"hlc_rifle_aks74_GL",
	"hlc_rifle_aks74_MTK",
	"hlc_rifle_aks74u",
	"hlc_rifle_aks74u_MTK",
	"hlc_rifle_aku12",
	"hlc_rifle_amt",
	"hlc_rifle_aug",
	"hlc_rifle_auga1_B",
	"hlc_rifle_auga1_t",
	"hlc_rifle_auga1carb",
	"hlc_rifle_auga1carb_b",
	"hlc_rifle_auga1carb_t",
	"hlc_rifle_auga2",
	"hlc_rifle_auga2_b",
	"hlc_rifle_auga2_t",
	"hlc_rifle_auga2carb",
	"hlc_rifle_auga2carb_b",
	"hlc_rifle_auga2carb_t",
	"hlc_rifle_auga2lsw",
	"hlc_rifle_auga2lsw_b",
	"hlc_rifle_auga2lsw_t",
	"hlc_rifle_auga3",
	"hlc_rifle_auga3_GL",
	"hlc_rifle_auga3_GL_B",
	"hlc_rifle_auga3_GL_BL",
	"hlc_rifle_auga3_b",
	"hlc_rifle_auga3_bl",
	"hlc_rifle_aughbar",
	"hlc_rifle_aughbar_b",
	"hlc_rifle_aughbar_t",
	"hlc_rifle_augsr",
	"hlc_rifle_augsr_b",
	"hlc_rifle_augsr_t",
	"hlc_rifle_augsrcarb",
	"hlc_rifle_augsrcarb_b",
	"hlc_rifle_augsrcarb_t",
	"hlc_rifle_augsrhbar",
	"hlc_rifle_augsrhbar_b",
	"hlc_rifle_augsrhbar_t",
	"hlc_rifle_bcmblackjack",
	"hlc_rifle_bcmjack",
	"hlc_rifle_c1A1",
	"hlc_rifle_falosw",
	"hlc_rifle_g3a3",
	"hlc_rifle_g3a3ris",
	"hlc_rifle_g3a3v",
	"hlc_rifle_g3ka4",
	"hlc_rifle_g3sg1",
	"hlc_rifle_hk33a2",
	"hlc_rifle_hk33a2RIS",
	"hlc_rifle_hk51",
	"hlc_rifle_hk53",
	"hlc_rifle_hk53RAS",
	"hlc_rifle_honeybadger",
	"hlc_rifle_l1a1slr",
	"hlc_rifle_m14sopmod",
	"hlc_rifle_osw_GL",
	"hlc_rifle_rpk74n",
	"hlc_rifle_sig5104",
	"hlc_rifle_slr107u",
	"hlc_rifle_slr107u_MTK",
	"hlc_rifle_stgw57_RIS",
	"hlc_rifle_stgw57_commando",
	"hlc_rifle_vendimus"
];

blck_NIA_WeaponsSniper = [
	"hlc_rifle_M1903A1",
	"hlc_rifle_M1903A1OMR",
	"hlc_rifle_M1903A1_unertl",
	"hlc_rifle_PSG1A1_RIS",
	"hlc_rifle_awMagnum_BL_ghillie",
	"hlc_rifle_awMagnum_FDE_ghillie",
	"hlc_rifle_awMagnum_OD_ghillie",
	"hlc_rifle_awcovert",
	"hlc_rifle_awcovert_BL",
	"hlc_rifle_awcovert_FDE",
	"hlc_rifle_awmagnum",
	"hlc_rifle_awmagnum_BL",
	"hlc_rifle_awmagnum_FDE",
	"hlc_rifle_psg1",
	"hlc_rifle_psg1A1"
];
