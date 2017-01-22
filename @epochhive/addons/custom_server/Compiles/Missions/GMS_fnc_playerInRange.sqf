//////////////////////////////////////////////////////
// Test whether one object (e.g., a player) is within a certain range of any of an array of other objects
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 1/12/17
*/
/////////////////////////////////////////////////////

private ["_result"];
params["_pos","_dist"];
diag_log format["_fnc_playerInRange:: -> _pos = %1 and _dist = %2",_pos,_dist];
_result = false;
{
	if ((_x distance2D _pos) < _dist) exitWith {_result = true;};
} forEach allPlayers;

_result