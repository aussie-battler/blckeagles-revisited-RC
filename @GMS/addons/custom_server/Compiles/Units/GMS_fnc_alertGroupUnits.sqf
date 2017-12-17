/*
	by Ghostrider
	7-27-17
	Alerts the leader of a group of the location of an enemy.
	 
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_knowsAbout","_intelligence","_group"];
params["_unit","_target"];
//diag_log format["_fnc_alertGroupUnits called _unit = %1 and _targert = %2",_unit,_target];
_intelligence = _unit getVariable ["intelligence",1];
_group = group _unit;
{
	_knowsAbout = _x knowsAbout _target;
	_x reveal [_target,_knowsAbout + _intelligence];
}forEach units _group;


