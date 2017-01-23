/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;

*/

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear",["_missionType","unspecified"]];
private ["_emplacedGroup","_emplacedAI","_precise","_pos","_emplaced","_emp","_gunner","_staticWeap"];
_emplacedAI = [];
_staticWeap = [];
if (blck_debugLevel > 0) then {diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(10):: - >_missionEmplacedWeapons = %2 and _noEmplacedWeapons = %1",_noEmplacedWeapons,_missionEmplacedWeapons];};

if ( count _missionEmplacedWeapons isEqualTo 0 ) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	_precise = false;
	if (blck_debugLevel > 1) then {diag_log "_fnc_spawnMissionEmplacedWeapons:: -->> no spawn points specified, using spawns along a radius";
};
diag_log format["_fnc_spawnMissionEmplacedWeapons:: (19) _missionType = %2  _missionEmplacedWeapons updated to %1",_missionEmplacedWeapons,_missionType];
{
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (21) spawning group to man emplaced weapon"];
	_emplacedGroup = [_x,1,1,_aiDifficultyLevel,[0,0,0],1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (23) group spawned = %1",_emplacedGroup];
	_emplacedAI append (units _emplacedGroup);
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (24) _emplacedAI updated to = %1",_emplacedAI];

	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (26) spawning emplaced weapon"];
	if (_precise) then
	{
		_pos = _x;
	} else {
		_pos = [_x,5,10,0,0,20,0] call BIS_fnc_findSafePos;
	};	
	
	_emp = [selectRandom blck_staticWeapons,_pos,false] call blck_fnc_spawnVehicle;
	diag_log format["_fnc_spawnMissionEmplacedWeapons (33) spawnVehicle returned value of _emp = %1",_emp];
	_emp setVariable["DBD_vehType","emplaced"];	
	_emp setPosATL _pos;
	[_emp,false] call blck_fnc_configureMissionVehicle;	
	_gunner = (units _emplacedGroup) select 0;
	_gunner moveingunner _emp;
	_staticWeap pushback _emp;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (28) emplaced weapon _wep = %1",_wep];
}forEach _missionEmplacedWeapons;

_emplaced = [_staticWeap, _emplacedAI];

_emplaced