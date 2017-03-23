// Sets up waypoints for a specified group.
/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/22/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";


private["_dir","_arc","_noWp","_newpos","_wpradius","_wp"];
params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_pattern",["MOVE","SAD"]]];

/*
_pos = _this select 0; // center of the patrol area
_minDis = _this select 1; // minimum distance from the center of a patrol area for waypoints
_maxDis = _this select 2; // maximum distance from the center of a patrol area for waypoints
_group = _this select 3;
*/


_group setVariable["patrolCenter",_pos];
_group setVariable["minDis",_minDis];
_group setVariable["maxDis",_maxDis];
_group setVariable["timeStamp",diag_tickTime];
_group setVariable["arc",0];
_group setVariable["wpRadius",30];
_group setVariable["wpMode",_mode];
_group setVariable["wpPattern",_pattern];
_group setVariable["wpIndex",0];

_dir = 0;
_arc = 30;
_noWp = 1;
_wpradius = 30;
_newPos = _pos getPos [(_minDis+(random (_maxDis - _minDis))), _dir];
_wp = [_group, 0];

#ifdef wpModeMove
_wp setWaypointType "MOVE";
_wp setWaypointName "move";
_wp setWaypointTimeout [1,1.1,1.2];
_wp setWaypointStatements ["true","this call blck_fnc_setNextWaypoint;diag_log format['====Updating waypoint to for group %1',group this];"];
#else
_wp setWaypointType "SAD";
_wp setWaypointName "sad";
_wp setWaypointTimeout [20,25,30];
_wp setWaypointStatements ["true","this call blck_fnc_setNextWaypoint;diag_log format['====Updating waypointfor group %1',group this];"];
#endif

_wp setWaypointBehaviour "COMBAT";
_wp setWaypointCombatMode "RED";
//_wp setWaypointTimeout [1,1.1,1.2];
_group setCurrentWaypoint _wp;

/*
Code for Build 44 as a referemce/
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
