#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private["_group","_groupParameters","_numAI","_return"];
private _triggerRange = 2000;
_sm_groups = +blck_sm_Groups;
{
	// [ [px, py, pz] /* position*/, "difficulty", 4 /*Number to Spawn*/, 150 /*radius of patrol*/, _respawnTime, _group, _spawnAt]
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnTime"];
	diag_log format["<_sm_monitorStaticUnits:: _group = %1 | _x = %2",_group,_x];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{
		if ((isNull _group) && (diag_tickTime > _spawnAt) && (_spawnAt != -1)) then  // no group has been spawned, spawn one.
		{
			diag_log format["[blckeagls static group spawner] evaluating _x = %1 ",_x];
			_numAI = [_units] call blck_fnc_getNumberFromRange;
			diag_log format["[blckeagls static group spawner] _units = %1 and _numAI = %2",_units,_numAI];		
			// params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_configureWaypoints",true] ];
			_group = [_pos,_numAI,_numAI,_difficulty,_pos,_patrolRadius-2,_patrolRadius,blck_SkinList,blck_headgear,true] call blck_fnc_spawnGroup;
			diag_log format["[blckeagls static group spawner] _group - 1",_group];
			_x set[1,_group];
			_x set[2,-1];
		};
	};
	if ( (isNull _group) && (_spawnAt == -1) && (_respawnTime > 0)) then // a group was spawned and all units are dead
	{
		_x set [2, (diag_tickTime + _respawnTime)];
	};
	if ( (isNull _group) && (_spawnAt == -1) && (_respawnTime == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_Groups = blck_sm_Groups - _x;
	};	
}forEach _sm_groups;

_sm_Emplaced = +blck_sm_Emplaced;
{
	// 	["B_G_Mortar_01_F",[22944.3,16820.5,3.14243],"green",0,0,_group,_spawnAt]
	_x params["_groupParameters","_group","_spawnAt"];	
	_groupParameters params["_weapType","_pos","_difficulty","_patrolRadius","_respawnTime"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear"];
			diag_log format["[blckeagls static Emplaced spawner] _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			_group = [[_groupParameters],1,_difficulty,_pos,blck_SkinList,blck_headgear,true] call blck_fnc_spawnEmplacedWeaponArray;
			_x set[1,_group];
			_x set[2,-1];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime > 0) ) then // a group was spawned and all units are dead
	{
		_x set [2, (diag_tickTime + _respawnTime)];
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime == 0)) then // a group was spawned and all units are dead
	{
		blck_sm_Emplaced = blck_sm_Emplaced - _x;
	};
	
}forEach _sm_Emplaced;

_sm_Vehicles = blck_sm_Vehicles;
{
	// 	["B_G_Offroad_01_armed_F",[22819.4,16929.5,3.17413],"red",600,0,_group,_spawnAt],
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_weapType","_pos","_difficulty","_patrolRadius","_respawnTime"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//	params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_uniforms","_headGear","_missionPatrolVehicles",["_useRelativePos",true]];
			diag_log format["[blckeagls static vehiclePatrol spawner]  _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			_return = [_pos,1,_difficulty,blck_SkinList,blck_headgear,[_groupParameters],false] call blck_fnc_spawnMissionVehiclePatrols;
			_return params ["_vehicles", "_missionAI", "_abort"];
			_group = group (_missionAI select 0);  
			_x set[1,_group];
			_x set[2,-1];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime > 0) ) then // a group was spawned and all units are dead
	{ 
		_x set [2, (diag_tickTime + _respawnTime)];
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_Vehicles = blck_sm_Vehicles - _x;
	};	
}forEach _sm_Vehicles;

_sm_Aircraft = blck_sm_Aircraft;
{
	// 	["Exile_Chopper_Huey_Armed_Green",[22923.4,16953,3.19],"red",1000,0],
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_aircraftType","_pos","_difficulty","_patrolRadius","_respawnTime"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{
		if ( (isNull _group) && (diag_tickTime > _spawnAt) && (_spawnAt != -1)) then  // no group has been spawned, spawn one.
		{
			//params["_coords","_skillAI","_weapons","_uniforms","_headGear","_helis",["_chanceParas",0]];
			diag_log format["[blckeagls static aircragePatrol spawner]  _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			_return = [_pos,_difficulty,[toLower _difficulty] call blck_fnc_selectAILoadout,blck_SkinList,blck_headgear,[_aircraftType],0] call blck_fnc_spawnMissionHeli;
			_return params ["_patrolHeli","_ai","_abort"];
			_group = group (_ai select 0);
			_x set[1,_group];
			_x set[2,-1];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime > 0) ) then // a group was spawned and all units are dead
	{
		_x set [2, (diag_tickTime + _respawnTime)];
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnTime == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_Aircraft = blck_sm_Aircraft - _x;
	};	
}forEach _sm_Aircraft;

//diag_log "[blckeagls] GMS_sm_monitorStaticUnits.sqf <Executed>";

blck_sm_functionsLoaded = true;