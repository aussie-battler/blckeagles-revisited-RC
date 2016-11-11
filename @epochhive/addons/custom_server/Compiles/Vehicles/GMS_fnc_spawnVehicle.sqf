/*
	Spawn a vehicle and protect it against cleanup by Epoch
	Returns the object (vehicle) created.
	By Ghostrider-DBD-
	Last modified 10-24-16
*/

private["_veh","_modType"];
params["_vehType","_pos"];
//_vehType = _this select 0;  // type of vehicle to be spawned
//_pos = _this select 1;  // position at which vehicle is to be spawned
	
//diag_log format["spawnVehicle.sqf:   _this = %1",_this];
_veh = createVehicle[_vehType, _pos, [], 0, "NONE"];
_modType = call blck_getModType;
if (_modType isEqualTo "Epoch") then
{
	//_veh call EPOCH_server_vehicleInit;
	_veh call EPOCH_server_setVToken;
};
[_veh] call blck_fnc_configureMissionVehicle;

_veh
	
