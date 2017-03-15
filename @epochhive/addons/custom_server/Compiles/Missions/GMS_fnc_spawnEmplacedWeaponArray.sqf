/*
	
	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	Last modified 3/13/17
	By Ghostrider-DbD-
*/

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
private["_return","_emplacedWeps","_emplacedAIGroups","_wep","_units","_gunner"];
_emplacedWeps = [];
_emplacedAIGroups = [];
_units = [];
//diag_log "_fnc_spawnEmplacedWeaponArray start";
// Define _missionEmplacedWeapons if not already configured.
if (count _missionEmplacedWeapons < 1) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
};
//diag_log format["_fnc_spawnEmplacedWeaponArray:: (18) _missionEmplacedWeapons = %1", _missionEmplacedWeapons];
{
	_empGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: typeName _empGroup = %1 and _empGroup = %2",typeName _empGroup, _empGroup];
	// params["_vehType","_pos",["_clearInventory",true]];
	_wep = [selectRandom blck_staticWeapons,[0,0,0],false] call blck_fnc_spawnVehicle;
	//diag_log format["_fnc_spawnEmplacedWeaponArray (23) spawnVehicle returned value of _wep = %1",_wep];
	_wep setVariable["DBD_vehType","emplaced"];	
	_wep setPosATL _x;
	[_wep,false] call blck_fnc_configureMissionVehicle;	
	_emplacedWeps pushback _wep;
	_units = units _empGroup;
	_gunner = _units select 0;
	_gunner moveingunner _wep;
	_emplacedAIGroups pushback _empGroup;
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: position of emplaced weapon = %1 and position of _x is %2",getPos _wep, _x];
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: _gunner = %1 and crew _wep = %2",_gunner, crew _wep];
} forEach _missionEmplacedWeapons;
blck_missionVehicles append _emplacedWeps;
_return = [_emplacedWeps,_emplacedAIGroups];
//diag_log format["_fnc_spawnEmplacedWeaponArray:: returning with _return = _emplacedWeps = %1",_return];
_return
