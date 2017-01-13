/*

*/
params["_objects","_mines","_crates","_blck_AllMissionAI","_AI_Vehicles","_blck_localMissionMarker"];
// discard everything
{deleteVehicle _x} forEach _objects;
{deleteVehicle _x} forEach _mines;
{deleteVehicle _x} forEach _crates;
{deleteVehicle _x} forEach _blck_AllMissionAI;
{deleteVehicle _x} forEach _AI_Vehicles;
// set the mission status to waiting
[_blck_localMissionMarker select 0,"Completed"] call blck_fnc_updateMissionQue;
uiSleep 1;
// delete any empty groups left over from the cleanup.
[] call blck_fnc_cleanEmptyGroups;