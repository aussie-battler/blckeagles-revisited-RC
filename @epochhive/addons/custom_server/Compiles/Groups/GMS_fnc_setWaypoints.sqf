// Sets up waypoints for a specified group.
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/17/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_dist","_dir","_arc","_xpos","_ypos","_newpos","_wpradius","_wpnum","_oldpos"];
params["_pos","_minDis","_maxDis","_group"];

_wpradius = 30;
_wpnum = 6;
_dir = random 360;
_arc = 360/_wpnum;

for  "_i" from 0 to (_wpnum - 1) do 
{
	_dir = _dir + _arc;
	_dist = (_minDis+(random (_maxDis - _minDis)));
	_newpos = _pos getPos [_dist, _arc];

	_wp = _group addWaypoint [_newpos, 0];
	_wp setWaypointTimeout [1, 1.1, 1.2];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointName "move";
	_wp = _group addWaypoint [_newpos, 0];
	_wp setWaypointTimeout [15,20,25];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointCombatMode "RED";
	_wp setWaypointName "sad";	
};
deleteWaypoint [_group, 0];
_group setVariable["wpIndex",0];
_wp = _group addWaypoint [_newpos, _wpradius];
_wp setWaypointType "CYCLE";
