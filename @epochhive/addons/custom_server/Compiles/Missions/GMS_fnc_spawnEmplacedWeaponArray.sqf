/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	Last modified 4/27/17
	By Ghostrider-DbD-
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
//diag_log format["_fnc_spawnEmplacedWeaponArray:: _this = %1",_this];

private["_return","_emplacedWeps","_emplacedAI","_wep","_units","_gunner","_abort","_pos","_mode"];
_emplacedWeps = [];
_emplacedAI = [];
_units = [];
_abort = false;
_pos = [];
_mode = "vector";

#ifdef blck_debugMode
//diag_log "_fnc_spawnEmplacedWeaponArray start";
#endif

// Define _missionEmplacedWeapons if not already configured.
if (_missionEmplacedWeapons isEqualTo []) then
{
	_mode = "world";
	_missionEmplacedWeaponPositions = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnEmplacedWeaponArray: creating random spawn locations: _missionEmplacedWeaponsPositions = %1", _missionEmplacedWeaponPositions];
	};
	#endif
	{
		_static = selectRandom blck_staticWeapons;
		//diag_log format["_fnc_spawnEmplacedWeaponArray: creating spawn element [%1,%2]",_static,_x];
		_missionEmplacedWeapons pushback [_static,_x];
		//diag_log format["_fnc_spawnEmplacedWeaponArray: _mi updated to %1",_missionEmplacedWeapons];
	} forEach _missionEmplacedWeaponPositions;
};

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnEmplacedWeaponArray:: starting static weapon spawner with _missionEmplacedWeapons = %1", _missionEmplacedWeapons];
};
#endif

{
	if (_mode isEqualTo "vector") then 
	{
		_pos = _coords vectorAdd (_x select 1);
	} else {
		_pos = (_x select 1);
	};

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnEmplacedWeaponArray:  _coords = %1 | offset = %2 | final _pos = 53",_coords,_x select 1, _pos];
	};
	#endif
	
	//  params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
	_empGroup = [(_x select 1),1,1,_aiDifficultyLevel,(_x select 1),1,2,_uniforms,_headGear,false] call blck_fnc_spawnGroup;
	
	_empGroup setcombatmode "RED";
	_empGroup setBehaviour "COMBAT";
	[(_x select 1),0.01,0.02,_empGroup,"random","SAD","emplaced"] spawn blck_fnc_setupWaypoints;
	if (isNull _empGroup) exitWith {_abort = _true};

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnEmplacedWeaponArray:: typeName _empGroup = %1 and _empGroup = %2 and _x = %3",typeName _empGroup, _empGroup,_x];
	};
	#endif
	
	// params["_vehType","_pos",["_clearInventory",true]];
	_wep = [(_x select 0),[0,0,0],false] call blck_fnc_spawnVehicle;
	_empGroup setVariable["groupVehicle",_wep];
	_wep setVariable["vehicleGroup",_empGroup];
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnEmplacedWeaponArray (23) spawnVehicle returned value of _wep = %1",_wep];
	};
	#endif
	
	_wep setVariable["DBD_vehType","emplaced"];	
	_wep setPosATL _pos;
	[_wep,false] call blck_fnc_configureMissionVehicle;	
	_emplacedWeps pushback _wep;
	_units = units _empGroup;
	_gunner = _units select 0;
	_gunner moveingunner _wep;
	_emplacedAI append _units;

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnEmplacedWeaponArray:: position of emplaced weapon = %1 and targetd position is %2",getPos _wep, _pos];
		diag_log format["_fnc_spawnEmplacedWeaponArray:: _gunner = %1 and crew _wep = %2",_gunner, crew _wep];
	};
	#endif
		
} forEach _missionEmplacedWeapons;
blck_monitoredVehicles append _emplacedWeps;
_return = [_emplacedWeps,_emplacedAI,_abort];

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnEmplacedWeaponArray:: returning with _return = _emplacedWeps = %1",_return];
};
#endif

_return
