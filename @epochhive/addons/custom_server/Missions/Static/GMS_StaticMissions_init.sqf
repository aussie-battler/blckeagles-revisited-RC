/*
	Run scripts exported from M3EDEN Editor plug in for Arma 3 or other map addons. 
	Add addons to the arrays for Epoch or Exile as appropriate.
	Arrays should contain ["mapname", "name of folder within mapaddons","name of file to execute"]
	by Ghostrider-DbD-
	for DBD Clan
	11/12/16
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
if (!isServer) exitWith{};

diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Initializing Static Mission System>";

#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#include "\q\addons\custom_server\Missions\Static\GMS_StaticMissions_Lists.sqf";
[] execVM "\q\addons\custom_server\Missions\Static\Code\GMS_sm_init_functions.sqf";
//while{ (isNil "blck_sm_functionsLoaded"; uiSleep 0.1];
uiSleep 3;
private["_mod","_map","_missionMod","_missionMap","_missionLocation","_missionDataFile"];
diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Getting Mod Type>";
_mod = call blck_fnc_getModType;
diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <mod type = %1>",_mod];
diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Getting map name>";
_map = toLower worldName;
diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <map name = %1>",_map];
blck_staticMissions = [];
diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <_staticMissions = %1>",_staticMissions];
{
	diag_log format["[blckeagls] GMS_StaticMissions_init.sqf <Spawning Mission = %1>",_x];
	[] execVM format["%1",(_x select 2)];
	uiSleep 15;
}forEach _staticMissions;
/*
{
	_missionMod = _x select 0;
	_missionMap = _x select 1;
	//_missionLocation = _x select 2;
	_missionDataFile = _x select 2;
	diag_log format["blckegls] Static Mission System: <Configuring Stating Mission %1>",_x];
	if (_mod isEqualTo _missionMod && _map isEqualTo _missionMap) then {blck_staticMissions pusback [_missionDataFile];
}forEach _staticMissions;

diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Spawnint Static Missions>";
{
	diag_log format["[blckeagls] Static Mission System: Initializing Mission %1", (_x select 0)];
	[_x select 0] execVM format["%1", _x select 0];
} forEach blck_staticMissions;
*/
diag_log "[blckeagls] GMS_StaticMissions_init.sqf <Loaded>";

