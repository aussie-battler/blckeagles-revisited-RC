/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;

*/
//  [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;
params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
private ["_emplacedGroup","_emplacedAI"];
_emplacedAI = [];

diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(10):: - > _noEmplacedWeapons = %1",_noEmplacedWeapons];

if ( count (_missionEmplacedWeapons) isEqualTo 0 ) then
{
	_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
	_precise = false;
};

{
	_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
	if !(isNull _emplacedGroup) then
	{
		diag_log format["_fnc_spawnMissionEmplacedWeapons:: (23) -> spawning _blck_fnc_spawnEmplaceWeapon with group %1",_emplacedGroup];
		[_x,_emplacedGroup,blck_staticWeapons,5,15,_precise] call  blck_fnc_spawnEmplacedWeapon;
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