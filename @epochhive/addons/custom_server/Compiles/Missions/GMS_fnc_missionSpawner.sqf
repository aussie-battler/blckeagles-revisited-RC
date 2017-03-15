/*
  Generic Mission Spawner
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 3/14/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Compiles\blck_defines.hpp";

private ["_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAIGroups","_blck_localMissionMarker","_AI_Vehicles","_timeOut","_aiDifficultyLevel"];
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

private["_chanceHeliPatrol","_noPara","_reinforcementLootCounts","_chanceLoot","_heliCrew","_loadCratesTiming"];

if (isNil "_markerColor") then {_markerColor = "ColorBlack"};
if (isNil "_markerType") then {_markerType = ["mil_box",[]]};
if (isNil "_timeOut") then {_timeOut = -1;};
if (isNil "_loadCratesTiming") then {_loadCratesTiming = blck_loadCratesTiming}; // valid choices are "atMissionCompletion" and "atMissionSpawn"; 

if (isNil "_chanceReinforcements") then
{
	_chanceReinforcements = 0;
	_noPara = 0;
	_reinforcementLootCounts = [0,0,0,0,0,0];
	_chanceHeliPatrol = 0;
	_chanceLoot = 0;
};																				// Set this value in your mission template if you would like to overide the default here.
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

private["_useMines","_abortMissionSpawner","_blck_AllMissionAIGroups","_delayTime","_groupPatrolRadius"];
if (isNil "_useMines") then {_useMines = blck_useMines;};

_objects = [];
_mines = [];
_crates = [];
_aiGroup = [];
_missionAIVehicles = [];
_blck_AllMissionAIGroups = [];
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
	diag_log format["[blckeagls] missionSpawner:: (131) Crates Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
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
	diag_log format["[blckeagls] missionSpawner:: (166) Landscape spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};

uiSleep _delayTime;;

[_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;

uiSleep _delayTime;
private ["_infantryGroups"];
_infantryGroups = [_coords, _minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;
//diag_log format["missionSpawner:: (201) -> _infantry = %1",_infantry];

_blck_AllMissionAIGroups append _infantryGroups;


uiSleep _delayTime;
if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: (210) AI Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
};

uisleep _delayTime;
if (blck_useVehiclePatrols && (_noVehiclePatrols > 0)) then
{
	private["_veh"];
	_veh = [_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear,_markerClass] call blck_fnc_spawnMissionVehiclePatrols;
	//diag_log format["missionSpawner :: (219) _veh = %1",_veh];
	_objects append (_veh select 0);
	_blck_AllMissionAIGroups append (_veh select 1);
	if (blck_debugLevel > 0) then
	{
		diag_log format["[blckeagls] missionSpawner:: (225) Vehicle Patrols Spawned: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
};

uiSleep _delayTime;
private ["_temp"];
if (blck_debugLevel > 0) then {diag_log format["missionSpawner:: (213) preparing to spawn emplaced weapons for _markerClass %3:: blck_useStatic = %1 and _noEmplacedWeapons = %2",blck_useStatic,_noEmplacedWeapons,_markerClass];};
if (blck_useStatic && (_noEmplacedWeapons > 0)) then
{
	_temp = [_missionEmplacedWeapons,_noEmplacedWeapons,_aiDifficultyLevel,_coords,_uniforms,_headGear] call blck_fnc_spawnEmplacedWeaponArray;
	//diag_log format ["missionSpawner:: (246) value returned for _temp = %1",_temp];
	_objects append (_temp select 0);
	_blck_AllMissionAIGroups append (_temp select 1);
};

if (blck_enableReinforcements && (random(1) < _chanceReinforcements)) then
{
	_weaponList = [_aiDifficultyLevel] call blck_fnc_selectAILoadout;
	if (blck_debugLevel > 0) then
	{
		diag_log format["[blckeagls] missionSpawner:: calling in reinforcements: Current mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];
	};
};

blck_monitoredMissionAIGroups append _blck_AllMissionAIGroups;  // so that we can monitor the status of the groups in the missions.

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
	if ((_endIfAIKilled) && [_blck_AllMissionAIGroups] call blck_fnc_missionAIareDead ) exitWith {};
	//diag_log format["missionSpawner:: (283) missionCompleteLoop - > players near = %1 and ai alive = %2",[_coords,20] call blck_fnc_playerInRange, {alive _x} count _blck_AllMissionAIGroups];
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
[_mines,_objects,_blck_AllMissionAIGroups,_endMsg,_blck_localMissionMarker,_coords,_mission] call blck_fnc_endMission;
diag_log format["[blckeagls] missionSpawner:: (292)end of mission: _cords %1 : _markerClass %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_markerClass,_aiDifficultyLevel,_markerMissionName];

