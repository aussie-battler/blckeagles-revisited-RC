//////////////////////////////////////////////////////
// Returns an array of all players on the server
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 2/24/17
*/
/////////////////////////////////////////////////////

private ["_result"];

_result = [];
{
	if (isPlayer _x) then { _result pushback _x };
} forEach playableUnits;
_result
