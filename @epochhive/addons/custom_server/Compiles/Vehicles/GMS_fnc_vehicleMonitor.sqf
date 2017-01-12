/*
	Handle the case that all AI assigned to a vehicle are dead.
	Allows players to enter and use the vehicle when appropriate
	or otherwise destroys the vehicle.
	
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 1-17-17
*/

private _vehList = blck_missionVehicles;
{
	private ["_veh"];
	_veh = _x;
	if ({alive _x} count crew _veh < 1) then
	{
		if (_veh getVariable["DBD_vehType","none"] isEqualTo "emplaced") then
		{
			[_veh] spawn {uiSleep 1;(_this select 0) setDamage 1;};
			blck_missionVehicles = blck_missionVehicles - [_veh];
			if (blck_debugOn) then{
				diag_log format["_fnc_vehicleMonitor:: deleting emplaced weapon %1",_veh];
			};
		}else {
			if (blck_killEmptyAIVehicles) then
			{
				blck_missionVehicles = blck_missionVehicles - [_veh];
				[_veh] spawn {
					params["_v"];
					//diag_log format["vehicleMonitor.sqf:: case of patrol vehicle: _veh %1 is about to be killed with getAllHitPointsDamage = %2",_v, (getAllHitPointsDamage _v)];
					uiSleep 20;
					{
						_v setHitPointDamage [_x, 1];
						//diag_log format["vehicleMonitor: hitpart %1 for vehicle %1 set to 1",_x,_v];
					} forEach ["HitLFWheel","HitLF2Wheel","HitRFWheel","HitRF2Wheel","HitEngine","HitLBWheel","HitLMWheel","HitRBWheel","HitRMWheel","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun","HitTurret","HitGun"];
					if (blck_debugLevel isEqualTo 3) then
					{
						diag_log format["_fnc_vehicleMonitor:: damage applied to a patrol vehicle -- >> current damage for vehicle %1 is = %2",_v, (getAllHitPointsDamage _v)];
					};
					[_v] spawn {  // spawn this so we don't hold up the rest the evaluations and cleanup needed.
						private _v = _this select 0;
						uiSleep 60;
						if (blck_debugOn) then {
							diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle:deleting vehicle _veh",_v];
						};
						deleteVehicle _v;
					};
				};
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
