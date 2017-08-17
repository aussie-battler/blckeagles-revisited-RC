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

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_objects","_coords","_loot","_lootCounts"];
private["_object"];
//diag_log format["_sm_spawnLootContainers:: _this = %1",_this];
//diag_log format["_sm_spawnLootContainers:: _objects = %1",_objects];

if !(_objects isEqualTo []) exitWith
{  //  Spawn loot crates where specified in _objects using the information for loot parameters provided for each location.
	{
		private _object = (_x select 0) createVehicle [0,0,0];
		_object setPosASL (_x select 1);
		_object setVectorDirAndUp (_x select 2);
		_object enableSimulationGlobal ((_x select 3) select 0);
		_object allowDamage ((_x select 3) select 1);
		_loot = _x select 4;  //  A bit slower this way because you have to allocate memory and transfer the information but more clear for coding.
		_lootCounts = _x select 5;
		[_object, _loot, _lootCounts] call blck_fnc_fillBoxes;
	} forEach _objects;
};

// In the case where no loot crate parameters are defined in _objects just spawn 1 at the center of the mission.
if (_objects isEqualTo []) then
{

	_crateType = selectRandom blck_crateTypes;
	_crate = [_coords,_crateType] call blck_fnc_spawnCrate;
	[_crate,_loot,_lootCounts] call blck_fnc_fillBoxes;
};

