/*
	By Ghostrider-DbD-
	Last Modified 7-27-17

	Handles the case where a vehicle is hit.

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_veh","_instigator","_group","_wp"];
//diag_log format["_EH_AIVehicle_HandleDamage::-->> _this = %1",_this];
//diag_log format["_EH_AIVehicle_HandleDamage:: _units = %1 and _instigator = %2 units damage is %3",_unit,_instigator, damage _unit];
_veh = _this select 0 select 0;
_instigator = _this select 0 select 3;

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_EH_AIVehicle_HandleDamage:: _units = %1 and _instigator = %2 units damage is %3",_unit,_instigator, damage _unit];
};
#endif

if (!(alive _veh)) exitWith {};
if (!(isPlayer _instigator)) exitWith {};
_crew = crew _veh;
[_crew select 0,_instigator] call blck_fnc_alertGroupUnits;
[_instigator] call blck_fnc_alertNearbyVehicles;
_group = group (_veh select 0);
//_group setBehavior "COMBAT";
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";


