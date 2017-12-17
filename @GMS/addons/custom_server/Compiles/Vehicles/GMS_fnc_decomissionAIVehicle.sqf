/*
	By Ghostrider [GRG]
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

diag_log "Vehicle Decommisioning handler activated";
params["_veh"];

if (_veh getVariable["DBD_vehType","none"] isEqualTo "emplaced") then  // Deal with a static weapon
{
	if (blck_killEmptyStaticWeapons) then
	{
		if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
		_veh setDamage 1;
		_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
	} else {
		[_veh] call blck_fnc_releaseVehicleToPlayers;
	};
}else {  // Deal with vehicles
	if (blck_killEmptyAIVehicles) then
	{
		if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle destroyed where vehicle = %1",_veh];};			
		{
			_veh setHitPointDamage [_x, 1];
			
		} forEach ["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitEngine","HitLBWheel","HitLMWheel","HitRBWheel","HitRMWheel","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun"];
		_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
	} else {
		if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: case of release vehicle = %1 to player with blck_monitoredVehicles = %2",_veh, blck_monitoredVehicles];};	
		blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
		if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: blck_monitoredVehicles updated to %1", blck_monitoredVehicles];};	
		[_veh] call blck_fnc_releaseVehicleToPlayers;
	};
};

/*

_ai_veh = _this select 0;

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
