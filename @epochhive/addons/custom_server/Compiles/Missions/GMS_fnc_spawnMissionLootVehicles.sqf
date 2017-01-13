/*
	[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;
	returns _vehs, an array of vehicles spawned.
	by Ghostridere-DbD-
	1/10/17
*/
params["_missionLootVehicles"];
private _vehs = [];
{
	//diag_log format["spawnMissionCVehicles.sqf _x = %1",_x];
	_offset = _x select 1; // offset relative to _coords at which to spawn the vehicle
	_pos = [(_coords select 0)+(_offset select 0),(_coords select 1) + (_offset select 1),(_coords select 2)+(_offset select 2)];
	_veh = [_x select 0 /* vehicle class name*/, _pos] call blck_fnc_spawnVehicle;
	_vehs pushback _veh;
	[_veh,_x select 2 /*loot array*/, _x select 3 /*array of values specifying number of items of each loot type to load*/] call blck_fnc_fillBoxes;
}forEach _missionLootVehicles;
_vehs