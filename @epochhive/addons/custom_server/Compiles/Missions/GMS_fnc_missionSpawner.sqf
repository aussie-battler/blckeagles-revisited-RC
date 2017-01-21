/*
  Generic Mission Spawner
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 1/12/17
*/

private ["_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_blck_localMissionMarker","_AI_Vehicles","_timeOut"];
params["_coords","_missionType","_aiDifficultyLevel"];
waitUntil {blck_missionSpawning isEqualTo false};
blck_missionSpawning = true;
diag_log format["[blckeagls] missionSpawner:: Initializing mission: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];

private["_chanceHeliPatrol","_noPara","_reinforcementLootCounts","_chanceLoot","_heliCrew"];
if (isNil "_chanceReinforcements") then
{
	_chanceReinforcements = 0;
	_noPara = 0;
	_reinforcementLootCounts = [0,0,0,0,0,0];
	_chanceHeliPatrol = 0;
	_chanceLoot = 0;
};

if (isNil "_markerColor") then {_markerColor = "ColorBlack"};
if (isNil "_markerType") then {_markerType = ["mil_box",[]]};
if (isNil "_timeOut") then {_timeOut = -1;};
if (isNil "_noPara") then {_noPara = 0};
if (isNil "_chanceHeliPatrol") then {_chanceHeliPatrol = 0;};
if (isNil "_chanceLoot") then {_chanceLoot = 0};
if (isNil "_heliCrew") then {_heliCrew = 3};

if (isNil "_reinforcementLootCounts") then
{
	private["__weap","_mags","_backpacks","_optics","_loadout"];
	_weap = 2 + floor(random(4));
	_mags = 5 + floor(random(6));
	_backpacks = 1 + floor(random(2));
	_optics = 1 + floor(random(6));
	_loadout = 1 + floor(random(3));
	_reinforcementLootCounts = [_weap,_mags,_optics,0,0,_backpacks];
	if (blck_debugLevel > 0) then {diag_log "missionSpawner:: default values used for _reinforcementLootCounts";};
}
else
{
	if (blck_debugLevel > 0) then {diag_log "missionSpawner:: Mission specific values used for _reinforcementLootCounts";};
};

if (blck_debugLevel > 0) then {
	diag_log format["[blckEagle] Mission Reinforcement Parameters: changeReinforcements %1 numAI %2  changePatrol %3  chanceLoot %4",_chanceReinforcements,_noPara,_chanceHeliPatrol,_chanceLoot];
};

private["_useMines","_abortMissionSpawner","_blck_AllMissionAI","_delayTime","_groupPatrolRadius"];
if (isNil "_useMines") then {_useMines = blck_useMines;};

_objects = [];
_mines = [];
_crates = [];
_aiGroup = [];
_missionAIVehicles = [];
_blck_AllMissionAI = [];
_AI_Vehicles = [];
_blck_localMissionMarker = [_missionType,_coords,"","",_markerColor,_markerType];
_delayTime = 1;
_groupPatrolRadius = 50;

if (blck_labelMapMarkers select 0) then
{
	//diag_log "SM1.sqf: labeling map markers *****";
	_blck_localMissionMarker set [2, _markerMissionName];
};
if !(blck_preciseMapMarkers) then
{
	//diag_log "SM1.sqf:  Map marker will be OFFSET from the mission position";
	_blck_localMissionMarker set [1,[_coords,75] call blck_fnc_randomPosition];
};
_blck_localMissionMarker set [3,blck_labelMapMarkers select 1];  // Use an arrow labeled with the mission name?
[["start",_startMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
[_blck_localMissionMarker] execVM "debug\spawnMarker.sqf";

uiSleep 1;
/////////////////////////////
//   Everything has been set up for the mission and it is now waiting to be triggered by a nearby player or to time out.
//   Lets let other instances of the mission spawner know it is OK to go ahead
////////////////////////////
blck_missionSpawning = false;

if (blck_debugON) then {diag_log "missionSpawner:: waiting for player to trigger the mission";};
private["_wait","_missionStartTime","_playerInRange","_missionTimedOut"];
_missionStartTime = diag_tickTime;
_playerInRange = false;
_missionTimedOut = false;
_wait = true;
while {_wait} do
{
	if (blck_debugLevel isEqualTo 3) then
	{
		_wait = false;
		_playerInRange = true;
	} else {		
		if ({isPlayer _x && _x distance _coords < blck_TriggerDistance} count allPlayers > 0) then
		{
			_wait = false;
			_playerInRange = true;
		} else
		{
			if ((diag_tickTime - _missionStartTime) > blck_MissionTimout) then
			{
				_wait = false;
				_missionTimedOut = true;
			};
		};
		uiSleep 1;
	};
};
//waitUntil{ { (isPlayer _x && _x distance _coords <= blck_TriggerDistance /*&& vehicle _x == _x*/) || ([_missionStartTime] call _fn_timedOut) } count playableunits > 0 };

if (blck_debugON) then
{
	diag_log format["missionSpawner:: Mission Triggerred contition playerInRange %1 and timout = %2",_playerInRange, _missionTimedOut];
};

if (!_playerInRange && _missionTimedOut) exitWith
{
	//["timeOut",_endMsg,_blck_localMissionMarker select 2] call blck_fnc_messageplayers;
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	_blck_localMissionMarker set [1,[0,0,0]];
	_blck_localMissionMarker set [2,""];
	[_objects, 1] spawn blck_fnc_cleanupObjects;
	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: Mission Timed Out: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
};

if (_playerInRange) then
{
	if (blck_debugON) then
	{		diag_log format["[blckeagls] missionSpawner:: --  >>  Mission tripped by nearby player: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
	
	if (count _missionLootBoxes > 0) then
	{
		_crates = [_coords,_missionCfg select 2/* array of crates*/] call blck_fnc_spawnMissionCrates;
	}
	else
	{
		_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]]] call blck_fnc_spawnMissionCrates;
		
	};
	//_objects append _crates;
	
	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: Crates Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
	
	uiSleep _delayTime;
	private ["_temp"];
	if (blck_SmokeAtMissions select 0) then  // spawn a fire and smoke near the crate
	{
		_temp = [_coords,blck_SmokeAtMissions select 1] call blck_fnc_smokeAtCrates;
		if (typeName _temp isEqualTo "ARRAY") then 
		{
			_objects append _temp;
		};
	};
	uiSleep _delayTime;
	if (_useMines) then
	{
		_mines = [_coords] call blck_fnc_spawnMines;
		uiSleep _delayTime;;
	};
	uiSleep _delayTime;
	_temp = [];
	if (_missionLandscapeMode isEqualTo "random") then
	{
		_temp = [_coords,_missionLandscape, 3, 15, 2] call blck_fnc_spawnRandomLandscape;
	} else {
		_temp = [_coords, floor(random(360)),_missionLandscape,true] call blck_fnc_spawnCompositionObjects;
	};
	if (typeName _temp isEqualTo "ARRAY") then
	{
		_objects append _temp;
	};
	//diag_log format["_fnc_missionSpawner:: (181)->> _objects = %1",_objects];

	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: Landscape spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
	
	uiSleep _delayTime;;

	// ========
	// Old version
	// ========
	/*
	if ((count _missionLootVehicles) > 0) then  // spawn loot vehicles
	{
		{
			//diag_log format["spawnMissionCVehicles.sqf _x = %1",_x];
			_offset = _x select 1; // offset relative to _coords at which to spawn the vehicle
			_pos = [(_coords select 0)+(_offset select 0),(_coords select 1) + (_offset select 1),(_coords select 2)+(_offset select 2)];
			_veh = [_x select 0, _pos] call blck_fnc_spawnVehicle;
			_vehs pushback _veh;
			[_veh,_x select 2, _x select 3] call blck_fnc_fillBoxes;
		}forEach _missionLootVehicles;
		
	};
	*/
	// ========
	// Modular Version
	// ========
	[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;
	//  ==========
	
	uiSleep _delayTime;
	private _precise = false;
	if (blck_useStatic && (_noEmplacedWeapons > 0)) then
	{
		// =======
		// Old version
		// =======
		/*if ( count (_missionEmplacedWeapons) isEqualTo 0 ) then
		{
			_missionEmplacedWeapons = [_coords,_noEmplacedWeapons,35,50] call blck_fnc_findPositionsAlongARadius;
			_precise = true;
		};
		
		{
			_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
			if !(isNull _emplacedGroup) then
			{
				_blck_AllMissionAI append (units _emplacedGroup);
				_emplacedWeapon = [_x,_emplacedGroup,blck_staticWeapons,5,15,_precise] call  blck_fnc_spawnEmplacedWeapon;
			};
		}forEach _missionEmplacedWeapons;
		//===============================
		*/
		
		// ======
		// Modular Version
		// ======
		private ["_emplacedUnits"];
		_emplacedUnits = [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnMissionEmplacedWeapons;
		//diag_log format["missionSpawner :: (247) _emplacedUnits = %1",_emplacedUnits];
		uisleep 0.1;
		if (typeName _emplacedUnits isEqualTo "ARRAY") then
		{
			if (typeName _emplacedUnits isEqualTo "ARRAY") then
			{	
				_blck_AllMissionAI append _emplacedUnits;
			};
			//diag_log format["missionSpawner :: (255) _blck_AllMissionAI updated to = %1",_blck_AllMissionAI];
		};
		//==============================
		if (blck_debugON) then
		{
			diag_log format["[blckeagls] missionSpawner:: Static Weapons Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
		};
	};
	uisleep _delayTime;
	if (blck_useVehiclePatrols && (_noVehiclePatrols > 0)) then
	{
		//  ==============
		//  Old code
		// ===============
		/*
		private["_vehGroup","_patrolVehicle"];
		//_vehiclePatrolSpawns= [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;
		{
			_vehGroup = [_x,3,3,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
			diag_log format["missionSpawner:: (249) group for AI Patrol vehicle spawn: group is %1 with units of %2",_vehGroup, units _vehGroup];
			diag_log format["missionSpawner:: (250) _blck_AllMissionAI prior to appending _vehGroup units = %1",_blck_AllMissionAI];
			uiSleep 0.1;
			if !(isNull _vehGroup) then
			{
				if (typeName (units _vehGroup) isEqualTo "ARRAY") then
				{
					_blck_AllMissionAI = _blck_AllMissionAI append (units _vehGroup);
					diag_log format["missionSpawner:: _blck_AllMissionAI after appending _vehGroup units = %1",_blck_AllMissionAI];
					_randomVehicle = selectRandom blck_AIPatrolVehicles;
					_patrolVehicle = [_coords,_x,_randomVehicle,(_x distance _coords) -5,(_x distance _coords) + 5,_vehGroup] call blck_fnc_spawnVehiclePatrol;
				};
			};
		}forEach [_coords,_noVehiclePatrols,45,60] call blck_fnc_findPositionsAlongARadius;;
		*/
		// =====================
		// Modular version
		// =====================
		private["_vehUnits"];
		_vehUnits = [_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionVehiclePatrols;
		//diag_log format["missionSpawner :: (240) _vehUnits = %1",_vehUnits];
		if (typeName _vehUnits isEqualTo "ARRAY") then
		{
			_blck_AllMissionAI append _vehUnits;
		};

		uiSleep _delayTime;
		if (blck_debugON) then
		{
			diag_log format["[blckeagls] missionSpawner:: Vehicle Patrols Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
		};
	};	
	uiSleep _delayTime;

	// =====
	//  Old Version
	// +++++++++++
	/*
	private["_unitsToSpawn","_unitsPerGroup","_ResidualUnits","_newGroup"];
	_unitsToSpawn = round(_minNoAI + round(random(_maxNoAI - _minNoAI)));
	_unitsPerGroup = floor(_unitsToSpawn/_noAIGroups);
	_ResidualUnits = _unitsToSpawn - (_unitsPerGroup * _noAIGroups);
	//diag_log format["missionSpawner:: _unitsToSpawn %1 ; _unitsPerGroup %2  _ResidualUnits %3",_unitsToSpawn,_unitsPerGroup,_ResidualUnits];
	switch (_noAIGroups) do
	{
		case 1: {  // spawn the group near the mission center
			//params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
			_newGroup = [_coords,_unitsToSpawn,_unitsToSpawn,_aiDifficultyLevel,_coords,3,18,_uniforms,_headGear] call blck_fnc_spawnGroup;
			 _blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
			 //diag_log format["missionSpawner: Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, (units _newGroup)];
			 };
		case 2: {
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=2"];  // spawn groups on either side of the mission area
				_groupLocations = [_coords,_noAIGroups,15,30] call blck_fnc_findPositionsAlongARadius;
				{
					private["_adjusttedGroupSize"];
					if (_ResidualUnits > 0) then
					{
						_adjusttedGroupSize = _unitsPerGroup + _ResidualUnits;
						_ResidualUnits = 0;
					} else {
						_adjusttedGroupSize = _unitsPerGroup;
					};
					_newGroup = [_x,_adjusttedGroupSize,_adjusttedGroupSize,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					_blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
					//diag_log format["missionSpawner: Spawning 2 Groups: _newGroup=%1  _newAI = %2",_newGroup,  (units _newGroup)];
				}forEach _groupLocations;

			};
		case 3: { // spawn one group near the center of the mission and the rest on the perimeter
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=3"];
				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
				_blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=3 _newGroup=%1 _newAI = %2",_newGroup,  append (units _newGroup)];
				_groupLocations = [_coords,2,20,35] call blck_fnc_findPositionsAlongARadius;
				{
					_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					_blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
					//diag_log format["missionSpawner: Spawning 2 Groups:_newGroup=%1  _newAI = %2",_newGroup,  (units _newGroup)];
				}forEach _groupLocations;

			};
		default {  // spawn one group near the center of the mission and the rest on the perimeter
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=default"];
				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
				_blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=%3 _newGroup=%1 _newAI = %2",_newGroup,  (units _newGroup),_noAIGroups];
				_groupLocations = [_coords,(_noAIGroups - 1),20,40] call blck_fnc_findPositionsAlongARadius;
				{
					_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					_blck_AllMissionAI = _blck_AllMissionAI append (units _newGroup);
					//diag_log format["missionSpawner: Spawning %3 Groups: _newGroup=%1  _newAI = %2",_newGroup,  (units _newGroup),_noAIGroups];
				}forEach _groupLocations;
			};
	};
	*/
	
	////////
	// Modular Version
	// =====
	private ["_infantry"];
	_infantry = [_coords, _minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;
	//diag_log format["missionSpawner:: (337) -> _infantry = %1",_infantry];
	if (typeName _infantry isEqualto "ARRAY") then
	{
		_blck_AllMissionAI append _infantry;
	};
	
	uiSleep _delayTime;
	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: AI Patrols Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
	
	if ((random(1) < _chanceReinforcements)) then
	{
		_weaponList = blck_WeaponList_Red;

		switch (_aiDifficultyLevel) do {
			case "blue": {_weaponList = blck_WeaponList_Blue;};
			case "red": {_weaponList = blck_WeaponList_Red;};
			case "green": {_weaponList = blck_WeaponList_Green;};
			case "orange": {_weaponList = blck_WeaponList_Orange;};
			default {_weaponList = blck_WeaponList_Blue;};
		};

		//diag_log format["missionSpawner:: weaponList = %1",_weaponList];
		private["_grpReinforcements"];
		_grpReinforcements = grpNull;
		
		//diag_log format["[blckeagls] missionSpawner:: calling in reinforcements: Current mission: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
		[] spawn {
			//[_coords,_noPara,_aiDifficultyLevel,_chanceLoot,_reinforcementLootCounts,_weaponList,_uniforms,_headgear,_chanceHeliPatrol] call blck_fnc_Reinforcements;
			//waitUntil {_grpReinforcements != grpNull};
			//diag_log format["[blckeagls] missionSpawner::reinforcement spawner started: Current mission: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
		};
		if !(_grpReinforcements isEqualTo grpNull) then
		{
			_blck_AllMissionAI = _blck_AllMissionAI + (units _grpReinforcements);
			//diag_log format["missionSpawner:: _grpReinforcements = %1",_grpReinforcements];
		};
	};
	
	// Trigger for mission end
	//diag_log format["[blckeagls] mission Spawner _endCondition = %1",_endCondition];
	private["_missionComplete"];
	_missionComplete = -1;

	_endIfPlayerNear = false;
	_endIfAIKilled = false;
	_startTime = diag_tickTime;
	_missionTimedOut = false;

	switch (_endCondition) do
	{
		case "playerNear": {_endIfPlayerNear = true;};
		case "allUnitsKilled": {_endIfAIKilled = true;};
		case "allKilledOrPlayerNear": {_endIfPlayerNear = true;_endIfAIKilled = true;};
	};
	//diag_log format["missionSpawner :: _endIfPlayerNear = %1 _endIfAIKilled= %2",_endIfPlayerNear,_endIfAIKilled];
	private["_locations"];
	_locations = [_coords] + _crates;
	
	//diag_log format["missionSpawner:: Waiting for player to satisfy mission end criteria of _endIfPlayerNear %1 with _endIfAIKilled %2",_endIfPlayerNear,_endIfAIKilled];
	while {_missionComplete  isEqualTo -1} do
	{
		if (blck_debugLevel isEqualTo 3) then
		{
			uiSleep 120;
			_missionComplete = 1;
		} else {
			if (_endIfPlayerNear) then {
				if ( { (isPlayer _x) && ([_x,_locations,20] call blck_fnc_objectInRange) && (vehicle _x == _x) } count allPlayers > 0) then {
					_missionComplete = 1;
				};
			};
			//diag_log format["missionSpawner:: count alive _blck_AllMissionAI = %1",{alive _x} count _blck_AllMissionAI];
			if (_endIfAIKilled) then {
				if (({alive _x} count _blck_AllMissionAI) < 1 ) then {
					_missionComplete = 1;
					//diag_log format["missionSpawner:: _blck_AllMissionAI = %1","testing case _endIfAIKilled"];
				};
			};
			uiSleep 2;
		};
	};
	
	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: Mission completion criteria fulfilled: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
	
	if (blck_useSignalEnd) then
	{
		//diag_log format["**** Minor\SM1.sqf::    _crate = %1",_crates select 0];
		[_crates select 0] spawn blck_fnc_signalEnd;
		
		if (blck_debugON) then
		{
			diag_log format["[blckeagls] missionSpawner:: SignalEnd called: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
		};
	};
	[_mines] spawn blck_fnc_clearMines;
	//diag_log format["missionSpawner:: (473) _objects = %1",_objects];
	uisleep 0.1;
	[_objects, blck_cleanupCompositionTimer] spawn blck_fnc_addObjToQue;
	//diag_log format["missionSpawner:: (476) _blck_AllMissionAI = %1",_blck_AllMissionAI];
	uisleep 0.1;
	[_blck_AllMissionAI,blck_AliveAICleanUpTimer] spawn blck_fnc_addLiveAItoQue;
	[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
	[_blck_localMissionMarker select 1, _missionType] execVM "debug\missionCompleteMarker.sqf";
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	uisleep 0.1;
	diag_log format["[blckeagls] missionSpawner:: end of mission: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};
