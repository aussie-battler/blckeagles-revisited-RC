
params["_pos"];

if (!isServer) exitWith{};
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_mission"];
// Spawn landscape
// params["_objects"];
if (isNil "_markerColor") then {_markerColor = "ColorBlack"};
if (isNil "_markerType") then {_markerType = ["mil_box",[]]};
_markerClass = format["static%1",floor(random(1000000))];
_blck_localMissionMarker = [_markerClass,_missionCenter,"","",_markerColor,_markerType];
if (blck_labelMapMarkers select 0) then
{
	_blck_localMissionMarker set [2, _markerMissionName];
};
if !(blck_preciseMapMarkers) then
{
	_blck_localMissionMarker set [1,[_coords,75] call blck_fnc_randomPosition];
};
_blck_localMissionMarker set [3,blck_labelMapMarkers select 1];  // Use an arrow labeled with the mission name?
[_blck_localMissionMarker] call blck_fnc_spawnMarker;

[_missionLandscape] call blck_fnc_sm_spawnObjects;

{
	[_x] call blck_fnc_sm_AddAircraft; 
	
}forEach _airPatrols;
//uiSleep 1;

{
	[_x] call blck_fnc_sm_AddScubaGroup;
}forEach _aiGroupParameters;

{
	[_x] call blck_fnc_sm_AddEmplaced;
}forEach _missionEmplacedWeapons;

{
	[_x] call blck_fnc_sm_AddSurfaceVehicle;
}forEach _vehiclePatrolParameters;

{
	[_x] call blck_fnc_sm_AddSDVVehicle;
} forEach _submarinePatrolParameters;

uiSleep 30;
// spawn loot chests
[_missionLootBoxes,_missionCenter,_crateLoot,_lootCounts] call blck_fnc_sm_spawnLootContainers;

diag_log format["[blckeagls] UMS Mission Spawner: Static UMS Mission %1 spawned",_mission];