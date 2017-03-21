//////////////////////////////////////////////////////
// Test whether one object (e.g., a player) is within a certain range of any of an array of other objects
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 2/24/17
*/
/////////////////////////////////////////////////////

private ["_result"];
params["_locations","_dist",["_onFootOnly",false]];

_result = false;
{
	_result = [_x,_dist,_onFootOnly] call blck_fnc_playerInRange;
	if (_result) exitWith {};
} forEach _locations;
_result
