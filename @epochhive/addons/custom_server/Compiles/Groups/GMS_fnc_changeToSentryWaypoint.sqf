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

private["_group","_wp"];

//diag_log format["_fnc_changeToSADWaypoint:: -- :: _this = %1 and typName _this %2",_this, typeName _this];
_group = group _this;
//diag_log format["_fnc_changeToSADWaypoint:: -- >> group to update is %1 with typeName %2",_group, typeName _group];

_group setVariable["timeStamp",diag_tickTime];
_wp = [_group, 0];
_group setCurrentWaypoint _wp;
_wp setWaypointType "SENTRY";
_wp setWaypointName "sentry";
_wp setWaypointBehaviour blck_groupBehavior;
_wp setWaypointCombatMode blck_combatMode;
_wp setWaypointTimeout [60,75,90];
_wp setWaypointStatements ["true","this call blck_fnc_changeToMoveWaypoint; diag_log format['====Updating timestamp for group %1 and changing its WP to a Move Waypoint',group this];"];	


