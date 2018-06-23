/*
	Author: Ghostrider [GRG]
	Inspiration: blckeagls / A3EAI / VEMF / IgiLoad / SDROP
	License: Attribution-NonCommercial-ShareAlike 4.0 International
	3/17/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_missionPos","_paraGroup","_numAI","_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull]];
private["_arc","_dir","_spawnPos","_chute","_unit","_launcherType","_aborted"];
_aborted = false;

#ifdef blck_debugMode
diag_log format["_fnc_spawnParaUnits (17)::_missionPos %1 | _paraGroup %2 | _numAI %3 | _skillAI %4 | _heli = %5",_missionPos,_paraGroup,_numAI,_skillAI,_heli];
#endif

if (isNull _paraGroup) then
{
	_aborted = true;
} else {
	_paraGroup setVariable["groupVehicle",objNull];
	_launcherType = "none";
	private ["_arc","_spawnPos"];
	_arc = 45;
	_dir = 0;
	_pos = _missionPos;
	for "_i" from 1 to _numAI do
	{
		if (_heli isKindOf "Air") then {_pos = getPos _heli};
		_spawnPos = _pos getPos[1.5,_dir];
		_chute = createVehicle ["Steerable_Parachute_F", [100, 100, 200], [], 0, "FLY"];
		[_chute] call blck_fnc_protectVehicle;
		_unit = [[_spawnPos select 0, _spawnPos select 1, 100],_weapons,_paraGroup,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnAI;
		_chute setPos [_spawnPos select 0, _spawnPos select 1, 125];  //(_offset select 2) - 10];
		_unit assignAsDriver _chute;
		_unit moveInDriver _chute;
		_unit allowDamage true;
		_dir = _dir + _arc;
		
		#ifdef blck_debugMode
		if (blck_debugLevel > 1) then
		{
			diag_log format["_fnc_spawnParaUnits:: spawned unit %1, at location %2 and vehicle _unit %1",_unit,getPos _unit, vehicle _unit];
		};
		#endif
		
		uiSleep 2;
	};
	_paraGroup selectLeader ((units _paraGroup) select 0);
	//params["_pos","_minDis","_maxDis","_group"];
	//  [_pos,_minDist,_maxDist,_groupSpawned,"random","SAD"] spawn blck_fnc_setupWaypoints;
	[_missionPos,20,30,_paraGroup,"random","SAD","paraUnits"] call blck_fnc_setupWaypoints;
	blck_monitoredMissionAIGroups pushback _paraGroup;
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log "_fnc_spawnParaUnits (44):  All Units spawned";
	};
	#endif

};

#ifdef blck_debugMode
diag_log format["_fnc_spawnParaUnits:  _aborted = %1",_aborted];
#endif

_aborted;



