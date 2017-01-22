/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;

*/

params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear",["_missionType","unspecified"]];
private ["_emplacedGroup","_emplacedAI"];
_emplacedAI = [];

if (blck_debugLevel > 0) then {diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(10):: - >_missionEmplacedWeapons = %2 and _noEmplacedWeapons = %1",_noEmplacedWeapons,_missionEmplacedWeapons];};

if ( count (_missionEmplacedWeapons) isEqualTo 0 ) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	diag_log format["_fnc_spawnMissionEmplacedWeapons:: (16) _missionType = %2  _missionEmplacedWeapons updated to %1",_missionEmplacedWeapons,_missionType];
	_precise = false;
};

{
	_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	if !(isNull _emplacedGroup) then
	{
		diag_log format["_fnc_spawnMissionEmplacedWeapons:: (23) -> spawning _blck_fnc_spawnEmplaceWeapon for _missionType %2 with group %1",_emplacedGroup, _missionType];
		// ["_pos","_emplacedGroup","_emplacedTypes",["_minDist",20],["_maxDist",35],["_precise",false] ];
		[_x,_emplacedGroup,blck_staticWeapons,5,15,_precise,_missionType] call  blck_fnc_spawnEmplacedWeapon;
	} else {
		diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(26):: - > Null group spawned"];
	};
	if (typeName (units _emplacedGroup) isEqualTo "ARRAY") then
	{
		_emplacedAI append (units _emplacedGroup);
		diag_log format["_fnc_spawnMissionEmplacedWeapons:: (31)-> _emplacedAI updated to %1",_emplacedAI];
	};
}forEach _missionEmplacedWeapons;

_emplacedAI