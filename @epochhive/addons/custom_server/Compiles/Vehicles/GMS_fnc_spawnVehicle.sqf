/*
	Spawn a vehicle and protect it against cleanup by Epoch
	Returns the object (vehicle) created.
	By Ghostrider-DBD-
	Last modified 1-27-17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Compiles\blck_defines.hpp";

private["_veh","_modType"];
params["_vehType","_pos",["_clearInventory",true]];
//_vehType = _this select 0;  // type of vehicle to be spawned
//_pos = _this select 1;  // position at which vehicle is to be spawned
	
//if (blck_debugLevel > 2) then {diag_log format["spawnVehicle.sqf:   _this = %1",_this];};
_veh = createVehicle[_vehType, _pos, [], 0, "NONE"];
[_veh] call blck_fnc_protectVehicle;
//  params["_veh",["_clearInventory",true]];
[_veh,_clearInventory] call blck_fnc_configureMissionVehicle;
//if (blck_debugLevel > 2) then {diag_log format["spawnVehicle:: returning parameter _veh = %1",_veh];};
_veh
	
