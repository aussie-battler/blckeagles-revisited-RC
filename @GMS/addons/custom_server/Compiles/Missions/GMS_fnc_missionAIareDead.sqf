// removes mines in a region centered around a specific position.
/*
	[_missionAIGroups] call blck_fnc_missionAIareDead;  // _missionAIGroups is an array of groups.
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last Modified 3-13-17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params ["_missionAIGroups"];
private["_allAIDead","_group"];

_allAIDead = true;

{
	_group = _x; // done for coding clarity only - actually less efficient this way
	if ( {alive _x) count (units _group) > 0 ) exitWith {_allAIDead = false};
} forEach _missionAIGroups;

_allAIDead;

