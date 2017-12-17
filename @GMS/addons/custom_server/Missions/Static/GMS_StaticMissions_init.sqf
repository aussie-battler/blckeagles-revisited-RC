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
diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Initializing Static Mission System>";

//static mission descriptor for code: [position,level, numAI or [min,maxAI],patrolRadius, respawn, group[groupNull],spawnedAt[0],respawn[0]]
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\Static\GMS_StaticMissions_Lists.sqf";
#include "\q\addons\custom_server\Missions\Static\Code\GMS_fnc_sm_init_functions.sqf";

private["_mod","_map","_missionMod","_missionMap","_missionLocation","_missionDataFile"];
//diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Getting Mod Type>";
_mod = call blck_fnc_getModType;
//diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <mod type = %1>",_mod];
//diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Getting map name>";
_map = toLower worldName;
diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <map name = %1>",_map];
blck_staticMissions = [];
//diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <_staticMissions = %1>",_staticMissions];
{
	//diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <Spawning Mission = %1>",_x];
	if ((_mod isEqualTo "Epoch")&& _x select 0 isEqualTo "Epoch") then
	{
		 call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\Static\missions\%1",(_x select 2)];
	};
	if ((_mod isEqualTo "Exile")&& _x select 0 isEqualTo "Exile") then
	{
		call compilefinal preprocessFileLineNumbers format["\q\addons\custom_server\Missions\Static\missions\%1",(_x select 2)];
	};
	uiSleep 1;
}forEach _staticMissions;

diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Loaded>";

