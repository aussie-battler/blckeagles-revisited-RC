/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle when appropriate
	or otherwise destroys the vehicle.
	
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 1-22-17
*/

private ["_veh","_vehList"];
_vehList = blck_missionVehicles;
/*
_fn_releaseVehicle = {
	params["_v"];
	//diag_log format["vehicleMonitor.sqf: make vehicle available to players; stripping eventHandlers from _v %1",_v];	
	blck_missionVehicles = blck_missionVehicles - [_v];
	_v removealleventhandlers "GetIn";
	_v removealleventhandlers "GetOut";
	_v setVehicleLock "UNLOCKED" ;
	_v setVariable["releasedToPlayers",true];
	[_v] call blck_fnc_emptyObject;
	{
		_v removealleventhandlers _x;
	}forEach["fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_v];
	};
};
*/
//if (blck_debugLevel > 1) then {diag_log format["_fnc_vehicleMonitor:: function called at %1",diag_tickTime];};
{
	_veh = _x;
	if (_veh getVariable["blck_DeleteAt",0] > 0) then
	{
		if (diag_tickTime > (_veh getVariable["blck_DeleteAt",0])) then 
		{
			[_veh] call blck_deleteVehicle;
			blck_missionVehicles = blck_missionVehicles - [_veh];
		};
	};
	if ({alive _x} count crew _veh < 1) then
	{
		if (_veh getVariable["DBD_vehType","none"] isEqualTo "emplaced") then  // Deal with a static weapon
		{
			if (blck_killEmptyStaticWeapons) then
			{
				//if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];};
				_veh setDamage 1;
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
		}else {  // Deal with vehicles
			if (blck_killEmptyAIVehicles) then
			{
				//if (blck_debugLevel > 2) then {diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle destroyed where vehicle = %1",_veh];};			
				{
					_veh setHitPointDamage [_x, 1];
					
				} forEach ["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitEngine","HitLBWheel","HitLMWheel","HitRBWheel","HitRMWheel","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun"];
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: case of release vehicle = %1 to player with blck_missionVehicles = %2",_veh, blck_missionVehicles];};	
				blck_missionVehicles = blck_missionVehicles - [_veh];
				if (blck_debugLevel > 0) then {diag_log format["_fnc_vehicleMonitor:: blck_missionVehicles updated to %1", blck_missionVehicles];};	
				[_veh] call blck_fnc_releaseVehicleToPlayers;
			};
		};
	} else {  // Add magazine to vehicle if possible
		private ["_crew","_mag","_allMags","_cnt"];
		//_veh setVehicleAmmo 1;
		//_veh setFuel 1;
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
}forEach _vehList;



