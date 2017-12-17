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

params["_objects","_coords"];
private["_object"];

if !(_objects isEqualTo []) exitWith
{  //  Spawn loot crates where specified in _objects using the information for loot parameters provided for each location.
	{
		#ifdef blck_debugMode
		if (blck_debugLevel > 2) then
		{
			diag_log format["_fnc_sm_spawnLootContainers (21):->  _x = %1",_x];
		};
		_crate = [_x select 1, _x select 0] call blck_fnc_spawnCrate;
		[_crate, _x select 4, _x select 5] call blck_fnc_fillBoxes;
	} forEach _objects;
};

// In the case where no loot crate parameters are defined in _objects just spawn 1 at the center of the mission.
if (_objects isEqualTo []) then
{
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_sm_spawnLootContainers: _this = %1",_this];
		diag_log format["_fnc_sm_spawnLootContainers: _coords = %1",_coords];
	};
	_crateType = selectRandom blck_crateTypes;
	_crate = [_coords,_crateType] call blck_fnc_spawnCrate;
	[_crate,blck_BoxLoot_Red,blck_lootCountsGreen] call blck_fnc_fillBoxes;
};

