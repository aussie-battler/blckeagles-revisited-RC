/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last Modified 8-15-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_skillAI","_weapons","_uniforms","_headGear","_helis",["_chanceParas",0]];
/*
_coords = _this select 0;
_skillAI = _this select 1;
_weapons = _this select 2;
_uniforms = _this select 3;
_headGear = _this select 4;
_helis = _this select 5;
*/
//diag_log format["_fnc_spawnMissionHeli:: _this = %1",_this];
//diag_log format["_fnc_spawnMissionHeli:: _helis = %1 && _chanceParas = %2",_helis,_chanceParas];
/*
	Handles upper level functions of reinforcements utilizing helicoptor patrols and/or spawned from a helicopter.
	Calls on functions that spawn paratroops  and/or loot chests at the heli's location.
	
	Tasks are:
	1) spawn a heli over the mission center.
	2) add crew and gunners
	3) spawn paratroops if needed
	4) configure waypointScript
	5) return the _heli that was spawned.
*/
#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["_fnc_spawnMissionHeli (38):: _helis = %1",_helis];
};
#endif

private["_grpPilot","_chopperType","_patrolHeli","_launcherType","_unitPilot","_unitCrew","_mags","_turret","_return","_abort"];
_abort = false;
_grpParatroops = grpNull;
_grpPilot  = createGroup blck_AI_Side; 
if (isNull _grpPilot) then 
{
		diag_log "BLCK_ERROR: _fnc_spawnMissionHeli::_->> NULL GROUP Returned for _grpPilot";
		_abort = true;
};

if !(isNull _grpPilot)  then
{
	_grpPilot setBehaviour "COMBAT";
	_grpPilot setCombatMode "RED";
	_grpPilot setSpeedMode "NORMAL";
	_grpPilot allowFleeing 0;
	_grpPilot setVariable["patrolCenter",_coords];
	_grpPilot setVariable["minDis",15];
	_grpPilot setVariable["maxDis",30];
	_grpPilot setVariable["timeStamp",diag_tickTime];
	_grpPilot setVariable["arc",0];
	_grpPilot setVariable["wpRadius",30];
	_grpPilot setVariable["wpMode","SAD"];

	private["_supplyHeli"];
	//create helicopter and spawn it
	if (( typeName _helis) isEqualTo "ARRAY") then {_chopperType = selectRandom _helis}
	else 
	{_chopperType = _helis};
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (78):: _chopperType seleted = %1",_chopperType];
	};
	#endif

	_patrolHeli = createVehicle [_chopperType, _coords, [], 90, "FLY"];
	_grpPilot setVariable["groupVehicle",_patrolHeli];
	[_patrolHeli] call blck_fnc_protectVehicle;
	_patrolHeli setFuel 1;
	_patrolHeli engineOn true;
	_patrolHeli flyInHeight 100;
	_patrolHeli setVehicleLock "LOCKED";
	_patrolHeli addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (93):: heli %1 spawned",_patrolHeli];
	};
	#endif

	[_patrolHeli] call blck_fnc_emptyObject;

	_launcherType = "none";
	_unitPilot = _grpPilot createUnit ["I_helipilot_F", getPos _patrolHeli, [], 0, "FORM"];
	_unitPilot = [[100,100,100],_weapons,_grpPilot,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnUnit;
	_unitPilot setSkill 1;
	_unitPilot assignAsDriver _patrolHeli;
	_unitPilot moveInDriver _patrolHeli;
	_grpPilot selectLeader _unitPilot;

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (113):: pilot %1 spawned",_unitPilot];
	};
	#endif

	_turrets = allTurrets [_patrolHeli,false];

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log "_fnc_spawnMissionHeli (103): preparing to clear out blacklisted turrets";
	};
	#endif

	{
		if ( (_patrolHeli weaponsTurret _x) in blck_blacklisted_heli_weapons) then 
		{
			private["_mags","_turret"];
			_mags = _patrolHeli magazinesTurret _x;
			_turret = _x;
			{
				_patrolHeli removeMagazines [_x,_turret];
			} forEach _mags;
			_patrolHeli removeWeaponTurret _turret;
			if (blck_debugLevel > 1) then
			{
				diag_log format["_fnc_spawnMissionHeli (118)::-->> weapon %1 and its ammo removed from heli %2 for turret %3",_patrolHeli weaponsTurret _x,_patrolHeli, _x];
			};
		}
		else
		{
			//  B_helicrew_F
			_unitCrew = [(getPosATL _patrolHeli),_weapons,_grpPilot,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnUnit;
			_unitCrew assignAsTurret [_patrolHeli, _x];
			_unitCrew moveInTurret [_patrolHeli, _x];

			#ifdef blck_debugMode
			diag_log format["_fnc_spawnMissionHeli (12798)::-- >> unit %1 moved into turret %2 of vehicle %3",_unitCrew,_x,_patrolHeli];
			#endif
		};
	}forEach _turrets;

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (133)::-->> Heli %1 outfited with a crew numbering %2",_patrolHeli, crew _patrolHeli];
	};
	#endif

	if (random(1) < _chanceParas) then
	{
		_grpParatroops = createGroup blck_AI_Side; 
		if (isNull _grpParatroops) then
		{
				diag_log "BLCK_ERROR: _fnc_spawnMissionHeli::_->> NULL GROUP Returned for _grpParatroops";
				_abort = true;
		};
		//  params["_missionPos","_paraGroup",["_numAI",3],"_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull],_grpParatroops];
		//params["_coords","_skillAI","_weapons","_uniforms","_headGear",["_grpParatroops",grpNull],["_heli",objNull]];
		if !(isNull _grpParatroops) then
		{
			[_coords,_skillAI,_weapons,_uniforms,_headGear,_grpParatroops,_patrolHeli] call blck_fnc_spawnMissionParatroops;
		};
	};
	//set waypoint for helicopter
	[_coords,30,35,_grpPilot,"random","SAD"] spawn blck_fnc_setupWaypoints;
	
	blck_monitoredMissionAIGroups pushBack _grpPilot;
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (153):: initial pilot waypoints set"];
		[_patrolHeli] spawn {
			params["_patrolHeli"];
			diag_log "_fnc_spawnMissionHeli:-> spawning crew monitoring loop";
			while {!isNull _patrolHeli} do
			{
				uiSleep 120;
				diag_log format["_fnc_spawnMissionHeli:-> heli %1 has %2 crew alive",_patrolHeli, {alive _x} count crew _patrolHeli];
				diag_log format["_fnc_spawnMissionHeli:-> heli %1 fullCrew = %2",_patrolHeli, fullCrew _patrolHeli];
			};
		};
	};
	#endif

};
private["_ai"];
_ai = (units _grpPilot);
if !(isNull _grpParatroops) then {_ai = _ai + (units _grpParatroops);};

_return = [_patrolHeli,_ai,_abort];

#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["_fnc_spawnMissionHeli:: function returning value for _return of %1",_return];
};
#endif

_return;
