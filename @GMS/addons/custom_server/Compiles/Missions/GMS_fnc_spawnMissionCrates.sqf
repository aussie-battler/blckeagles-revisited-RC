/*
	Spawn some crates using an array containing crate types and their offsets relative to a reference position and prevent their cleanup.
	By Ghostrider [GRG]
	Copyright 2016
	Last updated 3-20-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_objs","_pos","_offset"];
params[ ["_coords", [0,0,0]], ["_crates",[]], ["_loadCrateTiming","atMissionSpawn"] ];
//diag_log format["_fnc_spawnMissionLootcrates:  _this = %1",_this];
if ((count _coords) == 2) then // assume only X and Y offsets are provided
{
	_coords pushback 0;; // calculate the world coordinates
};
_objs = [];
{
	_x params["_crateType","_crateOffset","_lootArray","_lootCounts"];
	//_pos = [(_coords select 0)+(_crateOffset select 0),(_coords select 1) + (_crateOffset select 1),(_coords select 2)+(_crateOffset select 2)]; // calculate the world coordinates

	_pos = _coords vectorAdd _crateOffset;
	_crate = [_pos,_crateType] call blck_fnc_spawnCrate;
	_objs pushback _crate;
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionCrates: _crateType = %1 | _crateOffset = %2 | _lootArray = %3 | _lootCounts = %4",_crateType,_crateOffset,_lootArray,_lootCounts];
		_marker = createMarker [format["crateMarker%1",random(1000000)], _pos];
		_marker setMarkerType "mil_triangle";
		_marker setMarkerColor "colorGreen";		
	};
	#endif	
	if (_loadCrateTiming isEqualTo "atMissionSpawn") then
	{
		//diag_log format["_fnc_spawnMissionCrates::-> loading loot at mission spawn for crate %1",_x];
		[_crate,_lootArray,_lootCounts] call blck_fnc_fillBoxes;
		_crate setVariable["lootLoaded",true];
	}
	else
	{
		//diag_log format["_fnc_spawnMissionCrates::-> not loading crate loot at this time for crate %1",_x];
	};
}forEach _crates;

_objs
