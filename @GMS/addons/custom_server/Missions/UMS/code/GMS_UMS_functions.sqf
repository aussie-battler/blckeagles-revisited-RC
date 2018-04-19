/*
	by Ghostrider [GRG]
	Copyright 20167
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
blck_fnc_spawnScubaGroup = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_fnc_spawnScubaGroup.sqf";
blck_fnc_spawnSDVPatrol = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_fnc_spawnSDVPatrol.sqf";
blck_fnc_spawnSurfacePatrol = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_fnc_spawnSurfacePatrol.sqf";
blck_fnc_sm_AddScubaGroup = compileFinal  preprocessFileLineNumbers  "\q\addons\custom_server\Missions\UMS\code\GMS_sm_AddScubaGroup.sqf";
blck_fnc_sm_AddSurfaceVehicle = compileFinal  preprocessFileLineNumbers  "\q\addons\custom_server\Missions\UMS\code\GMS_sm_AddSurfaceVehicle.sqf";
blck_fnc_sm_AddSDVVehicle = compileFinal  preprocessFileLineNumbers  "\q\addons\custom_server\Missions\UMS\code\GMS_sm_AddSDVVehicle.sqf";
blck_fnc_findShoreLocation = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_UMS_fnc_findShoreLocation.sqf";
blck_fnc_addDyanamicUMS_Mission = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_fnc_addDynamicUMS_Mission.sqf";
blck_fnc_findWaterDepth  = compileFinal preprocessFileLineNumbers "q\addons\custom_server\Missions\UMS\code\GMS_UMS_fnc_findWaterDepth.sqf";

diag_log "<GMS_UMS_functions.sqf>  Functions compiled";
