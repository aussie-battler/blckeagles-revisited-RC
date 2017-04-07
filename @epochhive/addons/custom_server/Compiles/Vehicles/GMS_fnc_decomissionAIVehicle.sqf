/*
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 3-14-17
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
// Unused at present, reserved for the future

private ["_ai_veh","_ai_veh_type","_ai_veh_name"];

//diag_log "Vehicle Decommisioning handler activated";
params["_ai_veh"];

/*
_ai_veh = _this select 0;
*/
_if (_ai_veh getVariable["disabled",false]) exitWith {};

_ai_veh setVariable["disabled",true];
//_ai_veh_type = typeof _ai_veh;
//_ai_veh_name = name _ai_veh;

_ai_veh setFuel 0;
_ai_veh setVehicleAmmo 0;
_ai_veh setAmmoCargo 0;

_s = ["MOTOR",
	"wheel_1_1_steering","wheel_2_1_steering","wheel_1_2_steering","wheel_2_2_steering",
	"wheel_1_3_steering","wheel_2_3_steering","wheel_1_4_steering","wheel_2_4_steering"];
{_ai_veh setHit [_x,1]} forEach _s;
