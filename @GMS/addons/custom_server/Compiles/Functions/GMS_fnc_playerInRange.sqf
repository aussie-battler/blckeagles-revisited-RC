//////////////////////////////////////////////////////
// Test whether one object (e.g., a player) is within a certain range of any of an array of other objects
/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last Modified 2/24/17
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
/////////////////////////////////////////////////////

private ["_result","_players"];
params["_pos","_dist",["_onFootOnly",false]];
_players = call blck_fnc_allPlayers;
_result = false;

//diag_log format["_fnc_playerInRange:: -> _pos = %1 and _dist = %2 and _result = %3",_pos,_dist,_result];
if !(_onFootOnly) then
{
	{
		//diag_log format["_fnc_playerInRange:: !_onFootOnly -> _pos = %1 and _player = %2 and distance = %3",_pos,_x, _pos distance _x];
		if ((_x distance2D _pos) < _dist) exitWith {_result = true;};
	} forEach _players;
};

if (_onFootOnly) then
{
	{
		//diag_log format["_fnc_playerInRange:: onfootOnly -> _pos = %1 and _player = %2 and distance = %3",_pos,_x, _pos distance2d _x];
		if ( ((_x distance2D _pos) < _dist) && (vehicle _x isEqualTo _x)) exitWith {_result = true;};
	} forEach _players;
};
//diag_log format["_fnc_playerInRange:: returning with _result = %1",_result];
_result
