/*
	By Ghostrider-DbD-
	Last Modified 7-27-17

	Handles the case where a unit is hit.

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_unit","_instigator","_group","_wp"];
//diag_log format["_EH_AIHit::-->> _this = %1",_this];
_unit = _this select 0 select 0;
_instigator = _this select 0 select 3;

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["EH_AIHit:: _units = %1 and _instigator = %2 units damage is %3",_unit,_instigator, damage _unit];
};
#endif

if (!(alive _unit)) exitWith {};
if (!(isPlayer _instigator)) exitWith {};
[_unit,_instigator] call blck_fnc_alertGroupUnits;
[_instigator] call blck_fnc_alertNearbyVehicles;
_group = group _unit;
//_group setBehavior "COMBAT";
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";

if (_unit getVariable ["hasHealed",false]) exitWith {};
if ((damage _unit) > 0.1 ) then
{
		//diag_log format["_EH_AIHit::-->> Healing unit %1",_unit];
		_unit setVariable["hasHealed",true,true];
		_unit  addMagazine "SmokeShellOrange";
		_unit fire "SmokeShellMuzzle";
		_unit addItem "FAK";
		_unit action ["HealSoldierSelf",  _unit];
		_unit setDamage 0;
		_unit removeItem "FAK";
};

