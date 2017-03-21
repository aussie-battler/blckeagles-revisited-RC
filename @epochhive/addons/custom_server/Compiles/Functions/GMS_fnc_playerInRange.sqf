//////////////////////////////////////////////////////
// Test whether one object (e.g., a player) is within a certain range of any of an array of other objects
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 2/24/17
*/
/////////////////////////////////////////////////////

private ["_result","_players"];
params["_pos","_dist",["_onFootOnly",false]];
_players = call blck_fnc_allPlayers;
_result = false;
if !(_onFootOnly) then
{
	{
		if ((_x distance2D _pos) < _dist) exitWith {_result = true;};
	} forEach _players;
};
//diag_log format["_fnc_playerInRange:: -> _pos = %1 and _dist = %2 and _result = %3",_pos,_dist,_result];
if (_onFootOnly) then
{
	{
		if ( ((_x distance2D _pos) < _dist) && (vehicle _x isEqualTo _x)) exitWith {_result = true;};
	} forEach _players;
};
_result
