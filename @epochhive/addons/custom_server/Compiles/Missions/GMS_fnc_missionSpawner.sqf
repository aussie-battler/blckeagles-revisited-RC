/*
  Generic Mission Spawner
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 1/22/17
*/

private ["_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_blck_localMissionMarker","_AI_Vehicles","_timeOut","_aiDifficultyLevel"];
params["_coords","_mission"];

////////
// set all variables needed for the missions
// data is pulled either from the mission description or from the _mission variable passsed as a parameter
// Deal with situations where some of these variables might not be defined as well.
////////

// _mission params[_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange];
_markerClass = _mission select 2;
_aiDifficultyLevel = _mission select 3;

if (blck_debugLevel > 0) then {diag_log format["_fnc_mainThread:: -->> _markerClass = %1",_markerClass];};

[_mission,"active",_coords] call blck_fnc_updateMissionQue;
blck_ActiveMissionCoords pushback _coords; 
diag_log format["[blckeagls] missionSpawner (17):: Initializing mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];

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
	if (blck_debugLevel > 1) then {diag_log "missionSpawner:: default values used for _reinforcementLootCounts";};
}
else
{
	if (blck_debugLevel > 1) then {diag_log "missionSpawner (47):: Mission specific values used for _reinforcementLootCounts";};
};

