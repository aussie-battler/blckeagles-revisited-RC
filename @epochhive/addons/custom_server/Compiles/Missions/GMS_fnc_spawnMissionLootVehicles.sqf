/*
	[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;
	returns _vehs, an array of vehicles spawned.
	by Ghostridere-DbD-
	3/20/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_missionLootVehicles",["_loadCrateTiming","atMissionSpawn"]];
private _vehs = [];
{
	//diag_log format["spawnMissionCVehicles.sqf _x = %1",_x];
	_x params["_vehType","_vehOffset","_lootArray","_lootCounts"];
	//diag_log format["spawnMissionCVehicles: _vehType = %1 | _vehOffset = %2 | _lootArray = %3 | _lootCounts = %4",_vehType,_vehOffset,_lootArray,_lootCounts];
	_pos = _coords vectorAdd _vehOffset;
	_veh = [_vehType, _pos] call blck_fnc_spawnVehicle;
	[_veh] call blck_fnc_emptyObject;
	_veh setVehicleLock "UNLOCKED";
	{
		_veh removeAllEventHandlers _x;
	}forEach ["getin","getout"];
	if (_loadCrateTiming isEqualTo "atMissionSpawn") then
	{
		//diag_log format["blck_fnc_spawnMissionLootVehicles::-> loading loot at mission spawn for veh %1",_x];
		[_veh,_lootArray,_lootCounts] call blck_fnc_fillBoxes;
		_veh setVariable["lootLoaded",true];
	}
	else
	{
		//diag_log format["blck_fnc_spawnMissionLootVehicles::-> not loading veh loot at this time for veh %1",_x];
	};
	_vehs pushback _veh;
}forEach _missionLootVehicles;
_vehs
