// removes mines in a region centered around a specific position.
/*
	[_missionAIGroups] call blck_fnc_missionAIareDead;  // _missionAIGroups is an array of groups.
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 3-13-17
*/ 
params ["_missionAIGroups"];
private["_allAIDead","_group"];

_allAIDead = true;

{
	_group = _x; // done for coding clarity only - actually less efficient this way
	if ( {alive _x) count (units _group) > 0 ) exitWith {_allAIDead = false};
} forEach _missionAIGroups;

_allAIDead;

