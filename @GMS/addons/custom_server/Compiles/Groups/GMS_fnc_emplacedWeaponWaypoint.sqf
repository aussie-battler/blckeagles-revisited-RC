// Sets the WP type for WP for the specified group and updates other atributes accordingly.
/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last modified 4/23/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_group","_wp"];

diag_log format["_fnc_changeToSADWaypoint:: -- :: _this = %1 and typName _this %2",_this, typeName _this];
_group = group _this;
 diag_log format["_fnc_emplacedWeaponWaypoint:: -- >> group to update is %1 with typeName %2",_group, typeName _group];
_group setVariable["timeStamp",diag_tickTime];
_wp = [_group, 0];
_group setCurrentWaypoint _wp;
 diag_log format["_fnc_emplacedWeaponWaypoint:: -- >> group to update is %1 waypoints updated at %2",_group, (_group getVariable["timeStamp",diag_tickTime])];

