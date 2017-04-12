/*
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 3-17-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//params["_coords","_skillAI","_weapons","_uniforms","_headGear","_helis"];
_coords = _this select 0;
_skillAI = _this select 1;
_weapons = _this select 2;
_uniforms = _this select 3;
_headGear = _this select 4;
_helis = _this select 5;

/*
	Handles upper level functions of reinforcements utilizing helicoptor patrols and/or spawned from a helicopter.
	Calls on functions that spawn paratroops  and/or loot chests at the heli's location.
	
	Tasks are:
	1) spawn a heli over the mission center.
	2) add crew and gunners
	3) spawn paratroops
	4) configure waypointScript
	5) return the _heli that was spawned.
*/
#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnMissionHeli (75):: _helis = %1",_helis];
};
#endif

private["_grpPilot","_chopperType","_patrolHeli","_launcherType","_unitPilot","_unitCrew","_mags","_turret","_return","_abort"];
_abort = false;
_grpPilot  = createGroup blck_AI_Side; 
if (isNull _grpPilot) then 
{
		diag_log "BLCK_ERROR: _fnc_spawnMissionHeli::_->> NULL GROUP Returned for _grpPilot";
		_abort = true;
};

_grpParatroops = createGroup blck_AI_Side; 
if (isNull _grpParatroops) then
{
		diag_log "BLCK_ERROR: _fnc_spawnMissionHeli::_->> NULL GROUP Returned for _grpParatroops";
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
	_chopperType = selectRandom _helis;

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnMissionHeli (66):: _chopperType seleted = %1",_chopperType];
	};
	#endif

	_patrolHeli = createVehicle [_chopperType, _coords, [], 90, "FLY"];
	[_patrolHeli] call blck_fnc_protectVehicle;
	_patrolHeli setFuel 1;
	_patrolHeli engineOn true;
	_patrolHeli flyInHeight 100;
	_patrolHeli setVehicleLock "LOCKED";
	_patrolHeli addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnMissionHeli (76):: heli %1 spawned",_patrolHeli];
	};
	#endif

	clearWeaponCargoGlobal _patrolHeli;
	clearMagazineCargoGlobal _patrolHeli;
	clearItemCargoGlobal _patrolHeli;
	clearBackpackCargoGlobal  _patrolHeli;

	_launcherType = "none";
	_unitPilot = _grpPilot createUnit ["I_helipilot_F", getPos _patrolHeli, [], 0, "FORM"];
	_unitPilot = [[100,100,100],_weapons,_grpPilot,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnAI;
	_unitPilot setSkill 1;
	_unitPilot assignAsDriver _patrolHeli;
	_unitPilot moveInDriver _patrolHeli;
	_grpPilot selectLeader _unitPilot;

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnMissionHeli (90):: pilot %1 spawned",_unitPilot];
	};
	#endif

	_turrets = allTurrets [_patrolHeli,false];

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
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
			if (blck_debugLevel > 2) then
			{
				diag_log format["_fnc_spawnMissionHeli (118)::-->> weapon %1 and its ammo removed from heli %2 for turret %3",_patrolHeli weaponsTurret _x,_patrolHeli, _x];
			};
		}
		else
		{
			//  B_helicrew_F
			_unitCrew = [[100,100,100],_weapons,_grpPilot,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnAI;
			_unitCrew assignAsTurret [_patrolHeli, _x];
			_unitCrew moveInTurret [_patrolHeli, _x];

			#ifdef blck_debugMode
			diag_log format["_fnc_spawnMissionHeli (12798)::-- >> unit %1 moved into turret %2 of vehicle %3",_unitCrew,_x,_patrolHeli];
			#endif
		};
	}forEach _turrets;

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnMissionHeli (133)::-->> Heli %1 outfited with a crew numbering %2",_patrolHeli, crew _patrolHeli];
	};
	#endif

	//  params["_missionPos","_paraGroup",["_numAI",3],"_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull],_grpParatroops];
	//params["_coords","_skillAI","_weapons","_uniforms","_headGear",["_grpParatroops",grpNull],["_heli",objNull]];
	if !(isNull _grpParatroops) then
	{
		[_coords,_skillAI,_weapons,_uniforms,_headGear,_grpParatroops,_patrolHeli] call blck_fnc_spawnMissionParatroops;
	};
	
	//set waypoint for helicopter
	private["_wpDestination"];
	//set waypoint for helicopter
	// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_pattern",["MOVE","SAD"]]];
	[_coords,2,10,_grpPilot,"random",["SENTRY"]] call blck_fnc_setupWaypoints;
	
	/*												
	_grpPilot setVariable["patrolCenter",_coords];
	_grpPilot setVariable["minDis",10];
	_grpPilot setVariable["maxDis",25];
	_grpPilot setVariable["timeStamp",diag_tickTime];
	_grpPilot setVariable["arc",0];
	_grpPilot setVariable["wpRadius",30];
	//_grpPilot setVariable["wpMode",_mode];

	_dir = 0;
	_arc = 30;
	_noWp = 1;
	_wpradius = 30;
	_newPos = _pos getPos [(_minDis+(random (_maxDis - _minDis))), _dir];
	_wp = [_grpPilot, 0];

	#ifdef wpModeMove
	_wp setWaypointType "MOVE";
	_wp setWaypointName "move";
	_wp setWaypointTimeout [1,1.1,1.2];
	_wp setWaypointStatements ["true","this call blck_fnc_changeToSADWaypoint;diag_log format['====Updating waypoint to SAD for group %1',group this];"];
	#else
	_wp setWaypointType "SAD";
	_wp setWaypointName "sad";
	_wp setWaypointTimeout [20,25,30];
	_wp setWaypointStatements ["true","this call blck_fnc_changeToMoveWaypoint;diag_log format['====Updating waypoint to Move for group %1',group this];"];
	#endif

	_wp setWaypointBehaviour blck_groupBehavior;
	_wp setWaypointCombatMode blck_combatMode;
	_grpPilot setCurrentWaypoint _wp;	
	*/															
	/*
	for "_i" from 1 to 5 do
	{
		_pos = _coords getPos [15 + random (15), random(360)];	
		if (_i == 1) then
		{
			_wp = [_grpPilot, 0];
			_wp setWPPos _pos;
		} else {
			_wp = _grpPilot addWaypoint [_pos, 25];	
		};
 
		_wp setWaypointType "SAD";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointBehaviour "AWARE";
		//[_grpPilot, 0] setWaypointStatements ["true","[group this, 0] setCurrentWaypoint [group this,0];"];
		_wp setWaypointTimeout [20,30,40];
		_wp = _grpPilot addWaypoint [_coords,25];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointTimeout [1, 1.1, 1.2];
	};
	_wp = _grpPilot addWaypoint [_coords,25];	
	_wp setWaypointType "CYCLE";
	_grpPilot setCurrentWaypoint [_grpPilot,0];
	*/
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnMissionHeli (153):: initial pilot waypoints set"];
	};
	#endif

};
private["_ai"];
_ai = (units _grpParatroops) + (units _grpPilot);
_return = [_patrolHeli,_ai,_abort];

#ifdef blck_debugMode
if (blck_debugLevel > 1) then
{
	diag_log format["_fnc_spawnMissionHeli:: function returning value for _return of %1",_return];
};
#endif

_return;