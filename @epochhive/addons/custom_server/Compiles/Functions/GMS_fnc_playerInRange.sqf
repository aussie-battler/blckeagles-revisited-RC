//////////////////////////////////////////////////////
// Test whether one object (e.g., a player) is within a certain range of any of an array of other objects
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 1/22/17
*/
/////////////////////////////////////////////////////

private ["_result"];
params["_pos","_dist"];

_result = false;
{
	if ((_x distance2D _pos) < _dist) exitWith {_result = true;};
} forEach allPlayers;
//diag_log format["_fnc_playerInRange:: -> _pos = %1 and _dist = %2 and _result = %3",_pos,_dist,_result];
_result