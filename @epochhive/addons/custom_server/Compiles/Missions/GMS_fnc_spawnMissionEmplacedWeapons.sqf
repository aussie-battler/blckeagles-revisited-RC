/*

	[_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;

*/
//  [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;
params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(9):: - > _noEmplacedWeapons = %1",_noEmplacedWeapons];
private ["_emplacedGroup","_emplacedPositions","_missionGroups","_missionAI","_missionStatics","_false","_return","_count"];
_missionGroups = [];
_missionAI = [];
_missionStatics = [];
_return = [];
diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons(15):: - > _noEmplacedWeapons = %1",_noEmplacedWeapons];
if (count _missionEmplacedWeapons > 0) then
{
	{
		diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons (19):: - > _spawning from _missionEmplacedWeapons %1",_missionEmplacedWeapons];
		_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,0,0.1,_uniforms,_headGear] call blck_fnc_spawnGroup;
		diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons (21):: - > _spawned group %1",_emplacedGroup];
		if !(isNull _emplacedGroup) then
		{
			_missionGroups pushback _emplacedGroup;
			{_x allowDamage false;} forEach units _emplacedGroup;
			_emplacedWeapon = [_x,_emplacedGroup,blck_staticWeapons,5,15] call  blck_fnc_spawnEmplacedWeapon;
			_emplacedWeapon setPosATL _x;
			_missionStatics pushback _missionStatics;
			uiSleep _delayTime;
			{_x allowDamage true;} forEach units _emplacedGroup;
		};		
	} forEach _missionEmplacedWeapons;
} else {
	_emplacedPositions = [_coords,_count,35,50] call blck_fnc_findPositionsAlongARadius;
	{
		diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons (36):: - > _noEmplacedWeapons = %1",_noEmplacedWeapons];
		_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
		diag_log format["[blckeagls] _fnc_spawnMissionEmplacedWeapons (38):: - > _spawned group %1",_emplacedGroup];
		if !(isNull _emplacedGroup) then
		{
			_missionGroups pushback _emplacedGroup;
			_emplacedWeapon = [_x,_emplacedGroup,blck_staticWeapons,5,15] call  blck_fnc_spawnEmplacedWeapon;
			_missionStatics pushback _missionStatics;
			uiSleep _delayTime;
		};
	}forEach _emplacedPositions;
};

{
	if !(isNull _x) then {_missionAI pushback (units _x);
}forEach _missionGroups;

if ( (count _missionAI) < 1) then 
{
	{deleteVehicle _x} forEach _missionStatics;
} 
else 
{
	_return = [_missionAI,_missionStatics];
};

_return;