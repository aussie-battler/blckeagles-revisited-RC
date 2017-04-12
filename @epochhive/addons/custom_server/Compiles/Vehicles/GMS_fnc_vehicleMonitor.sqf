/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle when appropriate
	or otherwise destroys the vehicle.
	
	Logic:
	1) Mission ended; players can keep vehicles BUT not all vehicle AI were killed - > delete vehicle when live AI are killed;
	2) Vehicle has a blck_deleteAT timer set - > delete vehicle;
	3) All AI killed an players may NOT keep vehicles - > detroy vehicle
	4) All AI Killed and players MAY keep vehicles -> release vehicle
	5) vehicle ammo low AND vehicle gunner is alive - > reloaded

	By Ghostrider-DBD-
	Copyright 2016
	Last updated 1-22-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

_fn_removeVehicleFromVehicleMonitoring = {
	params["_veh"];
	blck_missionVehicles = blck_missionVehicles - [_veh];
};

_fn_releaseVehicle = {
	params["_v"];
	//diag_log format["vehicleMonitor.sqf: make vehicle available to players; stripping eventHandlers from _v %1",_v];	
	[_v] call _fn_removeVehicleFromVehicleMonitoring;
	_v setVehicleLock "UNLOCKED" ;
	//_v setVariable["releasedToPlayers",true];
	[_v] call blck_fnc_emptyObject;
	{
		_v removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_v];
	};
	#endif
};

_fn_deleteAIvehicle = {
	params["_veh"];
	{
		_veh removeAllEventHandlers _x;
	}forEach ["Hit","HitPart","GetIn","GetOut","Fired","FiredNear"];
	[_veh] call _fn_removeVehicleFromVehicleMonitoring;			
	deleteVehicle _veh;
};

_fn_destroyVehicleAndCrew = {
	params["_veh"];
	private["_crew"];
	_crew = crew _veh;
	{[_x] call blck_fnc_deleteAI;} forEach _crew;
	[_veh] call _fn_deleteAIvehicle;
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

private ["_veh","_vehList"];
_vehList = blck_missionVehicles;

#ifdef blck_debugMode
if (blck_debugLevel > 1) then {diag_log format["_fnc_vehicleMonitor:: function called at %1",diag_tickTime];};
#endif

{
	_veh = _x; // (purely for clarity at this point, _x could be used just as well)
	private["_evaluate"];
	_evaluate = true;
	// Case where vehicle has been marked for deletion after a certain time.
	if ( (_veh getVariable["blck_DeleteAt",0] > 0) && (diag_tickTime > _veh getVariable "blck_DeleteAt")) then
	{
		[_veh] call _fn_destroyVehicleAndCrew;
		_evaluate = false;
	};

	// Case where is an emplaced / static wweapon and has no alive crew and such vehicles should be 'killed' or release to players
	if (_evaluate) then
	{
		if ( (_veh getVariable["DBD_vehType","none"] isEqualTo "emplaced") && {alive _x} count crew _veh isEqualTo 0) then
		{
			if (blck_killEmptyStaticWeapons) then
			{
				#ifdef blck_debugMode
				if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
				#endif

				_veh setDamage 1;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			}else {
				[_veh] call _fn_releaseVehicle;
			};
			_evaluate = false;
		};
	};

	// Case where a vehicle is NOT an emplaced / static weapon and has no alive crew and such vehicles should be 'killed' or release to players
	if (_evaluate) then
	{
		if (_veh getVariable["DBD_vehType","none"] isEqualTo "none" && ({alive _x} count crew _veh isEqualTo 0) ) then
		{
			if (blck_killEmptyAIVehicles) then
			{
				_veh setDamage 0.7;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				[_veh] call _fn_releaseVehicle;
			};
			_evaluate = false;
		};
	};

	// Case where a vehicle is part of a mission that has been completed and containes live AI.
	if (_evaluate) then
	{
		if ( _veh getVariable["missionCompleted",0] > 0 && ({alive _x} count crew _veh > 0)) then
		{
			private["_cleanupTimer"];
			_cleanupTimer = _veh getVariable["cleanupTimer",0];  // The time delat to deleting any alive AI units
			//  "missionCompleted" = the time at which the mission was completed or aborted
			if (diag_tickTime > (_cleanupTimer + (_veh getVariable["missionCompleted",0])) ) then 
			{
				[_veh] call _fn_destroyVehicleAndCrew;
				_evaluate = false;
			};
		};
	};

	if (_evaluate) then
	{
		[_veh] call _fn_reloadAmmo;
	};
}forEach _vehList;



