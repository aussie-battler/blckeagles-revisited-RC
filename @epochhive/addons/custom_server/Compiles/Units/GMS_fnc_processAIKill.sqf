/*
	Handle AI Deaths
	Last Modified 11/20/16
	By Ghostrider-DBD-
	Copyright 2016
*/

private["_group","_isLegal","_weapon","_lastkill","_kills","_message","_killstreakMsg"];
params["_unit","_killer","_isLegal"];

//diag_log format["#-  processAIKill.sqf  -# called for unit %1",_unit];
_unit setVariable ["GMS_DiedAt", (diag_tickTime),true];

blck_deadAI pushback _unit;
_group = group _unit;
[_unit] joinSilent grpNull;
if (count(units _group) < 1) then {deleteGroup _group;};
if (blck_launcherCleanup) then {[_unit] spawn blck_fnc_removeLaunchers;};
if (blck_removeNVG) then {[_unit] spawn blck_fnc_removeNVG;};
if !(isPlayer _killer) exitWith {};
[_unit,_killer] call blck_fnc_alertNearbyUnits;
_isLegal = [_unit,_killer] call blck_fnc_processIlleagalAIKills;

if !(_isLegal) exitWith {};

_lastkill = _killer getVariable["blck_lastkill",diag_tickTime];
_killer setVariable["blck_lastkill",diag_tickTime];
_kills = (_killer getVariable["blck_kills",0]) + 1;
if ((diag_tickTime - _lastkill) < 240) then
{
	_killer setVariable["blck_kills",_kills];
} else {
	_killer setVariable["blck_kills",0];
};

_weapon = currentWeapon _killer;
_killstreakMsg = format[" %1X KILLSTREAK",_kills];

if (blck_useKilledAIName) then
{
	_message = format["[blck] %2: killed by %1 from %3m",name _killer,name _unit,round(_unit distance _killer)];
}else{
	_message = format["[blck] %1 killed with %2 from %3 meters",name _killer,getText(configFile >> "CfgWeapons" >> _weapon >> "DisplayName"), round(_unit distance _killer)];
};
_message =_message + _killstreakMsg;
//diag_log format["[blck] unit killed message is %1",_message,""];
[["aikilled",_message,"victory"]] call blck_fnc_messageplayers;
[_unit,_killer,_kills] call blck_fnc_rewardKiller;
{
	_unit removeAllEventHandlers  _x;
}forEach ["Killed","Fired","HandleDamage","HandleHeal","FiredNear"]

