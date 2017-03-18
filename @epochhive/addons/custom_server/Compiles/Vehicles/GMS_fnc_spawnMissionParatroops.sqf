/*
	Author: Ghostrider-DbD-
	Inspiration: blckeagls / A3EAI / VEMF / IgiLoad / SDROP
	License: Attribution-NonCommercial-ShareAlike 4.0 International
	3/17/17
	
	This is basically a container that determines whether a paragroop group should be created and if so creates a group and passes it off to the routine that spawns the paratroops.
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_skillAI","_weapons","_uniforms","_headGear",["_grpParatroops",grpNull],["_heli",objNull]];

private["_grpParatroops","_chanceParatroops"];

_aiSkillsLevel = toLower _aiSkillsLevel;
_chanceParatroops = 0;
_noPara = 0;

if (_aiSkillsLevel isEqualTo "blue") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionParatroops: BLUE difficulty settings applied";};
	_chanceParatroops = blck_chanceParaBlue;
	_noPara = blck_noParaBlue;
};
if (_aiSkillsLevel isEqualTo "green") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionParatroops: GREEN difficulty settings applied";};
	_chanceParatroops = blck_chanceParaGreen;
	_noPara = blck_noParaGreen;
};
if (_aiSkillsLevel isEqualTo "orange") then {
	if (blck_debugON) then {diag_log "_fnc_spawnMissionParatroops: ORANGE difficulty settings applied";};
	_chanceParatroops = blck_chanceParaOrange;
	_noPara = blck_noParaOrange;
};
if (_aiSkillsLevel isEqualTo "red") then
{
	if (blck_debugON) then {diag_log "_fnc_spawnMissionParatroops: RED difficulty settings applied";};
	_chanceParatroops = blck_chanceParaRed;
	_noPara = blck_noParaRed;
};
if (blck_debugON) then {diag_log format["_fnc_spawnMissionParatroops (47): _numAI %1 |_chanceParatroops %2",_noPara,_chanceParatroops];};
if (blck_debugON) then {diag_log format["_fnc_spawnMissionParatroops (48): _coords %1 | _numAI %2 | _skillAI %3 | _grpParatroops %4 | _heli",_coords,_skillAI,_grpParatroops,_heli];};

if (isNull _grpParatroops) then
{
	_grpParatroops = createGroup blck_AI_Side; 
		if (blck_debugON) then {diag_log format["_fnc_spawnMissionParatroops (53):No group passed as a parameter, _grpParatroops %4 created",_grpParatroops];};
};

if (isNull _grpParatroops) exitWith {diag_log "BLCK_ERROR: _fnc_spawnMissionParatroops (56)::_->> NULL GROUP Returned";};
if (random(1) < _chanceParatroops) then
{
	if (blck_debugON) then {diag_log format["_fnc_spawnMissionParatroops (58):  function running and group %1 successfully created; now calling blck_fnc_spawnParaUnits",_grpParatroops];};
	//params["_missionPos","_paraGroup",["_numAI",3],"_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull]];
	[_coords,_grpParatroops,_noPara,_skillAI,_weapons,_uniforms,_headGear,_heli] spawn blck_fnc_spawnParaUnits;
};
_grpParatroops;

