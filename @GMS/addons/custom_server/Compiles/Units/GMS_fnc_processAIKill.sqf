/*
	Handle AI Deaths
	Last Modified 7/27/17
	By Ghostrider [GRG]
	Copyright 2016
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_group","_isLegal","_weapon","_lastkill","_kills","_message","_killstreakMsg"];
params["_unit","_killer","_isLegal"];

// if blck_cleanupAt > 0 then the death was already processed.
if (_unit getVariable["blck_cleanupAt",-1] > 0) exitWith {};

//diag_log format["_fnc_processAIKills:: function called with _this = %1",_this];
_unit setVariable ["blck_cleanupAt", (diag_tickTime) + blck_bodyCleanUpTimer, true];
//diag_log format["_fnc_processAIKills: _unit = %1 | vehicle unit = %2",_unit, vehicle _unit];

blck_deadAI pushback _unit;
_group = group _unit;
[_unit] joinSilent grpNull;
if (count(units _group) < 1) then {
	#ifdef useDynamicSimulation
	_group enableDynamicSimulation false;
	#endif
	deleteGroup _group;
};
if (blck_launcherCleanup) then {[_unit] spawn blck_fnc_removeLaunchers;};
if (blck_removeNVG) then {[_unit] spawn blck_fnc_removeNVG;};
if !(isPlayer _killer) exitWith {};
[_unit,_killer] call blck_fnc_alertGroupUnits;
[_killer] call blck_fnc_alertNearbyVehicles;
_group = group _unit;
_wp = [_group, currentWaypoint _group];
_wp setWaypointBehaviour "COMBAT";
_group setCombatMode "RED";
_wp setWaypointCombatMode "RED";
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

//_unit action ["Eject", vehicle _unit];
[_unit, ["Eject", vehicle _unit]] remoteExec ["action",(owner _unit)];
if (blck_useKillMessages) then
{
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
	[["aikilled",_message,"victory"],allPlayers] call blck_fnc_messageplayers;
};

[_unit,_killer] call blck_fnc_rewardKiller;
if (blck_showCountAliveAI) then
{
	//diag_log "_fnc_processAIKills: Updating Map Marker AI Counts - blck_missionMarkers items are";
	{
		//diag_log format["_fnc_processAIKills: blck_missionMarkers itm %1 = %2",_forEachIndex,_x];
		[_x select 0, _x select 1, _x select 2] call blck_fnc_updateMarkerAliveCount;
	} forEach blck_missionMarkers;
	//call blck_fnc_updateAllMarkerAliveCounts;
};

