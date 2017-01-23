/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;

*/

params["_missionEmplacedWeapons","_noEmplacedWeapons"];
private["_return","_emplacedWeps","_wep"];
_emplacedWeps = [];

diag_log "_fnc_spawnEmplacedWeaponArray start";
// Define _missionEmplacedWeapons if not already configured.
if (count _missionEmplacedWeapons < 1) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
};
diag_log format["_fnc_spawnEmplacedWeaponArray:: _missionEmplacedWeapons = %1", _missionEmplacedWeapons];
{
	// params["_vehType","_pos",["_clearInventory",true]];
	_wep = [selectRandom blck_staticWeapons,[0,0,0],false] call blck_fnc_spawnVehicle;
	diag_log format["_fnc_spawnMissionEmplacedWeapons (33) spawnVehicle returned value of _wep = %1",_wep];
	_wep setVariable["DBD_vehType","emplaced"];	
	_wep setPosATL _x;
	[_wep,false] call blck_fnc_configureMissionVehicle;	
	_emplacedWeps pushback _wep;
} forEach _missionEmplacedWeapons;

_return = _emplacedWeps;
diag_log format["_fnc_spawnEmplacedWeaponArray:: returning with _return = _emplacedWeps = %1",_return];
_return