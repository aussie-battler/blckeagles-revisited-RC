/*
	blck_fnc_spawnGroup
	By Ghostrider [GRG]
	Copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_numbertospawn","_groupSpawned","_safepos","_useLauncher","_launcherType"];	
// _newGroup = [_groupSpawnPos,_minAI,_maxAI,_skillLevel,_coords,_minPatrolRadius,_maxPatrolRadius,_uniforms,_headGear,_vests,_backpacks,_weapons,_sideArms,true,_isScubaGroup]
params["_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",20], ["_maxDist",35],["_configureWaypoints",true], ["_uniforms",[]], ["_headGear",[]],["_vests",[]],["_backpacks",[]],["_weaponList",[]],["_sideArms",[]], ["_scuba",false]];
if (_weaponList isEqualTo []) then {_weaponList = [_skillLevel] call blck_fnc_selectAILoadout};
if (_sideArms isEqualTo [])  then {_sideArms = [_skillLevel] call blck_fnc_selectAISidearms};
if (_uniforms isEqualTo [])  then {_uniforms = [_skillLevel] call blck_fnc_selectAIUniforms};
if (_headGear isEqualTo [])  then {_headGear = [_skillLevel] call blck_fnc_selectAIHeadgear};
if (_vests isEqualTo [])     then {_vests = [_skillLevel] call blck_fnc_selectAIVests};
if (_backpacks isEqualTo []) then {_backpacks = [_skillLevel] call blck_fnc_selectAIBackpacks};

#ifdef blck_debugMode
if (blck_debugLevel >= 2) then
{
	private _params = ["_pos","_center","_numai1","_numai2","_skillLevel","_minDis","_maxDist","_configureWaypoints","_uniforms","_headGear","_vests","_backpacks","_weaponList","_sideArms","_scuba"];
	{
		diag_log format["_fnc_spawnGroup: param %1 | value %2 | _forEachIndex %3",_params select _forEachIndex,_this select _forEachIndex,_forEachIndex];
	}forEach _this;
};
#endif
//Spawns correct number of AI
if (_numai2 > _numai1) then 
{
	_numbertospawn = floor( (random (_numai2 - _numai1) + _numai1 ) );
} else {
	_numbertospawn = _numai2;
};

#ifdef blck_debugMode
if (blck_debugLevel  >= 1) then
{
	diag_log format["spawnGroup.sqf:  _numbertospawn = %1",_numbertospawn];
};
#endif

//_groupSpawned = createGroup [blck_AI_Side, true];  // true here causes any empty group to be automatically deleted within 1 sec or so.  https://community.bistudio.com/wiki/createGroup
_groupSpawned = call blck_fnc_create_AI_Group;
	
#ifdef blck_debugMode
if (blck_debugLevel  >= 1) then
{
	diag_log format["spawnGroup.sqf:  _groupSpawned = %1",_groupSpawned];
};
#endif
if !(isNull _groupSpawned) then
{

	//diag_log format["spawnGroup:: group is %1",_groupSpawned];
	_useLauncher = blck_useLaunchers;
	if (_weaponList isEqualTo []) then
	{
		_weaponList = [_skillLevel] call blck_fnc_selectAILoadout;
	};

	//Spawns the correct number of AI Groups, each with the correct number of units
	//Counter variable
	_i = 0;
	while {_i < _numbertospawn} do 
	{
		_i = _i + 1;
		if (blck_useLaunchers && _i <= blck_launchersPerGroup) then
		{
			_launcherType = selectRandom blck_launcherTypes;
		} else {
			_launcherType = "none";
		};
		
		//Finds a safe positon to spawn the AI in the area given
		//_safepos = [_pos,0,30,2,0,20,0] call BIS_fnc_findSafePos;

		//Spawns the AI unit
		#ifdef blck_debugMode
		if (blck_debugLevel > 2) then
		{
			diag_log format["spawnGroup:: spawning unit #%1",_i];
		};
		#endif
		 //params["_pos","_aiGroup",_skillLevel,_uniforms, _headGear,_vests,_backpacks,_Launcher,_weaponList,_sideArms,_scuba];
		[_pos,_groupSpawned,_skillLevel,_uniforms,_headGear,_vests,_backpacks,_launcherType, _weaponList, _sideArms, _scuba] call blck_fnc_spawnUnit;
	};
	_groupSpawned selectLeader (units _groupSpawned select 0);
	// params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_pattern",["MOVE","SAD"]]];
	if (_configureWaypoints) then
	{
		if (_scuba) then {_infantryType = "scuba"} else {_infantryType = "infantry"};
		[_pos,_minDist,_maxDist,_groupSpawned,"random","SAD","infantry"] spawn blck_fnc_setupWaypoints;
	};
	//[_pos,_minDist,_maxDist,_groupSpawned,"random","SENTRY"] spawn blck_fnc_setupWaypoints;
	//diag_log format["_fnc_spawnGroup: blck_fnc_setupWaypoints called for group %1",_groupSpawned];
	#ifdef blck_debugMode
	if (blck_debugLevel >= 1) then
	{
		diag_log format["fnc_spawnGroup:: Group spawned was %1 with units of %2",_groupSpawned, units _groupSpawned];
	};
	#endif

} else 
{
	diag_log "_fnc_spawnGroup:: ERROR CONDITION : NULL GROUP CREATED";
};
_groupSpawned
