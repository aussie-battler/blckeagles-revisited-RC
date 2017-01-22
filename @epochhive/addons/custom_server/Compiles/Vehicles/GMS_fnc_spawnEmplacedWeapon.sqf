// Spawns an emplaced weapons, man's it, and saves it to an array of monitored vehicles.
// by Ghostrider-DBD-
// Last Updated 1-22-17
//  ["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false] ] call blck_fnc_spawnEmplacedWeapon;
private["_emplaced","_safepos","_emp","_gunner"];
params["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false], ["_missionType","undefined" ]];
if (isNull _emplacedGroup) exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnEmplaced"; objNull;};
diag_log "params[_pos,_emplacedGroup,_emplacedTypes,_minDist,_maxDist,_precise,_missionType]";
diag_log format["_fnc_spawnEmplacedGroup::  -- >> _this = %1",_this];	
if !(_precise) then
{
	_safepos = [_pos,_minDist,_maxDist,0,0,20,0] call BIS_fnc_findSafePos;
};
_emplaced = selectRandom _emplacedTypes; 
diag_log format["_fnc_spawnEmplacedWeapon:: (14) weapon %1 selected from selection of %2",_emplaced,_emplacedTypes];
diag_log format["_fnc_spawnEmplacedWeapon:: (15) weapon magazine cargo is %1", magazinesAmmo _emplaced];
//  params["_vehType","_pos",["_clearInventory",true]];
_emp = [_emplaced,_safepos,false] call blck_fnc_spawnVehicle;
_emp setVariable["DBD_vehType","emplaced"];
diag_log format["_fnc_spawnEmplacedWeapon:: (17) weapon _%1 spawned at %2 using weapon type %3",_emp,_safepos,_emplaced];
if (_precise) then {_emp setPosATL _pos];
_gunner = (units _emplacedGroup) select 0;
_gunner moveingunner _emp;
[_emp,false] call blck_fnc_configureMissionVehicle;
waitUntil { count crew _emp > 0};
blck_missionVehicles pushback _emp;
if (blck_debugLevel > 1) then {diag_log format["spawnEmplaced.sqf: (24) _missionType %3 || Emplaced weapon %1 spawned at position %2",_emp,getPosATL _emp,_missionType];

_emp
