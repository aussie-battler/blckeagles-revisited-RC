
/*
blck_fnc_HC_XferGroup = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_XferGroup.sqf"; 
//blck_fnc_HC_XferVehicle = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_XferVehicle.sqf";
blck_fnc_onPlayerDisconnected = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_onPlayerDisconnected.sqf";
//blck_fnc_HC_groupsAssigned = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_groupsAssigned.sqf";
blck_fnc_HCmonitor = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HCmonitor.sqf";
blck_fnc_HC_vehicleMonitor = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_vehicleMonitor.sqf";
blck_fnc_monitorHC = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_monitorHC.sqf";
blck_fnc_passToHCs = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_passToHCs.sqf";
blck_fnc_HC_getListConnected = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_getListConnected.sqf";
blck_fnc_HC_leastBurdened = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_leastBurdened.sqf";
blck_fnc_HC_countGroupsAssigned = compileFinal preprocessFileLineNumbers "\q\addons\custom_server\Compiles\HC\GMS_fnc_HC_countGroupsAssigned.sqf";

*/
//blck_fnc_HC_leastBurdened = 

params["_HC_List"];
private["_result","_fewestGroupsAssigned","_leastBurdened","_groupsAssigned"];
if (count _HC_List == 0) exitWith {_result = objNull; _result};
_fewestGroupsAssigned = [_HC_List select 0] call blck_fnc_HC_countGroupsAssigned;
_leastBurdened = _HC_List select 0;
{
	_groupsAssigned = [_x] call blck_fnc_HC_countGroupsAssigned;
	if (_groupsAssigned < _fewestGroupsAssigned) then 
	{
		_leastBurdened = _x;
		_fewestGroupsAssigned = _groupsAssigned;
	};
}forEach _HC_List;
//diag_log format["_fnc_leastBurdened:: _fewestGroupsAssigned = %1 and _leastBurdened = %2",_fewestGroupsAssigned,_leastBurdened];
_leastBurdened
