/*
  Generic Mission Spawner
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/18/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private ["_abort","_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_blck_localMissionMarker","_AI_Vehicles","_timeOut","_aiDifficultyLevel"];
params["_coords","_mission",["_allowReinforcements",true]];
diag_log format["_missionSpawner (18)::  _allowReinforcements = %1",_allowReinforcements];

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

private["_chanceHeliPatrol","_noPara","_reinforcementLootCounts","_chanceLoot","_heliCrew","_loadCratesTiming"];

if (isNil "_markerColor") then {_markerColor = "ColorBlack"};
if (isNil "_markerType") then {_markerType = ["mil_box",[]]};
if (isNil "_timeOut") then {_timeOut = -1;};
if (isNil "_loadCratesTiming") then {_loadCratesTiming = blck_loadCratesTiming}; // valid choices are "atMissionCompletion" and "atMissionSpawn"; 

private["_useMines","_blck_AllMissionAI","_delayTime","_groupPatrolRadius"];
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
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (91) message players and spawn a mission marker";};
[["start",_startMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
[_blck_localMissionMarker] execVM "debug\spawnMarker.sqf";
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (94) waiting for player to trigger the mission";};

////////
//  All parameters are defined, lets wait until a player is nearby or the mission has timed out
////////

private["_wait","_missionStartTime","_playerInRange","_missionTimedOut"];
_missionStartTime = diag_tickTime;
_playerInRange = false;
_missionTimedOut = false;
_wait = true;
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: (105) starting mission trigger loop"};

while {_wait} do
{
	//diag_log "missionSpawner:: top of mission trigger loop";
	if (blck_debugLevel > 2) exitWith {_playerInRange = true;};
	if ([_coords, blck_TriggerDistance, false] call blck_fnc_playerInRange) exitWith {_playerInRange = true;};
	if ([_missionStartTime] call blck_fnc_timedOut) exitWith {_missionTimedOut = true;};
	uiSleep 5;
	//diag_log format["missionSpawner:: Trigger Loop - blck_debugLevel = %1 and _coords = %2",blck_debugLevel, _coords];
	//diag_log format["missionSpawner:: Trigger Loop - players in range = %1",{isPlayer _x && _x distance2D _coords < blck_TriggerDistance} count allPlayers];
	//diag_log format["missionSpawner:: Trigger Loop - timeout = %1", [_missionStartTime] call blck_fnc_timedOut];
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

////////
// Spawn the mission objects, loot chest, and AI
////////
if (blck_debugLevel > 0) then
{		
	diag_log format["[blckeagls] missionSpawner:: (112) --  >>  Mission tripped: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};

if (count _missionLootBoxes > 0) then
{
	_crates = [_coords,_missionCfg select 2,_loadCratesTiming] call blck_fnc_spawnMissionCrates;
}
else
{
	_crates = [_coords,[[selectRandom blck_crateTypes,[0,0,0],_crateLoot,_lootCounts]], _loadCratesTiming] call blck_fnc_spawnMissionCrates;
	
};

if (blck_cleanUpLootChests) then
{
	_objects append _crates;
};

if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: (136) Crates Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};
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

if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: (170) Landscape spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};

uiSleep _delayTime;;

[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;

uiSleep _delayTime;

_abort = false;
_temp = [[],[],false];
_temp = [_coords, _minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;
//[_coords, _minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;

if  (blck_debugLevel > 2) then {
	diag_log format["missionSpawner :: (185) blck_fnc_spawnMissionAI returned a value of _temp = %1",_temp]; uiSleep 1;
};

_abort = _temp select 1;
if  (blck_debugLevel > 2) then {
	diag_log format["missionSpawner :: (190) blck_fnc_spawnMissionAI returned a value of _abort = %1",_abort]; uiSleep 1;
};
if (_abort) exitWith
{
	if (blck_debugLevel > 1) then {
		diag_log "missionSpawner:: (194) grpNull returned, mission termination criteria met, calling blck_fnc_endMission"
	};
	[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,true] call blck_fnc_endMission;
};
if !(_abort) then 
{
	_blck_AllMissionAI append (_temp select 0);
};

uiSleep _delayTime;
if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: (202) AI Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};
_temp = [[],[],false];
_abort = false;
if (blck_useVehiclePatrols && (_noVehiclePatrols > 0)) then
{
	_temp = [_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear,_markerClass] call blck_fnc_spawnMissionVehiclePatrols;
	//[_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear,_markerClass] call blck_fnc_spawnMissionVehiclePatrols;
	if  (blck_debugLevel > 1) then {
			diag_log format["missionSpawner :: (216) blck_fnc_spawnMissionVehiclePatrols returned _temp = %1",_temp]; 
	};
	if (typeName _temp isEqualTo "ARRAY") then
	{
		_abort = _temp select 2;
	};
	if !(_abort) then
	{
		_objects append (_temp select 0);
		_blck_AllMissionAI append (_temp select 1);
		if (blck_debugLevel > 0) then
		{
			diag_log format["[blckeagls] missionSpawner:: (216) Vehicle Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};
	};
};

if (_abort) exitWith 
{
	if (blck_debugLevel > 0) then {
		diag_log "missionSpawner:: (222) grpNull returned, mission termination criteria met, calling blck_endMission";
	};
	[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,true] call blck_fnc_endMission;
};

uiSleep _delayTime;
_temp = [[],[],false];
_abort = false;
if (blck_debugLevel > 0) then {diag_log format["missionSpawner:: (234) preparing to spawn emplaced weapons for _markerClass %3:: blck_useStatic = %1 and _noEmplacedWeapons = %2",blck_useStatic,_noEmplacedWeapons,_markerClass];};
if (blck_useStatic && (_noEmplacedWeapons > 0)) then
{
	_temp = [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	if  (blck_debugLevel > 2) then 
	{
		diag_log format ["missionSpawner:: (232) blck_fnc_spawnEmplacedWeaponArray returned _temp = %1",_temp]; 
	};
	if (typeName _temp isEqualTo "ARRAY") then
	{
		_abort = _temp select 2;
	};
	if  (blck_debugLevel > 2) then 
	{
		diag_log format ["missionSpawner:: (241) _abort = %1",_abort]; 

	};
	if !(_abort) then
	{
		_objects append (_temp select 0);
		_blck_AllMissionAI append (_temp select 1);
		if (blck_debugLevel > 0) then
		{
			diag_log format["[blckeagls] missionSpawner:: (253) Static Weapons Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
		};	
	};
};
if (_abort) exitWith 
{
	if (blck_debugLevel > 2) then 
	{
		diag_log "missionSpawner:: (261) grpNull ERROR in blck_fnc_spawnEmplacedWeaponArray, mission termination criteria met, calling blck_endMission";
	};
	[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,true] call blck_fnc_endMission;
};

if (_allowReinforcements) then
{
	_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout;
	temp = [];
	diag_log format["[blckeagls] missionSpawner:: (268) calling in reinforcements: Current mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	//params["_coords","_aiSkillsLevel","_weapons","_uniforms","_headgear"];
	_temp = [_coords,_aiDifficultyLevel,_weaponList,_uniforms,_headGear] call blck_fnc_spawnMissionReinforcements;
	if (blck_debugLevel > 2) then
	{
		diag_log format["missionSpawner:: _temp = %1",_temp];
	};
	if (typeName _temp isEqualTo "ARRAY") then
	{
		_abort = _temp select 2;
		_objects pushback (_temp select 0);
		_blck_AllMissionAI append (_temp select 1);
	};
	if (_abort) then
	{
		if (blck_debugLevel > 2) then 
		{
			diag_log "missionSpawner:: (276) grpNul or ERROR in blck_fnc_spawnMissionReinforcements, mission termination criteria met, calling blck_endMission";
		};
		[_mines,_objects,_crates, _blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,true] call blck_fnc_endMission;
	};
};
// Trigger for mission end
//diag_log format["[blckeagls] mission Spawner _endCondition = %1",_endCondition];
private["_missionComplete","_endIfPlayerNear","_endIfAIKilled"];
_missionComplete = -1;
_startTime = diag_tickTime;

switch (_endCondition) do
{
	case "playerNear": {_endIfPlayerNear = true;_endIfAIKilled = false;};
	case "allUnitsKilled": {_endIfPlayerNear = false;_endIfAIKilled = true;};
	case "allKilledOrPlayerNear": {_endIfPlayerNear = true;_endIfAIKilled = true;};
};
//diag_log format["missionSpawner :: (269) _endIfPlayerNear = %1 _endIfAIKilled= %2",_endIfPlayerNear,_endIfAIKilled];
private["_locations"];
_locations = [_coords] + _crates;

//diag_log format["missionSpawner:: Waiting for player to satisfy mission end criteria of _endIfPlayerNear %1 with _endIfAIKilled %2",_endIfPlayerNear,_endIfAIKilled];
while {_missionComplete  isEqualTo -1} do
{
	if (blck_debugLevel isEqualTo 3) exitWith {uiSleep 300};
	if ((_endIfPlayerNear) && [_coords,10,true] call blck_fnc_playerInRange) exitWith {};
	if ((_endIfAIKilled) && [_blck_AllMissionAI] call blck_fnc_missionAIareDead ) exitWith {};
	//diag_log format["missionSpawner:: (283) missionCompleteLoop - > players near = %1 and ai alive = %2",[_coords,20] call blck_fnc_playerInRange, {alive _x} count _blck_AllMissionAI];
	uiSleep 2;
};

if (blck_debugLevel > 1) then
{
	diag_log format["[blckeagls] missionSpawner:: (288) Mission completion criteria fulfilled: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};
{
	// Using a variable attached to the crate rather than the global setting to be sure we do not fill a crate twice.
	// the "lootLoaded" loaded should be set to true by the crate filler script so we can use that for our check.
	if !(_x getVariable["lootLoaded",false]) then
	{
		// _crateLoot,_lootCounts are defined above and carry the loot table to be used and the number of items of each category to load
		[_x,_crateLoot,_lootCounts] call blck_fnc_fillBoxes;
	};
}forEach _crates;
[_mines,_objects,_crates,_blck_AllMissionAI,_endMsg,_blck_localMissionMarker,_coords,_mission,false] call blck_fnc_endMission;
diag_log format["[blckeagls] missionSpawner:: (292)end of mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];

