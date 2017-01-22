// Spawns an emplaced weapons, man's it, and saves it to an array of monitored vehicles.
// by Ghostrider-DBD-
// Last Updated 10-25-16
//  ["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false] ] call blck_fnc_spawnEmplacedWeapon;
private["_emplaced","_safepos","_emp","_gunner"];
params["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false], ["_missionType","undefined" ]];
if (isNull _emplacedGroup) exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnEmplaced"; objNull;};
diag_log format["_fnc_spawnEmplacedGroup::  -- >> _emplacedGroup = %1",_emplacedGroup];	
_safepos = [_pos,_minDist,_maxDist,0,0,20,0] call BIS_fnc_findSafePos;
_emplaced = selectRandom _emplacedTypes; 
_emp = [_emplaced,_safepos] call blck_fnc_spawnVehicle;
_emp setVariable["DBD_vehType","emplaced"];
if (_precise) then {_emp setPosATL _pos];
_gunner = (units _emplacedGroup) select 0;
_gunner moveingunner _emp;
[_emp] call blck_fnc_configureMissionVehicle;
waitUntil { count crew _emp > 0};
blck_missionVehicles pushback _emp;
if (blck_debugLevel > 1) then {diag_log format["spawnEmplaced.sqf: _missionType %3 || Emplaced weapon %1 spawned at position %2",_emp,getPosATL _emp,_missionType];

_emp
