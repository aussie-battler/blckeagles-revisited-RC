/*

	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private["_grpPilot","_chopperType","_patrolHeli","_launcherType","_unitPilot","_unitCrew","_mags","_turret","_return","_abort","_supplyHeli"];
params["_coords","_skillAI","_helis",["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_Launcher","none"],["_weaponList",[]], ["_sideArms",[]] ];

#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["_fnc_spawnMissionHeli (38):: _helis = %1",_helis];
};
#endif

_abort = false;
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

	//create helicopter and spawn it
	if (( typeName _helis) isEqualTo "ARRAY") then 
	{
		_chopperType = selectRandom _helis
	} else {
		_chopperType = _helis
	};
	
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (78):: _chopperType selected = %1",_chopperType];
	};
	#endif

	_patrolHeli = createVehicle [_chopperType, _coords, [], 90, "FLY"];
	_grpPilot setVariable["groupVehicle",_patrolHeli];
	[_patrolHeli] call blck_fnc_protectVehicle;
	_patrolHeli setFuel 1;
	_patrolHeli engineOn true;
	_patrolHeli flyInHeight 100;
	_patrolHeli setVehicleLock "LOCKED";
	//_patrolHeli addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then
	{
		diag_log format["_fnc_spawnMissionHeli (93):: heli %1 spawned",_patrolHeli];
	};
	#endif

	[_patrolHeli] call blck_fnc_emptyObject;

	_launcherType = "none";
	//params["_pos","_aiGroup",["_skillLevel","red"],["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_Launcher","none"],["_weaponList",[]],["_sideArms",[]],["_scuba",false]];
	_unitPilot = [[100,100,100],_grpPilot,_skillAI,_uniforms,_headGear,_vests,_backpacks,_Launcher,_weaponList,_sideArms] call blck_fnc_spawnUnit;
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
			//params["_pos","_aiGroup",["_skillLevel","red"],["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_Launcher","none"],["_weaponList",[]],["_sideArms",[]],["_scuba",false]];
			//_unitCrew = [(getPosATL _patrolHeli),_grpPilot,_skillAI,_uniforms,_headGear] call blck_fnc_spawnUnit;
			_unitCrew = [(getPosATL _patrolHeli),_grpPilot,_skillAI,_uniforms,_headGear,_vests,_backpacks,_Launcher,_weaponList,_sideArms] call blck_fnc_spawnUnit;
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

	blck_monitoredMissionAIGroups pushBack _grpPilot;
};
//diag_log format["[blckeagls] _fnc_spawnMissionHeli:: _patrolHeli %1 | _grpPilot %2 | _abort %3",_patrolHeli,_grpPilot,_abort];
_return = [_patrolHeli,units _grpPilot,_abort];

#ifdef blck_debugMode
if (blck_debugLevel > 0) then
{
	diag_log format["_fnc_spawnMissionHeli:: function returning value for _return of %1",_return];
};
#endif
//diag_log format["_fnc_spawnMissionHeli:: function returning value for _return of %1",_return];
_return;
