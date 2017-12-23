/*
	by Ghostrider [GRG]
	for ghostridergaming
	12/5/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
if (!isServer) exitWith{};

//diag_log "[blckeagls] GMS__UMS_StaticMissions_init.sqf <Initializing Static Mission System>";

//static mission descriptor for code: [position,level, numAI or [min,maxAI],patrolRadius, respawn, group[groupNull],spawnedAt[0],respawn[0]]
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\UMS\GMS_UMS_StaticMissions_Lists.sqf";

//while{ (isNil "blck_sm_functionsLoaded"; uiSleep 0.1];
uiSleep 3;
private["_mod","_map","_missionMod","_missionMap","_missionLocation","_missionDataFile"];
//diag_log "[blckeagls] GMS__UMS_StaticMissions_init.sqf <Getting Mod Type>";
_mod = toLower(call blck_fnc_getModType);
//diag_log format["[blckeagls] GMS__UMS_StaticMissions_init.sqf <mod type = %1>",_mod];
//diag_log format["[blckeagls] GMS__UMS_StaticMissions_init <_staticMissions> = %1",_staticMissions];
//diag_log "[blckeagls] GMS__UMS_StaticMissions_init.sqf <Getting map name>";
_map = toLower worldName;
//diag_log format["[blckeagls] GMS__UMS_StaticMissions_init.sqf <map name = %1>",_map];
{
	//diag_log format["[blckeagls] GMS__UMS_StaticMissions_init.sqf <Evaluating Mission = %1>",_x];
	//diag_log format["[blckeagls] GMS__UMS_StaticMissions_init.sqf <worldName = %1 | _mod = %2>",_map,_mod];	
	if ((_map) isEqualTo toLower(_x select 1)) then
	{
		if ((_mod isEqualTo "epoch") && (toLower(_x select 0) isEqualTo "epoch")) then
		{
			
			call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\UMS\staticMissions\%1",(_x select 2)];
		};

		if ((_mod isEqualTo "exile") && (toLower(_x select 0) isEqualTo "exile")) then
		{
			call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\UMS\staticMissions\%1",(_x select 2)];
		};
	};
	uiSleep 1;
}forEach _staticMissions;

diag_log "[blckeagls] GMS__UMS_StaticMissions_init.sqf <Loaded>";

