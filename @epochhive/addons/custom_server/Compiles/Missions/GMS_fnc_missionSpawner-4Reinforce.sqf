/*
  Generic Mission Spawner
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last modified 1/12/17
*/

private ["_crates","_aiGroup","_objects","_groupPatrolRadius","_missionLandscape","_mines","_blck_AllMissionAI","_blck_localMissionMarker","_AI_Vehicles"];
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

private["_timeOut","_blck_AllMissionAI"]; // _timeOut is the time in seconds after which a mission is deactivated.
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
_abortMissionSpawner = false;

[_blck_localMissionMarker select 0,"Active",_coords] call blck_fnc_updateMissionQue;

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
blck_missionSpawning = false;
if (blck_debugLevel > 0) then {diag_log "missionSpawner:: waiting for player to trigger the mission";};
private _missionStartTime = diag_tickTime;
waitUntil{[_coords,blck_TriggerDistance,blck_MissionTimout] call blck_fnc_missionStartConditionsMet;};
if (((diag_tickTime - _missionStartTime) > blck_MissionTimout)) exitWith
{
	//["timeOut",_endMsg,_blck_localMissionMarker select 2] call blck_fnc_messageplayers;
	[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
	[_objects, 1] spawn blck_fnc_cleanupObjects;
	[_blck_localMissionMarker select 0,"Completed"] call blck_fnc_updateMissionQue;
	if (blck_debugLevel > 0) then
	{
		diag_log format["[blckeagls] missionSpawner:: Mission Timed Out: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
	};
};


if (blck_debugLevel > 0) then
{		diag_log format["[blckeagls] missionSpawner:: --  >>  Mission tripped by nearby player: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};

if (count _missionLootBoxes > 0) then
{
	_crates = [_coords,_missionLootBoxes] call blck_fnc_spawnMissionCrates;
}
else
{
	_crates = [_coords,[[selectRandom blck_crateTypes /*"Box_NATO_Wps_F"*/,[0,0,0],_crateLoot,_lootCounts]]] call blck_fnc_spawnMissionCrates;
	
};

if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: Crates Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};

uiSleep _delayTime;
private ["_temp"];
if (blck_SmokeAtMissions select 0) then  // spawn a fire and smoke near the crate
{
	
	_temp = [_coords,blck_SmokeAtMissions select 1] call blck_fnc_smokeAtCrates;
	_objects append _temp;
};
uiSleep _delayTime;
if (_useMines) then
{
	_mines = [_coords] call blck_fnc_spawnMines;
	uiSleep _delayTime;;
};

if (_missionLandscapeMode isEqualTo "random") then
{
	_temp = [_coords,_missionLandscape, 3, 15, 2] call blck_fnc_spawnRandomLandscape;
} else {
	_temp = [_coords, floor(random(360)),_missionLandscape,true] call blck_fnc_spawnCompositionObjects;
};
_objects append _temp;
diag_log format["_fnc_missionSpawner::->> mission objects spawned = %1",_objects];

if (blck_debugON) then
{
	diag_log format["[blckeagls] missionSpawner:: Landscape spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};

uiSleep _delayTime;;

if ((count _missionLootVehicles) > 0) then  // spawn loot vehicles
{
	diag_log "[blckEagles] _fnc_missionSpawner:: Spawning Mission Loot Vehicles";
	private _vehs = [_missionLootVehicles] call blck_fnc_spawnMissionLootVehicles;
};

uiSleep _delayTime;
diag_log "[blckEagle] _fnc_missionSpawner:: spawning AI";
_blck_AllMissionAI = [_coords,_minNoAI,_maxNoAI,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionAI;
diag_log format["[blckeagls] _fnc_missionSpawner (190):-> _blck_AllMissionAI = %1",_blck_AllMissionAI];
if (blck_debugON) then
{
	diag_log format["[blckeagls] missionSpawner:: AI Patrols Spawned: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};

uiSleep _delayTime;
private _emp = [];
diag_log format["[blckeagls] _fnc_missionSpawner (197):-> _noEmplacedWeapons = %1",_noEmplacedWeapons];
if (!blck_useStatic && (_noEmplacedWeapons > 0)) then
{
	private ["_emplacedGroup","_emplacedPositions"];

	_emplacedPositions = [_coords,_count,35,50] call blck_fnc_findPositionsAlongARadius;
	//diag_log format["missionSpawner:: _emplacedPositions = %1",_emplacedPositions];
	{
		_emplacedGroup = [_x,1,1,_aiDifficultyLevel,_coords,1,2,_uniforms,_headGear] call blck_fnc_spawnGroup;
		if !(isNull _emplacedGroup) then
		{
			_blck_AllMissionAI = _blck_AllMissionAI + (units _emplacedGroup);
			_emplacedWeapon = [_x,_emplacedGroup,blck_staticWeapons,5,15] call  blck_fnc_spawnEmplacedWeapon;
			_missionAIVehicles pushback _emplacedWeapon;
			uiSleep _delayTime;
		};
	}forEach _emplacedPositions;
};
if (blck_debugLevel > 0) then {diag_log format["[blckeagls] _fnc_missionSpawner (208):-> _blck_AllMissionAI = %1",_blck_AllMissionAI];};
uiSleep _delayTime;	
if (blck_useVehiclePatrols && (_noVehiclePatrols > 0)) then
{
	diag_log "[blckEagles] _fnc_missionSpawner:: spawning patrol vehicles";
	private _return = [_coords,_noVehiclePatrols,_aiDifficultyLevel,_uniforms,_headGear] call blck_fnc_spawnMissionVehiclePatrols;
	if (count _return isEqualTo 2) then
	{
		_blck_AllMissionAI =  _blck_AllMissionAI + (_return select 0);
		_AI_Vehicles = _AI_Vehicles + (_return select 1);
	};
};	

if ((random(1) < _chanceReinforcements)) then
{
	diag_log format["[blckeagls] missionSpawner:: calling in reinforcements: _heliCrew = %1",4];
	private["_grpPilot","_supplyHeli"];
	_grpPilot = createGroup blck_AI_Side;
	_grpPara = createGroup blck_AI_Side;
	if (!(isNulL _grpPilot) && !(isNull _grpPara)) then
	{
		//_supplyHeli = [_coords,_grpPilot,_chanceLoot] call blck_fnc_spawnMissionHeli;
		//[_coords,_grpPara,_noPara,_aiDifficultyLevel,_chanceLoot,_reinforcementLootCounts,_uniforms,_headgear,_supplyHeli,_grpPilot] spawn blck_fnc_callInReinforcements;
	} else { deleteGroup _grpPilot; deleteGroup _grpPara;};
};

if (blck_debugON) then {diag_log "[blckeagls] _fnc_missionSpawner (214) :: waiting for mission completion criterion to be met";
waitUntil{[_crates,_blck_AllMissionAI,_endCondition] call blck_fnc_missionEndConditionsMet;};
if (blck_debugLevel > 0) then
{
	diag_log format["[blckeagls] missionSpawner:: Mission completion criteria fulfilled: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
};

if (blck_useSignalEnd) then
{
	[_crates select 0] spawn blck_fnc_signalEnd;
};
[_mines] spawn blck_fnc_clearMines;
[_objects, blck_cleanupCompositionTimer] call blck_fnc_addObjToQue;
[_blck_AllMissionAI,blck_AliveAICleanUpTime] call blck_fnc_addLiveAItoQue;
[["end",_endMsg,_blck_localMissionMarker select 2]] call blck_fnc_messageplayers;
[_blck_localMissionMarker select 1, _missionType] execVM "debug\missionCompleteMarker.sqf";
[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
[_blck_localMissionMarker select 0,"Completed"] call blck_fnc_updateMissionQue;
diag_log format["[blckeagls] missionSpawner:: end of mission: _cords %1 : _missionType %2 :  _aiDifficultyLevel %3 _markerMissionName %4",_coords,_missionType,_aiDifficultyLevel,_markerMissionName];
