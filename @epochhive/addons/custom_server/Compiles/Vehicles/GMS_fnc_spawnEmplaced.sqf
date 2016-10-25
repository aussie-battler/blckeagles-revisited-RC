// Spawns an emplaced weapons, man's it, and saves it to an array of monitored vehicles.
// by Ghostrider-DBD-
// Last Updated 10-25-16

private["_emplaced","_safepos","_emp","_gunner"];
params["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35] ];

if (isNull _emplacedGroup) exitWith {};
	
_safepos = [_pos,_minDist,_maxDist,0,0,20,0] call BIS_fnc_findSafePos;
_emplaced = selectRandom _emplacedTypes; 
_emp = [_emplaced,_safepos] call blck_fnc_spawnVehicle;
_emp setVariable["DBD_vehType","emplaced"];
_gunner = (units _emplacedGroup) select 0;
_gunner moveingunner _emp;
[_emp] call blck_fnc_configureMissionVehicle;
waitUntil { count crew _emp > 0};
blck_missionVehicles pushback _emp;
diag_log format["spawnEmplaced.sqf: Emplaced weapon %1 spawned"];

_emp
