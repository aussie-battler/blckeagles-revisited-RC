/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;

*/

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear",["_missionType","unspecified"]];
private ["_emplacedGroup","_emplacedAI","_precise","_safepos","_wepSelected","_emp","_gunner"];
_emplacedAI = [];

if (blck_debugLevel > 0) then {diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(10):: - >_missionEmplacedWeapons = %2 and _noEmplacedWeapons = %1",_noEmplacedWeapons,_missionEmplacedWeapons];};

if ( count _missionEmplacedWeapons isEqualTo 0 ) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	_precise = false;
};
diag_log format["_fnc_spawnMissionEmplacedWeapons:: (16) _missionType = %2  _missionEmplacedWeapons updated to %1",_missionEmplacedWeapons,_missionType];
{
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (20) spawning group to man emplaced weapon"];
	_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (22) -> spawning _blck_fnc_spawnEmplaceWeapon at position %3 for _missionType %2 with group %1",_emplacedGroup, _missionType, _x];
	_emplacedAI append units _emplacedGroup;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (24) _emplacedAI updated to = %1",_emplacedAI];
	// params["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false], ["_missionType","undefined" ]];
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (26) spawning emplaced weapon"];
	if !(_precise) then
	{
		_safepos = [_coords,5,10,0,0,20,0] call BIS_fnc_findSafePos;
	};	
	_wepSelected = selectRandom blck_staticWeapons;	
	_emp = [_wepSelected,_safepos,false] call blck_fnc_spawnVehicle;
	_emp setVariable["DBD_vehType","emplaced"];	
	if (_precise) then {_emp setPosATL _pos];
	_gunner = (units _emplacedGroup) select 0;
	_gunner moveingunner _emp;
	[_emp,false] call blck_fnc_configureMissionVehicle;
	//waitUntil { count crew _emp > 0};
	blck_missionVehicles pushback _emp;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (28) emplaced weapon _wep = %1",_wep];
}forEach _missionEmplacedWeapons;

_emplacedAI