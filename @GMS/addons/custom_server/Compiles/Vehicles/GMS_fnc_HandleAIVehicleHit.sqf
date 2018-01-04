/*
	By Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_veh","_instigator","_group","_wp"];

_veh = _this select 0 select 0;
_instigator = _this select 0 select 3;

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_HandleAIVehicleDamage:  _this = %1",_this];
	diag_log format["_EH_AIVehicle_HandleDamage:: _units = %1 and _instigator = %2 units damage is %3",_veh,_instigator, damage _veh];
};
#endif

//if (!(alive _veh)) exitWith {};
if (!(isPlayer _instigator)) exitWith {};
_crew = crew _veh;
_group = group (_crew select 0);
//  Tell the vehicle crew something about the player who caused the damage
[_crew select 0,_instigator] call blck_fnc_alertGroupUnits;
//  Tell nearby vehicles something about the player who caused the damage
[_instigator] call blck_fnc_alertNearbyVehicles;
//  Ask for help from the nearest group of infantry, especially if they have launchers
_nearestGroup = [getPos _veh] call blck_fnc_findNearestInfantryGroup;
[(units _nearestGroup) select 0,_instigator] call blck_fnc_alertGroupUnits;

_group setBehaviour "COMBAT";
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";


