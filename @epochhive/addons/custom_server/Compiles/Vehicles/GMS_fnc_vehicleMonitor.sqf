/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle when appropriate
	or otherwise destroys the vehicle.
	
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 1-13-17
*/

private ["_veh","_vehList"];
_vehList = blck_missionVehicles;
//diag_log format["_fnc_vehicleMonitor:: function called with blck_missionVehicles = %1",_vehList];
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
		if (_veh getVariable["DBD_vehType","none"] isEqualTo "emplaced") then
		{
			if (blck_debugOn) then
			{
				diag_log format["_fnc_vehicleMonitor:: case of destroyed where vehicle = %1",_veh];
			};
			_veh setDamage 1;
			_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
		}else {
			if (blck_killEmptyAIVehicles) then
			{
				if (blck_debugOn) then
				{
					diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle destroyed where vehicle = %1",_veh];
				};			
				{
					_veh setHitPointDamage [_x, 1];
					
				} forEach ["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitEngine","HitLBWheel","HitLMWheel","HitRBWheel","HitRMWheel","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun"];
				_veh setVariable["blck_DeleteAt",diag_tickTime + 60];
			} else {
				//diag_log format["vehicleMonitor.sqf: make vehicle available to players; stripping eventHandlers from_veh %1",_veh];	
				blck_missionVehicles = blck_missionVehicles - [_veh];
				_veh removealleventhandlers "GetIn";
				_veh removealleventhandlers "GetOut";
				_veh setVehicleLock "UNLOCKED" ;
				if (blck_debugOn) then
				{
					diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_veh];
				};
			};
		};
	} else {
		_veh setVehicleAmmo 1;
		_veh setFuel 1;
	};
}forEach _vehList;



