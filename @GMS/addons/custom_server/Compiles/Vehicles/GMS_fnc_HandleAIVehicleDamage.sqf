/*
	By Ghostrider [GRG]
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

/*
	_this select 1 contains:
     unit: Object - Object the event handler is assigned to.
     hitSelection: String - Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
     damage: Number - Resulting level of damage for the selection.
     source: Object - The source unit that caused the damage.
     projectile: String - Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.)

(Since Arma 3 v1.49)

    hitPartIndex: Number - Hit part index of the hit point, -1 otherwise.

(Since Arma 3 v1.65)

    instigator: Object - Person who pulled the trigger

(Since Arma 3 v 1.67)

    hitPoint: String - hit point Cfg name 	
*/
_veh = _this select 0 select 0;
_instigator = _this select 0 select 3;

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_HandleAIVehicleDamage:  _this = %1",_this];
	diag_log format["_EH_AIVehicle_HandleDamage:: _units = %1 and _instigator = %2 units damage is %3",_veh,_instigator, damage _veh];
};
#endif

if (!(alive _veh)) exitWith {};
if (!(isPlayer _instigator)) exitWith {};
_crew = crew _veh;
[_crew select 0,_instigator] call blck_fnc_alertGroupUnits;
[_instigator] call blck_fnc_alertNearbyVehicles;
_group = group (_crew select 0);
_group setBehaviour "COMBAT";
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";


