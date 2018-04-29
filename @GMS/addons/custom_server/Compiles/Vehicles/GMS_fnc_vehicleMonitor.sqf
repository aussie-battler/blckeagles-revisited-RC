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

//diag_log format["_fnc_vehicleMonitor: starting function at diag_tickTime = %1",diag_tickTime];

#ifdef blck_debugMode
	//diag_log format["_fnc_vehicleMonitor:: blck_debugMode defined"];
#endif

private ["_vehList","_veh","_isEmplaced","_ownerIsPlayer","_allCrewDead","_deleteNow","_missionCompleted","_evaluate","_cleanupTimer"];
_vehList = +blck_monitoredVehicles;

#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 and blck_monitoredVehicles %3",diag_tickTime,_vehList,blck_monitoredVehicles];};
#endif
diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 and blck_monitoredVehicles %3",diag_tickTime,_vehList,blck_monitoredVehicles];
{
	/*
		Determine state of vehicle
		_isEmplaced
		_ownerIsPlayer
		_allCrewDead
		_deleteNow
	*/
	//diag_log format["_fnc_vehicleMonitor: evaluating vehicle %1",_x];
	_veh = _x; // (purely for clarity at this point, _x could be used just as well)
	_isEmplaced = _veh getVariable["GRG_vehType","none"] isEqualTo "emplaced";
	_ownerIsPlayer = if (owner _veh > 2 && !(owner _veh in blck_connectedHCs)) then {true} else {false};
	_allCrewDead = if (({alive _x} count (crew _veh)) == 0) then {true} else {false};
	//diag_log format["_fnc_vehicleMonitor: _allCrewDead = %1",_allCrewDead];
	_deletenow = false;
	if ( (_veh getVariable["blck_DeleteAt",0] > 0) && (diag_tickTime > (_veh getVariable "blck_DeleteAt"))) then {_deleteNow = true};
	_missionCompleted = if (_veh getVariable["missionCompleted",0] != 0) then {true} else {false};
	_evaluate = true;

	if (_ownerIsPlayer) then
	{
		// disable further monitoring and mark to never be deleted.
		_evaluate = false;
		_veh setVariable["blck_DeleteAt",0];
		blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
		//diag_log format["_fnc_vehicleMonitor: vehicle %1 now owned by player %2",_veh, owner _veh];	
	};
	
	if (_allCrewDead && _evaluate) then
	{
		if (_isEmplaced) then
		{
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
			_evaluate = false;		
		} else {
			if (blck_killEmptyAIVehicles) then
			{
				_veh setDamage 0.7;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				//diag_log format["_fnc_vehicleMonitor:: case of RELEASE where vehicle = %1 and Vehicle is typeOf %2",_veh, typeOf _veh];
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
			_evaluate = false;		
		};
	};
	
	if (_missionCompleted && !(_allCrewDead)) then
	{
		//diag_log format["_fnc_vehicleMonitor:: case of mission vehicle with AI alive at mission end: schedule destruction with _veh = %1 and typeOf _veh = %2",_veh, typeOf _veh];
		_cleanupTimer = _veh getVariable["blck_DeleteAt",0];  // The time delete to deleting any alive AI units
		if (_cleanupTimer == 0) then {_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer]};
		_evaluate = false;
	};
	
	if (_evaluate) then
	{
		[_veh] call blck_fnc_reloadVehicleAmmo;
	};	
	
	if (_deleteNow) then
	{
		[_veh] call blck_fnc_destroyVehicleAndCrew;
		_evaluate = false;	
	};
	
}forEach _vehList;



