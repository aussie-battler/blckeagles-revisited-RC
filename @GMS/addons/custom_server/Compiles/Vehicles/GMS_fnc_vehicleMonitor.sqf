/*
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_vehList","_veh","_isEmplaced","_ownerIsPlayer","_allCrewDead","_deleteNow","_evaluate"];
_vehList = +blck_monitoredVehicles;

#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 and blck_monitoredVehicles %3",diag_tickTime,_vehList,blck_monitoredVehicles];};
#endif
//diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 ",diag_tickTime,_vehList,blck_monitoredVehicles];

{
	/*
		Determine state of vehicle
		_isEmplaced
		_ownerIsPlayer
		_allCrewDead

		_handleReloadRefuel (0)
		_scheduleDeletion (2) [_allCrewDead && !_isEmplaced && !_scheduled] // all vehicles other than statics
		_disableNow and schedule for deletion (1) [_allCrewDead && _isEmplaced] // emplaced weapons
		_deleteNow (3)
		_releaseToPlayer (4) [_allCrewDead && !_isEmplaced && _ownerIsPlayer]
		_default (5) reload rearm
	*/

	if (true) then
	{
		private["_veh","_isEmplaced","_ownerIsPlayer","_allCrewDead","_deleteNow","_evaluate"];
		_veh = _x; // (purely for clarity at this point, _x could be used just as well)
		
		_isEmplaced = _veh getVariable["GRG_vehType","none"] isEqualTo "emplaced";
		_ownerIsPlayer = if (owner _veh > 2 && !(owner _veh in blck_connectedHCs)) then {true} else {false};
		_allCrewDead = if (({alive _x} count (crew _veh)) == 0) then {true} else {false};
		_evaluate = 0;
		if (_allCrewDead && _isEmplaced && (_veh getVariable["blck_deleteAt",0] == 0)) then {_evaluate = 1};		
		if (_allCrewDead && !(_isEmplaced) && (_veh getVariable["blck_deleteAt",0] == 0)) then {_evaluate = 2};
		if ((_veh getVariable["blck_deleteAt",0] > 0) && (diag_tickTime > (_veh getVariable["blck_deleteAt",0]))) then {_evaluate = 3};
		if (/*_ownerIsPlayer*/  (owner _veh > 2) && !(owner _veh in blck_connectedHCs)) then {_evaluate = 4};
		//diag_log format["_fnc_vehicleMonitor: vehicle = %1 | owner = %2 | crew = %2",_veh, owner _veh, {alive _x} count (crew _veh)];
		switch (_evaluate) do
		{
			case 0:{[_veh] call blck_fnc_reloadVehicleAmmo;};
			case 1:{
				if (blck_killEmptyStaticWeapons) then
				{
					#ifdef blck_debugMode
					if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
					#endif
					_veh setDamage 1;
					_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
				}else {
					[_veh] call blck_fnc_releaseVehicleToPlayers;
				};
			};
			case 2:{
				if (blck_killEmptyAIVehicles) then
				{
					_veh setDamage 0.7;
					_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
				} else {
					[_veh] call blck_fnc_releaseVehicleToPlayers;
				};
			};
			case 3:{
				[_veh] call blck_fnc_destroyVehicleAndCrew;				
			};
			case 4:{
				_veh setVariable["blck_DeleteAt",nil];
				blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
			};
		};
	};
}forEach _vehList;



