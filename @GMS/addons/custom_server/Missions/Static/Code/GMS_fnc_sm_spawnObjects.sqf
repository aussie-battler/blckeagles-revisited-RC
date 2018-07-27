/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_objects"];
//diag_log format["_sm_spawnObjects:: _objects = %1",_objects];
private["_objects","_object"];
	
{
	//diag_log format["_sm_spawnObjects:: spawning object of type %1 with parameters of %2",_x select 0, _x];
	//private _object = (_x select 0) createVehicle [0,0,0];
	//  [type, position, markers, placement, special]
	_object = createVehicle [_x select 0, _x select 1, [], 0, "CAN_COLLIDE"];
	_object setPosASL (_x select 1);
	_object setVectorDirAndUp (_x select 2);
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);
} forEach _objects;


