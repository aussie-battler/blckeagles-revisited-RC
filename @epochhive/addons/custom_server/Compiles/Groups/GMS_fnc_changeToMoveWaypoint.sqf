// Changes type of waypont0 for the specified group to "MOVE" and updates  time stamps, WP postion and Timout parameters accordinglyD.
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

private["_group","_wp","_wpPos","_dis","_arc"];

//diag_log format["_fnc_changeToMoveWaypoint:: -- :: _this = %1 with typeName _this = %2",_this, typeName _this];

if !(typeName _this isEqualTo "OBJECT") exitWith {diag_log "_fnc_changeToSADWaypoint aborted for incorrect parameter. You must pass a unit in the group for this to function";};
_group = group _this;
//diag_log format["_fnc_changeToMoveWaypoint:: -- >> group to update is %1 with typeName %2",_group, typeName _group];

_group setVariable["timeStamp",diag_tickTime];
_wp = [_group, 0];
_wpPos = getPos ((units _group) select 0);
_dis = (_group getVariable["minDis"]) + random( (_group getVariable["maxDis"]) - (_group getVariable["minDis"]));
if (_group getVariable["wpMode","random"] isEqualTo "random") then
{
	_arc = random(360);
} else {
	_arc = (_group getVariable["arc",0]) + 70;
	_group setVariable["arc",_arc];
};
_newPos = (_group getVariable ["patrolCenter",_wpPos]) getPos[_dis,_arc];
_group setCurrentWaypoint _wp;
_wp setWaypointType "MOVE";
_wp setWaypointName "move";
_wp setWaypointBehaviour blck_groupBehavior;
_wp setWaypointCombatMode blck_combatMode;
_wp setWaypointTimeout [1,1.1,1.2];
//_wp setWaypointStatements ["true","this call blck_fnc_changeToSADWaypoint; diag_log format['====Updating timestamp for group %1 and changing its WP to a SAD Waypoint',group this];"];	
_wp setWaypointStatements ["true","this call blck_fnc_changeToSentryWaypoint; diag_log format['====Updating timestamp for group %1 and changing its WP to a SAD Waypoint',group this];"];	
_wp setWaypointPosition _newPos;


