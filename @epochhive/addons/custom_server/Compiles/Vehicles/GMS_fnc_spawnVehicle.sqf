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
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_veh","_modType"];
params["_vehType","_pos",["_clearInventory",true]];
if (blck_debugLevel > 2) then {diag_log format["spawnVehicle.sqf:  _vehType = %1 | _pos = %2",_vehType,_pos];};
_veh = createVehicle[_vehType, _pos, [], 0, "NONE"];
[_veh] call blck_fnc_protectVehicle;
if (blck_debugLevel > 2) then {diag_log format["spawnVehicle.sqf:: vehicle spawned is %1",_veh];};
//  params["_veh",["_clearInventory",true]];
[_veh,_clearInventory] call blck_fnc_configureMissionVehicle;
diag_log format["spawnVehicle:: returning parameter _veh = %1",_veh];
_veh
	