if (blck_debugLevel > 1) then {
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
_blck_localMissionMarker = [_markerClass,_coords,"","",_markerColor,_markerType];
_delayTime = 1;
_groupPatrolRadius = 50;

if (blck_labelMapMarkers select 0) then
{
	//diag_log "labeling map markers *****";
	_blck_localMissionMarker set [2, _markerMissionName];
};
if !(blck_preciseMapMarkers) then
{
	//diag_log "Map marker will be OFFSET from the mission position";
	_blck_localMissionMarker set [1,[_coords,75] call blck_fnc_randomPosition];
};
_blck_localMissionMarker set [3,blck_labelMapMarkers select 1];  // Use an arrow labeled with the mission name?
[["start",_startMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
[_blck_localMissionMarker] execVM "debug\spawnMarker.sqf";

if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (89) waiting for player to trigger the mission";};

////////
//  All parameters are defined, lets wait until a player is nearby or the mission has timed out
////////

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
		if ({isPlayer _x && _x distance2D _coords < blck_TriggerDistance} count allPlayers > 0) then
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


if (_missionTimedOut) exitWith
{
	//  Deal with the case in which the mission timed out.
	//["timeOut",_endMsg,_blck_localMissionMarker select 2] call blck_fnc_messageplayers;
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];
	[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;
	[_blck_localMissionMarker select 0] call compile preprocessfilelinenumbers "debug\deleteMarker.sqf";
	_blck_localMissionMarker set [1,[0,0,0]];
	_blck_localMissionMarker set [2,""];
	[_objects, 0.1] spawn blck_fnc_cleanupObjects;
	if (blck_debugLevel > 0) then
	{
		diag_log format["[blckeagls] missionSpawner:: (105) Mission Timed Out: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
};

if (_playerInRange) then
{
	////////
	// Spawn the mission objects, loot chest, and AI
	////////
	if (blck_debugLevel > 0) then
	{		diag_log format["[blckeagls] missionSpawner:: (112) --  >>  Mission tripped by nearby player: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
	
	if (count _missionLootBoxes > 0) then
	{
		_crates = [_coords,_missionCfg select 2/* array of crates*/] call blck_fnc_spawnMissionCrates;
	}
	else
	{
		_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]]] call blck_fnc_spawnMissionCrates;
		
	};
	// un-comment this if you want crates cleaned up when the rest of the mission objects are removed.
	//_objects append _crates;
	
	if (blck_debugLevel > 0) then
	{
		diag_log format["[blckeagls] missionSpawner:: (131) Crates Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
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
		diag_log format["[blckeagls] missionSpawner:: (166) Landscape spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
	
	uiSleep _delayTime;;

	[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;

	
	uiSleep _delayTime;
	private _precise = false;
	if (blck_debugLevel > 0) then {diag_log format["missionSpawner:: (233) preparing to spawn emplaced weapons for _markerClass %3:: blck_useStatic = %1 and _noEmplacedWeapons = %2",blck_useStatic,_noEmplacedWeapons,_markerClass];};
	if (blck_useStatic && (_noEmplacedWeapons > 0)) then
	{
		private ["_emplacedUnits"];
		//  params["_missionEmplacedWeapons","_noEmplacedWeapons","_aiDifficultyLevel","_coords","_uniforms","_headGear",["_missionType","unspecified"]];
		_emplacedUnits = [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear,_markerClass] call blck_fnc_spawnMissionEmplacedWeapons;
		diag_log format["missionSpawner :: (218) _emplacedUnits = %1",_emplacedUnits];
		uisleep 0.1;
		if (typeName _emplacedUnits isEqualTo "ARRAY") then
		{
			if (typeName _emplacedUnits isEqualTo "ARRAY") then
			{	
				_blck_AllMissionAI append _emplacedUnits;
			};
			//diag_log format["missionSpawner :: (226) _blck_AllMissionAI updated to = %1",_blck_AllMissionAI];
		};
		if (blck_debugLevel > 0) then
		{
			diag_log format["[blckeagls] missionSpawner:: (236) Static Weapons Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};
		
	};
	uisleep _delayTime;
	if (blck_useVehiclePatrols && (_noVehiclePatrols > 0)) then
	{
		private["_vehUnits"];
		_vehUnits = [_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear,_markerClass] call blck_fnc_spawnMissionVehiclePatrols;
		//diag_log format["missionSpawner :: (238) _vehUnits = %1",_vehUnits];
		if (typeName _vehUnits isEqualTo "ARRAY") then
		{
			_blck_AllMissionAI append _vehUnits;
		};

		uiSleep _delayTime;
		if (blck_debugLevel > 0) then
		{
			diag_log format["[blckeagls] missionSpawner:: Vehicle Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};
	};	
	uiSleep _delayTime;
	private ["_infantry"];
	_infantry = [_coords, _minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;
	//diag_log format["missionSpawner:: (254) -> _infantry = %1",_infantry];
	if (typeName _infantry isEqualto "ARRAY") then
	{
		_blck_AllMissionAI append _infantry;
	};
	
	uiSleep _delayTime;
	if (blck_debugON) then
	{
		diag_log format["[blckeagls] missionSpawner:: AI Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
	
	if ((random(1) < _chanceReinforcements)) then
	{
		_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout;
		private["_grpReinforcements"];
		_grpReinforcements = grpNull;
		
		//diag_log format["[blckeagls] missionSpawner:: calling in reinforcements: Current mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		[] spawn {
			//[_coords,_noPara,_aiDifficultyLevel,_chanceLoot,_reinforcementLootCounts,_weaponList,_uniforms,_headgear,_chanceHeliPatrol] call blck_fnc_Reinforcements;
			//waitUntil {_grpReinforcements != grpNull};
			//diag_log format["[blckeagls] missionSpawner::reinforcement spawner started: Current mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
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
			uiSleep 300;
			_missionComplete = 1;
		} else {
			if (_endIfPlayerNear) then {
				if ( { (isPlayer _x) && ([_x,_locations,20] call blck_fnc_objectInRange) && (vehicle _x == _x) } count allPlayers > 0) then {
					_missionComplete = 1;
				};
			};
			if (_endIfAIKilled) then {
				if (({alive _x} count _blck_AllMissionAI) < 1 ) then {
					_missionComplete = 1;
				};
			};
			uiSleep 2;
		};
	};
	
	if (blck_debugLevel > 1) then
	{
		diag_log format["[blckeagls] missionSpawner:: (329) Mission completion criteria fulfilled: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
	
	if (blck_useSignalEnd) then
	{
		//diag_log format["**** Minor\SM1.sqf::    _crate = %1",_crates select 0];
		[_crates select 0] spawn blck_fnc_signalEnd;
		
		if (blck_debugLevel > 1) then
		{
			diag_log format["[blckeagls] missionSpawner:: (340) SignalEnd called: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
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
	[_blck_localMissionMarker select 1, _markerClass] execVM "debug\missionCompleteMarker.sqf";
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];
	blck_recentMissionCoords pushback [_coords,diag_tickTime]; 
	[_mission,"inactive",[0,0,0]] call blck_fnc_updateMissionQue;
	uisleep 0.1;
	diag_log format["[blckeagls] missionSpawner:: (357)end of mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};
