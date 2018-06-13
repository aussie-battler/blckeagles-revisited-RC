/*
	by Ghostrider [GRG]
	for ghostridergaming
	12/5/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#define onFoot 1
#define inVehicle 2

_fnc_updateGroupSpawnTimerFields = {
	diag_log format["_fnc_updateGroupSpawnTimerFields::-> _this = %1",_this];
	params["_array","_element",["_group",grpNull],["_spawnedAt",0]];
	private _index = _array find _element;
	_element set[1,_group];
	_element set[2,_spawnedAt];
	_array set[_index,_element];
};
private _triggerRange = 1000;
_fnc_evaluateSpawnedGroups = {
	params["_aiType","_patrolsArray"];
	private _localpatrolsArray = +_patrolsArray;
	{
		//  _x = [ [[22819.4,16929.5,5.33892],""red"",4,75,30], R Alpha 1-1,-1,0]"
		diag_log format["_fnc_evaluateSpawnedGroups: _x = %1",_x];
		_x params["_groupParameters","_group","_spawnedAt","_respawnAt","_lastTimePlayerNear"];
		if !(isNull _group) then 
		{		
			//  [[22819.4,16929.5,5.33892],""red"",4,75,30]
			//_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnInterval"];	
			diag_log format["_fnc_evaluateSpawnedGroups: typeName _groupParameters select 0 = %1",typeName (_groupParameters select 0)];
			private["_pos","_difficulty","_units","_patrolRadius","_respawnInterval","_vehicleType"];
			if (_aiType isEqualTo onFoot) then {
				//_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnInterval"]
				_pos = _groupParameters select 0;
				_difficulty = _groupParameters select 1;
				_units = _groupParameters select 2;
				_patrolRadius = _groupParameters select 3;
				_respawnInterval = _groupParameters select 4;
			};	
			
			if (_aiType  isEqualTo inVehicle) then 
			{
				//_groupParameters params["_vehicleType","_pos","_difficulty","_patrolRadius","_respawnInterval"]};	
				_vehicleType = _groupParameters select 0;
				_pos = _groupParameters select 1;
				_difficulty = _groupParameters select 2;
				_patrolRadius = _groupParameters select 3;
				_respawnInterval = _groupParameters select 4;
			};
			
			diag_log format["_fnc_evaluateSpawnedGroups: _groupParameters = %1",_groupParameters];
			diag_log format["_fnc_evaluateSpawnedGroups: _pos = %1 | _difficulty = %2 | _patrolRadius = %3 | _respawnInterval = %4",_pos,_difficulty,_patrolRadius,_respawnInterval];
			diag_log format["_fnc_evaluateSpawnedGroups: units alive in group %1 = %2",_group, {alive _x} count (units _group)];
			//diag_log format["_fnc_evaluateSpawnedGroups: _respawnInterval = %1",_respawnInterval];
			if (_spawnedAt > 0) then
			{
				if (({alive _x} count (units _group) == 0)) then 
				{
					diag_log format["all units in patrol %1 are dead | _respawnInterval = %2",_x,_respawnInterval];
					if ((_respawnInterval != 0)) then // a group was spawned and all units are dead and we should respawn them after a certain interval
					{
						//[_patrolsArray,_x,grpNull,0,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupRepawnTimerFields;
						private _index = _patrolsArray find _element;
						private _element = _x;
						_element set[1,grpNull];
						_element set[2,0];
						_element set[3,(diag_tickTime + _respawnInterval)];
						_patrolsArray set[_index,_element];					
						diag_log format["_fnc_evaluateSpawnedGroups | element updated to %1",_element];
						diag_log format["_fnc_evaluateSpawnedGroups: _patrolsArray updated to %1",_patrolsArray];
					};
					if (_respawnInterval == 0) then // a group was spawned and all units are dead but we should not do a respawn
					{
						_patrolsArray deleteAt (_patrolsArray find _x);
						diag_log format["patrol %1 deleted from static patrol cue",_x];
					};

				};
				if ({alive _x} count (units _group) > 0) then
				{
					// Case where a player is near and we need to update the time stamp.
					if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
					{
						private _index = _patrolsArray find _x;
						_x set[4, diag_tickTime];
						_patrolsArray set[_index,_x];  
						diag_log format["player near static group for element %1 timestamp updated to %2",_x, _x select 4];
					} else {				
					// Case where no player is near and we need to test if the patrol should be de-spawned.
						if ((diag_tickTime - _lastTimePlayerNear) > blck_sm_groupDespawnTime) then
						{
							diag_log format["despawning static group %1",_x];
							private _index = _patrolsArray find _x;							
							_groupParameters set[2,{alive _x} count (units _group)];
							_element = _x;
							_element set[0,_groupParameters];
							_element set[1,grpNull];
							_element set[2,0];
							_element set[3,(diag_tickTime + _respawnInterval)];					
							_patrolsArray set[_index,_element];
							{
								if (vehicle _x != _x) then {[vehicle _x] call blck_fnc_deleteAIVehicle};
								[_x] call blck_fnc_deleteAI;
							} forEach (units _group);
						};
					};
				};
			};
		};
	} forEach _localpatrolsArray;
};


blck_sm_monitoring = 1;
_sm_groups = +blck_sm_Groups;
{
	_x params["_groupParameters","_group","_spawnedAt","_respawnAt","_lastTimePlayerNear"];
	_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnInterval"];	
	//diag_log format["<_sm_monitorStaticUnits::Group spawning routine:: _units = %1 | _x = %2 |_forEachIndex = %3",_units,_x,_forEachIndex];
	//private _groupSpawned = false;
	//diag_log format["there are %1 players in range",{_pos distance2D _x < _triggerRange} count allPlayers];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{
		if ((isNull _group)) then
		{
			//diag_log format["testing if patrol %1 should be spawned | _spawnedAt = %2",_x,_spawnedAt];
			//diag_log format["_spawnedAt = %1 | _respawnAt = %2 | _respawnInterval = %3",_spawnedAt,_respawnAt, _respawnInterval];
			if ( ((_spawnedAt == 0) && (_respawnAt == 0)) || ((diag_tickTime > _respawnAt) && (_respawnInterval > 0)) ) then  // no group has been spawned, spawn one.
			{
				//diag_log format["[blckeagls static group spawner] evaluating _x = %1 ",_x];
				_numAI = [_units] call blck_fnc_getNumberFromRange;
				//diag_log format["[blckeagls static group spawner] _units = %1 and _numAI = %2",_units,_numAI];		
				// // params["_pos",  "_center", _numai1,  _numai2,  _skillLevel, _minDist, _maxDist, _configureWaypoints, _uniforms, _headGear,_vests,_backpacks,_weaponList,_sideArms, _scuba ];
				_group = [_pos,_pos,_numAI,_numAI,_difficulty,_patrolRadius-2,_patrolRadius,true] call blck_fnc_spawnGroup;
				//diag_log format["[blckeagls static group spawner] _group %1",_group];
				[blck_sm_Groups,_x,_group,diag_tickTime] call _fnc_updateGroupSpawnTimerFields;
				diag_log format["_sm_monitorStaticUnits | spawn Group step :: blck_sm_Groups updated to %1",blck_sm_Groups];
			};
		};
	};
}forEach _sm_groups;
[onFoot,blck_sm_Groups] call _fnc_evaluateSpawnedGroups;


_sm_Vehicles = +blck_sm_Vehicles;
{
	// 	["B_G_Offroad_01_armed_F",[22819.4,16929.5,3.17413],"red",600,0,_group,_spawnAt],
	//diag_log format["_sm_monitorVehicles::-> _x = %1",_x];
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_vehicleType","_pos","_difficulty","_patrolRadius","_respawnInterval"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_missionPatrolVehicles",["_useRelativePos",true],["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols], ["_isScubaGroup",false]];
			_return = [_pos,1,_difficulty,[_groupParameters],false] call blck_fnc_spawnMissionVehiclePatrols;
			//  _return = [_vehicles, _missionAI, _abort];
			_group = group (_return select 1 select 0);
			[blck_sm_Vehicles,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			diag_log format["_sm_monitorStaticUnits | spawn emplaced step :: blck_sm_Vehicles updated to %1",blck_sm_Vehicles];
		};
	};	
}forEach _sm_Vehicles;
[inVehicle,blck_sm_Vehicles] call _fnc_evaluateSpawnedGroups;

_sm_scubaGroups = +blck_sm_scubaGroups;
{
	
	// [ [px, py, pz] /* position*/, "difficulty", 4 /*Number to Spawn*/, 150 /*radius of patrol*/, _respawnInterval, _group, _spawnAt]
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnInterval"];
	//diag_log format["<_sm_monitorScubaUnits:: _group = %1 | _x = %2 |_forEachIndex = %3",_group,_x,_forEachIndex];
	private _groupSpawned = false;
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{
		if ((isNull _group) && (diag_tickTime > _spawnAt) && (_spawnAt != -1)) then  // no group has been spawned, spawn one.
		{
			//diag_log format["[blckeagls static scubaGroup spawner] evaluating _x = %1 ",_x];
			_numAI = [_units] call blck_fnc_getNumberFromRange;
			//diag_log format["[blckeagls static scubaGroup spawning routine] _units = %1 and _numAI = %2",_units,_numAI];		
			//params["_pos", "_numUnits", ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_UMS_uniforms], ["_headGear",blck_UMS_headgear],["_configureWaypoints",true],["_weapons",blck_UMS_weapons],["_vests",blck_UMS_vests]];
			_group = [_pos,_difficulty,_units,_patrolRadius] call blck_fnc_spawnScubaGroup;
			//diag_log format["[blckeagls static scubaGroup spawner] _group %1",_group];
			[blck_sm_scubaGroups,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | spawn Group step :: blck_sm_Groups updated to %1",blck_sm_Groups];
		};
		if (!(_groupSpawned) && (isNull _group) && (_spawnAt == -1) && (_respawnInterval > 0)) then // a group was spawned and all units are dead and we should rspawn them after a certain interval
		{
			[blck_sm_scubaGroups,_x,_group,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | set scubaGroup respawn time step :: blck_sm_Groups updated to %1",blck_sm_scubaGroups];			
		};
		if (!(_groupSpawned) && (isNull _group) && (_spawnAt == -1) && (_respawnInterval == 0) ) then // a group was spawned and all units are dead but we should not do a respawn
		{
			blck_sm_scubaGroups deleteAt (blck_sm_scubaGroups find _x);
		};
	};
}forEach _sm_scubaGroups;

_sm_Emplaced = +blck_sm_Emplaced;
{
	// 	["B_G_Mortar_01_F",[22944.3,16820.5,3.14243],"green",0,0,_group,_spawnAt]
	//diag_log format["_sm_monitorEmplacedUnits::-> _x = %1",_x];
	_x params["_groupParameters","_group","_spawnAt"];	
	_groupParameters params["_weapType","_pos","_difficulty","_patrolRadius","_respawnInterval"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//diag_log format["[blckeagls static Emplaced spawner] _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			// params["_coords","_missionEmplacedWeapons","_useRelativePos","_noEmplacedWeapons","_aiDifficultyLevel",["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols]];
			_group = [_pos,[_groupParameters],false,1,_difficulty] call blck_fnc_spawnEmplacedWeaponArray;
			[blck_sm_Emplaced,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | spawn emplaced step :: blck_sm_Emplaced updated to %1",blck_sm_Emplaced];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval > 0) ) then // a group was spawned and all units are dead
	{
			[blck_sm_Emplaced,_x,_group,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | set Group respawn time step :: blck_sm_Emplaced updated to %1",blck_sm_Emplaced];				
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval == 0)) then // a group was spawned and all units are dead
	{
		blck_sm_Emplaced deleteAt (blck_sm_Emplaced find _x);
	};
	
}forEach _sm_Emplaced;

_sm_surfaceVehicles = +blck_sm_surfaceShips;
{
	// 	["B_G_Offroad_01_armed_F",[22819.4,16929.5,3.17413],"red",600,0,_group,_spawnAt],
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_weapType","_pos","_difficulty","_patrolRadius","_respawnInterval"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//diag_log format["[blckeagls static vehiclePatrol spawner]  _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			[_pos,1,_difficulty,[_groupParameters],false] call blck_fnc_spawnMissionVehiclePatrols;
			_return params ["_vehicles", "_missionAI", "_abort"];
			_group = group (_missionAI select 0);  
			[blck_sm_surfaceShips,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | spawn emplaced step :: blck_sm_Vehicles updated to %1",blck_sm_Vehicles];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval > 0) ) then // a group was spawned and all units are dead
	{ 
			[blck_sm_surfaceShips,_x,_group,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | set Group respawn time step :: blck_sm_Vehicles updated to %1",blck_sm_Vehicles];		
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_surfaceShips deleteAt (blck_sm_surfaceShips find _x);
	};	
}forEach _sm_surfaceVehicles;

_sm_SDVVehicles = +blck_sm_submarines;
{
	// 	["B_G_Offroad_01_armed_F",[22819.4,16929.5,3.17413],"red",600,0,_group,_spawnAt],
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_weapType","_pos","_difficulty","_patrolRadius","_respawnInterval"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{	
		if ( (_group isEqualTo grpNull) && (diag_tickTime > _spawnAt) && (_spawnAt != -1) ) then  // no group has been spawned, spawn one.
		{
			//diag_log format["[blckeagls static sub patrol spawner]  _weapType = %1 and _difficulty = %2",_weapType,_difficulty];
			//params["_coords","_noVehiclePatrols","_aiDifficultyLevel","_missionPatrolVehicles",["_useRelativePos",true],["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols], ["_isScubaGroup",false]];
			_return = [_pos,1,_difficulty,[_groupParameters],false,blck_UMS_uniforms,blck_UMS_headgear,blck_UMS_vests,blck_backpacks,blck_UMS_weapons,blck_Pistols,true] call blck_fnc_spawnMissionVehiclePatrols;
			_return params ["_vehicles", "_missionAI", "_abort"];
			_group = group (_missionAI select 0);  
			[blck_sm_submarines,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | spawn emplaced step :: blck_sm_Vehicles updated to %1",blck_sm_Vehicles];
		};
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval > 0) ) then // a group was spawned and all units are dead
	{ 
			[blck_sm_submarines,_x,_group,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | set Group respawn time step :: blck_sm_Vehicles updated to %1",blck_sm_Vehicles];		
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_submarines deleteAt (blck_sm_submarines find _x);
	};	
}forEach _sm_SDVVehicles;

_sm_Aircraft = +blck_sm_Aircraft;
{
	// 	["Exile_Chopper_Huey_Armed_Green",[22923.4,16953,3.19],"red",1000,0],
	_x params["_groupParameters","_group","_spawnAt"];
	_groupParameters params["_aircraftType","_pos","_difficulty","_patrolRadius","_respawnInterval"];
	if ([_pos,_triggerRange] call blck_fnc_playerInRange) then
	{
		if ( (isNull _group) && (diag_tickTime > _spawnAt) && (_spawnAt != -1)) then  // no group has been spawned, spawn one.
		{
			_weapon = [toLower _difficulty] call blck_fnc_selectAILoadout;
			//params["_coords","_skillAI","_helis",["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_Launcher","none"],["_weaponList",[]],["_sideArms",[]]]
			//diag_log format["[blckeagls static aircraftePatrol spawner]  _weapon = %1 and _difficulty = %2",_weapon,_difficulty];
			_return = [_pos,_difficulty,[_aircraftType]] call blck_fnc_spawnMissionHeli;  //  Allow the spawner to fit the default AI Loadouts for blckeagls; revisit at a later time when custom uniforms are set up for these AI.
			//diag_log format["[blckeagls] static aircraftePatrol spawner -> _return = %1",_return];
			_return params ["_patrolHeli","_ai","_abort"];
			_group = group (_ai select 0);
			[blck_sm_Aircraft,_x,_group,-1] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | spawn emplaced step :: blck_sm_Aircraft updated to %1",blck_sm_Aircraft];
		};
	};
	if ( (isNull _group) && (_spawnAt == -1) && (_respawnInterval > 0) ) then // a group was spawned and all units are dead
	{
			[blck_sm_Aircraft,_x,_group,(diag_tickTime + _respawnInterval)] call _fnc_updateGroupSpawnTimerFields;
			//diag_log format["_sm_monitorStaticUnits | set Group respawn time step :: blck_sm_Aircraft updated to %1",blck_sm_Aircraft];	
	};
	if ( (_group isEqualTo grpNull) && (_spawnAt == -1) && (_respawnInterval == 0) ) then // a group was spawned and all units are dead
	{
		blck_sm_Aircraft deleteAt (blck_sm_Aircraft find _x);
	};	
}forEach _sm_Aircraft;
blck_sm_monitoring = 0;