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

diag_log format["_fnc_vehicleMonitor: starting function at diag_tickTime = %1",diag_tickTime];

if (true) exitWith {};

#ifdef blck_debugMode
	//diag_log format["_fnc_vehicleMonitor:: blck_debugMode defined"];
#endif

_fn_releaseVehicle = {
	params["_veh"];
	//blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
	_veh setVehicleLock "UNLOCKED" ;
	//_v setVariable["releasedToPlayers",true];
	//[_v] call blck_fnc_emptyObject;
	{
		_veh removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	{
		_veh removeAllMPEventHandlers _x;
	} forEach ["MPHit","MPKilled"];
	_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer,true];
	if ((damage _veh) > 0.5) then {_veh setDamage 0.5};
	//diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1 and blck_deleteAT = %2",_veh, _veh getVariable["blck_DeleteAt",0]];	
	#ifdef blck_debugMode
	if (blck_debugLevel > 0) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_veh];
	};
	#endif
};

_fn_destroyVehicleAndCrew = {
	params["_veh"];
	//private["_crew"];
	//_crew = crew _veh;
	diag_log format["_fn_destroyVehicleAndCrew: called for _veh = %1",_veh];
	{[_x] call blck_fnc_deleteAI;} forEach (crew _veh);
	[_veh] call blck_fn_deleteAIvehicle;
};

_fn_reloadAmmo = {
	params["_veh"];
	private ["_crew","_mag","_allMags","_cnt"];
	//  https://community.bistudio.com/wiki/fullCrew
	//							0				1			2					3				4
	// returns Array - format [[<Object>unit,<String>role,<Number>cargoIndex,<Array>turretPath,<Boolean>personTurret], ...] 
	//diag_log format["_fnc_vehicleMonitor:: (65) _veh = %1",_veh];
	if ({alive _x and !(isPlayer _x)} count (crew _veh) > 0) then
	{
		_crew = fullCrew _veh;
		//diag_log format["_fnc_vehicleMonitor:: (67) _crew = %1",_crew];
		{
			//diag_log format ["_fnc_vehicleMonitor:: (69) _x = %1",_x];
			_mag = _veh currentMagazineTurret (_x select 3);
			if (count _mag > 0) then
			{
				//diag_log format["_fnc_vehicleMonitor:: (71) _mag is typeName %1", typeName _mag];
				//diag_log format ["_fnc_vehicleMonitor:: (71) length _mag = %2 and _mag = %1",_mag,count _mag];	
				_allMags = magazinesAmmo _veh;
				//diag_log format["_fnc_vehicleMonitor:: (71) _allMags = %1",_allMags];			
				_cnt = ( {_mag isEqualTo (_x select 0)}count _allMags);
				//diag_log format["_fnc_vehicleMonitor:: (75) _cnt = %1",_cnt];
				if (_cnt < 2) then {_veh addMagazineCargo [_mag,2]};
			};
		} forEach _crew;
	};
};

blck_fn_deleteAIvehicle = {
	params["_veh"];
	diag_log format["blck_fn_deleteAIvehicle:  _veh %1 deleted",_veh];
	{
		_veh removeAllEventHandlers _x;
	}forEach ["Hit","HitPart","GetIn","GetOut","Fired","FiredNear","HandleDamage","Reloaded"];
	blck_monitoredVehicles = blck_monitoredVehicles - [_veh];			
	deleteVehicle _veh;
};

private _vehList = +blck_monitoredVehicles;

#ifdef blck_debugMode
if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: function called at %1 with _vehList %2 and blck_monitoredVehicles %3",diag_tickTime,_vehList,blck_monitoredVehicles];};
#endif
  //blck_fnc_releaseVehicleToPlayers
{
	/*
		Determine state of vehicle
		_isEmplaced
		_ownerIsPlayer
		_allCrewDead
		_deleteNow
	*/

	private _veh = _x; // (purely for clarity at this point, _x could be used just as well)
	private _isEmplaced = _veh getVariable["DBD_vehType","none"] isEqualTo "emplaced";
	private _ownerIsPlayer = if (owner _veh > 2 && !(owner _veh in blck_connectedHCs)) then {true} else {false};
	private _allCrewDead = {alive _x} count (crew _veh);
	private _deletenow = if ( (_veh getVariable["blck_DeleteAt",0] > 0) && (diag_tickTime > (_veh getVariable "blck_DeleteAt"))) then {true} else {false};
	private _missionCompleted = _veh getVariable["missionCompleted",0];
	private _evaluate = true;
	
	if (_ownerIsPlayer) then
	{
		// disable further monitoring and mark to never be deleted.
		_evaluate = false;
		_veh setVariable["blck_DeleteAt",0];
		blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
		diag_log format["_fnc_vehicleMonitor: vehicle %1 now owned by player %2",_veh, owner _veh];	
	};
	
	if (_allCrewDead && _evaluate) then
	{
		if (_isEmplaced) then
		{
			if (blck_killEmptyStaticWeapons) then
			{
				#ifdef blck_debugMode
				if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
				#endif
				_veh setDamage 1;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			}else {
				[_veh] call _fn_releaseVehicle;
			};
			_evaluate = false;		
		} else {
			if (blck_killEmptyAIVehicles) then
			{
				_veh setDamage 0.7;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				diag_log format["_fnc_vehicleMonitor:: case of RELEASE where vehicle = %1 and Vehicle is typeOf %2",_veh, typeOf _veh];
				[_veh] call _fn_releaseVehicle;
			};
			_evaluate = false;		
		};
	};
	
	if (_missionCompleted && !(_allCrewDead)) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of mission vehicle with AI alive at mission end: schedule destruction with _veh = %1 and typeOf _veh = %2",_veh, typeOf _veh];
		private _cleanupTimer = _veh getVariable["blck_DeleteAt",0];  // The time delete to deleting any alive AI units
		if (_cleanupTimer == 0) then {_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer]};
		_evaluate = false;
	};

	if (_evaluate) then
	{
		[_veh] call _fn_reloadAmmo;
	};	
	
	if (_deleteNow) then
	{
		[_veh] call _fn_destroyVehicleAndCrew;
		_evaluate = false;	
	};
}forEach _vehList;



