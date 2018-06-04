
/*
blck_fnc_HC_XferGroup = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_XferGroup.sqf"; 
//blck_fnc_HC_XferVehicle = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_XferVehicle.sqf";
blck_fnc_onPlayerDisconnected = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_onPlayerDisconnected.sqf";
//blck_fnc_HC_groupsAssigned = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_groupsAssigned.sqf";
blck_fnc_HC_monitor = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HCmonitor.sqf";
blck_fnc_HC_vehicleMonitor = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_vehicleMonitor.sqf";
blck_fnc_monitorHC = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_monitorHC.sqf";
blck_fnc_passToHCs = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_passToHCs.sqf";
blck_fnc_HC_getListConnected = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_getListConnected.sqf";
blck_fnc_HC_leastBurdened = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_leastBurdened.sqf";
blck_fnc_HC_countGroupsAssigned = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_countGroupsAssigned.sqf";

*/
//blck_fnc_HC_countGroupsAssigned = 

params["_HC"];
private["_result"];
_result = {(groupOwner _x) == (owner _HC)} count allGroups;
//diag_log format["_fnc_countGroupsAssigned = %1",_result];
_result
