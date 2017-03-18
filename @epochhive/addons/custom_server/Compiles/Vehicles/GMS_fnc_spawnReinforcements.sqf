/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 3-17-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//params["_coords","_aiSkillsLevel","_weapons","_uniforms","_headgear"];
_coords = _this select 0;
_aiSkillsLevel = _this select 1;
_weapons = _this select 2;
_uniforms = _this select 3;
_headgear = _this select 4;

private["_chanceHeliPatrol","_return","_paratroops","_missionHelis"];

if (blck_debugON) then {diag_log format["_fnc_spawnMissionReinforcements (34):  Script Starting with _aiSkillsLevel = %1",_aiSkillsLevel]}
_aiSkillsLevel = toLower _aiSkillsLevel;

if (_aiSkillsLevel isEqualTo "blue") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (38): BLUE difficulty settings applied";};
	_chanceHeliPatrol = blck_chanceHeliPatrolBlue;
	_missionHelis = blck_patrolHelisBlue;
};
if (_aiSkillsLevel isEqualTo "green") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (43): GREEN difficulty settings applied";};
	_chanceHeliPatrol = blck_chanceHeliPatrolGreen;
	_missionHelis = blck_patrolHelisGreen;
};
if (_aiSkillsLevel isEqualTo "orange") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (48): ORANGE difficulty settings applied";};
	_chanceHeliPatrol = blck_chanceHeliPatrolOrange;
	_missionHelis = blck_patrolHelisOrange;
};
if (_aiSkillsLevel isEqualTo "red") then
{
	if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (54): RED difficulty settings applied";};
	_chanceHeliPatrol = blck_chanceHeliPatrolRed;
	_missionHelis = blck_patrolHelisRed;	
};

if (blck_debugON) then {diag_log format["_fnc_spawnMissionReinforcements (59): Variables defined: _chanceHeliPatrol %1 | _missionHelis %2",_chanceHeliPatrol,_missionHelis];};

if (random (1) < _chanceHeliPatrol) then 
{
	//params["_coords","_aiSkillsLevel",,"_weapons","_uniforms","_headgear""_helis"];
	if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (64): calling _fnc_spawnMissionHeli to spawn heli and paratroops";};
	_return = [_coords,_aiSkillsLevel,_weapons,_uniforms,_headgear,_missionHelis] call blck_fnc_spawnMissionHeli; 
	if (blck_debugON) then {diag_log format["_fnc_spawnMissionReinforcements (66): blck_fnc_spawnMissionHeli returned value of %1 for _return",_return];};
} else {
		if (blck_debugON) then {diag_log "_fnc_spawnMissionReinforcements (68): calling _fnc_spawnMissionParatroops to spawn para reinforcements";};
		// params["_coords","_skillAI","_weapons","_uniforms","_headgear"];
		_paratroops = [_coords,_aiSkillsLevel,_weapons,_uniforms,_headgear] call blck_fnc_spawnMissionParatroops;
		if (blck_debugON) then {diag_log format["_fnc_spawnMissionReinforcements (71):: blck_fnc_spawnMissionParatroops returned value for _paratroops of %1",_paratroops];};
		_return = [objNull, _paratroops];
};	
if (blck_debugLevel > 0) then {diag_log format["_fnc_spawnMissionReinforcements (74):: _return = %1",_return];};
_return