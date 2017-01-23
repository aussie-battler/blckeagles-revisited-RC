/*
	Spawn a vehicle and protect it against cleanup by Epoch
	Returns the object (vehicle) created.
	By Ghostrider-DBD-
	Last modified 1-22-17
*/

private["_veh","_modType"];
params["_vehType","_pos",["_clearInventory",true]];
//_vehType = _this select 0;  // type of vehicle to be spawned
//_pos = _this select 1;  // position at which vehicle is to be spawned
	
if (blck_debugLevel > 2) then {diag_log format["spawnVehicle.sqf:   _this = %1",_this];};
_veh = createVehicle[_vehType, _pos, [], 0, "NONE"];
_modType = call blck_fnc_getModType;
if (_modType isEqualTo "Epoch") then
{
	//_veh call EPOCH_server_vehicleInit;
	_veh call EPOCH_server_setVToken;
	diag_log format["_fnc_spawnVehicle:: (20) EPOCH_server_setVToken performed for vehicle %1",_veh];
};
//  params["_veh",["_clearInventory",true]];
[_veh,_clearInventory] call blck_fnc_configureMissionVehicle;
diag_log format["spawnVehicle:: returning parameter _veh = %1",_veh];
_veh
	
