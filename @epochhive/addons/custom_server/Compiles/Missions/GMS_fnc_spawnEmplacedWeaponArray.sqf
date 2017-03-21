/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	Last modified 3/20/17
	By Ghostrider-DbD-
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
private["_return","_emplacedWeps","_emplacedAI","_wep","_units","_gunner","_abort","_pos"];
_emplacedWeps = [];
_emplacedAI = [];
_units = [];
_abort = false;
_pos = [];
//diag_log "_fnc_spawnEmplacedWeaponArray start";
// Define _missionEmplacedWeapons if not already configured.
if (_missionEmplacedWeapons isEqualTo []) then
{
	_missionEmplacedWeaponPositions = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	diag_log format["_fnc_spawnEmplacedWeaponArray: creating spawn locations: _missionEmplacedWeaponsPositions = %1", _missionEmplacedWeaponPositions];
	{
		_static = selectRandom blck_staticWeapons;
		//diag_log format["_fnc_spawnEmplacedWeaponArray: creating spawn element [%1,%2]",_static,_x];
		_missionEmplacedWeapons pushback [_static,_x];
		//diag_log format["_fnc_spawnEmplacedWeaponArray: _mi updated to %1",_missionEmplacedWeapons];
	} forEach _missionEmplacedWeaponPositions;
};
//diag_log format["_fnc_spawnEmplacedWeaponArray:: starting static weapon spawner with _missionEmplacedWeapons = %1", _missionEmplacedWeapons];
{
	_pos = _coords vectorAdd (_x select 1);
	//diag_log format["_fnc_spawnEmplacedWeaponArray:  _coords = %1 | offset = %2 | final _pos = 53",_coords,_x select 1, _pos];
	//  params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
	_empGroup = [(_x select 1),1,1,_aiDifficultyLevel,(_x select 1),1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	while {(count (waypoints _empGroup)) > 1} do
	{
		deleteWaypoint ((waypoints _empGroup) select 0);
	};
	if (isNull _empGroup) exitWith {_abort = _true};
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: typeName _empGroup = %1 and _empGroup = %2 and _x = %3",typeName _empGroup, _empGroup,_x];
	// params["_vehType","_pos",["_clearInventory",true]];
	_wep = [(_x select 0),[0,0,0],false] call blck_fnc_spawnVehicle;
	//diag_log format["_fnc_spawnEmplacedWeaponArray (23) spawnVehicle returned value of _wep = %1",_wep];
	_wep setVariable["DBD_vehType","emplaced"];	
	_wep setPosATL _pos;
	[_wep,false] call blck_fnc_configureMissionVehicle;	
	_emplacedWeps pushback _wep;
	_units = units _empGroup;
	_gunner = _units select 0;
	_gunner moveingunner _wep;
	_emplacedAI append _units;
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: position of emplaced weapon = %1 and targetd position is %2",getPos _wep, _pos];
	//diag_log format["_fnc_spawnEmplacedWeaponArray:: _gunner = %1 and crew _wep = %2",_gunner, crew _wep];
	_wp = [_empGroup, 0];
	_wp setWaypointType "SENTRY";
	_wp setWaypointName "sentry";	
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointCombatMode "RED";	
	_wp setWaypointTimeout [10000,11000,12000];
	_wp = _empGroup addWaypoint [_pos, 25];
	_wp setWaypointType "CYCLE";	
} forEach _missionEmplacedWeapons;
blck_missionVehicles append _emplacedWeps;
_return = [_emplacedWeps,_emplacedAI,_abort];
//diag_log format["_fnc_spawnEmplacedWeaponArray:: returning with _return = _emplacedWeps = %1",_return];
_return
