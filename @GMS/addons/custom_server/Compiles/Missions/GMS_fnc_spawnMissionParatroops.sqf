/*
	Author: Ghostrider [GRG]
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

params["_coords",["_grpParatroops",grpNull],"_skillAI","_noPara",["_uniforms",blck_SkinList],["_headGear",blck_headgearList],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weapons",[]],["_sideArms",blck_Pistols],["_isScuba",false]];
#ifdef blck_debugMode
if (blck_debugLevel >=2) then
{
	private _params = ["_coords","_skillAI","_chancePara","_uniforms","_headGear","_vests","_backpacks","_weapons","_sideArms","_grpParatroops","_heli"];
	{
		diag_log format["_fnc_spawnMissionParatroops:: param %1 | isEqualTo %2 | _forEachIndex %3",_params select _forEachIndex,_this select _forEachIndex, _forEachIndex];
	}forEach _this;	
};

private["_grpParatroops","_chanceParatroops","_aborted","_return"];

_skillAI = toLower _skillAI;
_aborted = false;

_grpParatroops = createGroup blck_AI_Side; 
	//params["_missionPos","_paraGroup",["_numAI",3],"_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull]];
	_aborted = [_coords,_grpParatroops,_noPara,_skillAI,_weapons,_uniforms,_headGear,_heli] call blck_fnc_spawnParaUnits;
	diag_log format["_fnc_spawnMissionParatroops:  blck_fnc_spawnParaUnits returned a value of %1",_aborted];
};
#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionParatroops:  _aborted = %1",_aborted];
#endif
if (_aborted) then
{
	_return = [[],true];
} else {
	_return = [(units _grpParatroops),false];
};

#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionParatroops:->  _return = %1 | _abort = %2",_return,_aborted];
#endif

_return

