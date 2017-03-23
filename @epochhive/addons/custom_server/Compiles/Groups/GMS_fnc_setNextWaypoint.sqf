// Sets the WP type for WP for the specified group and updates other atributes accordingly.
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/14/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_group","_wp","_index","_pattern","_mode","_arc","_dis","_wpPos"];

_group = group _this;

_group setVariable["timeStamp",diag_tickTime];
_wp = [_group, 0];

_pattern = _group getVariable["wpPattern",[]];
_index = _group getVariable["wpIndex",0];
_index = _index + 1;
_minDis = _group getVariable["minDis",0];
_maxDis = _group getVariable["maxDis",0];
_arc = (_group getVariable["arc",0]) + 70;
//diag_log format["_fnc_setNextWaypoint: ->  _minDis = %1 | _maxDis = %2 | _arc = %3",_minDis,_maxDis,_arc];
if (_index >= (count _pattern)) then
{
	_index = 0;
} else {
	diag_log format["_fnc_setNextWaypoint: -> waypoint index for group %1 is currently %2 with _pattern = %4 and count _pattern = %3",_group,_index, count _pattern,_pattern];	
};

_group setVariable["wpIndex",_index];
_type = _pattern select _index;
diag_log format["_fnc_setNextWaypoint: -> waypoint for group %1 to be updated to mode %2 at position %3 with index %4",_group,_type,waypointPosition  _wp, _index];
// revisit this to account for dead units. use waypointPosition if possible.
_wpPos = waypointPosition  _wp;

_wp setWaypointType _type;
_wp setWaypointName toLower _type;
if (true /*_type isEqualTo toLower "move"*/) then
{ 
	_dis = (_minDis) + random( (_maxDis) - (_minDis) );
	if (toLower (_group getVariable["wpMode","random"]) isEqualTo "random") then
	{
		_arc = random(360);
	} else {
		_group setVariable["arc",_arc];
	};
	_oldPos = waypointPosition _wp;
	_newPos = (_group getVariable ["patrolCenter",_wpPos]) getPos[_dis,_arc];
	_wp setWPPos _newPos;
	diag_log format["_fnc_setNextWaypoint: -- > for group %5 | _dis = %1 | _arc = %2 _oldPos = %3 | _newPos = %4",_dis,_arc,_oldPos,_newPos,_group];
	//_wp setWaypointTimeout [1.0,1.1,1.2];
	_wp setWaypointTimeout [20,25,30];
} else {
	_wp setWaypointTimeout [20,25,30];
	_newPos = _wpPos;
	_wp setWPPos _newPos;
	diag_log format["_fnc_setNextWaypoint: - waypoint position for group %1 not changed",_group];
};
diag_log format["_fnc_setNextWaypoint: -> waypoint for group %1 set to mode %2 at position %3 with index %4",_group,_type,waypointPosition  _wp, _index];
diag_log format["_fnc_setNextWaypoint:-> waypoint statements for group %1 = %2",_group, waypointStatements [_group,_index]];
//_wp setWaypointBehaviour "COMBAT";
//_wp setWaypointCombatMode "RED";
_group setCurrentWaypoint _wp;



