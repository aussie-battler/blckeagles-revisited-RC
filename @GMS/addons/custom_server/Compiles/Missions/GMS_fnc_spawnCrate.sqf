/*
	spawn a crate at a specific location 
	returns the object (crate) that was created.
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016
	Last updated 12-5-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_crate"];
params["_coords",["_crateType","Box_NATO_Wps_F"]];

_crate = createVehicle [_crateType,_coords,[], 0, "CAN_COLLIDE"];
_crate setVariable ["LAST_CHECK", 100000];
_crate allowDamage false;
_crate enableRopeAttach false;
[_crate] call blck_fnc_emptyObject;
_crate setPosATL _coords;
_crate setVectorUp [0,0,0];
if ((_coords select 2) < 0 || surfaceIsWater (_coords)) then
{

	private["_lantern","_bbr","_p1","_p2","_maxHeight"];
	//_lantern =  createVehicle ["PortableHelipadLight_01_red_F", [0,0,0],[],0,"CAN_COLLIDE"];// Land_Camping_Light_F
	//_lantern enableSimulationGlobal true;
	//_lantern switchLight "on";
	_light = "#lightpoint" createVehicle (getPos _crate);
    _light setLightDayLight true; 
	_light setLightBrightness 1.0;
	_light setLightAmbient [0.0, 1.0, 0.0];
	_light setLightColor [0.0, 1.0, 0.0];
	_bbr = boundingBoxReal _crate;
	_p1 = _bbr select 0;
	_p2 = _bbr select 1;
	_maxHeight = abs ((_p2 select 2) - (_p1 select 2));	
	//diag_log format["_fnc_spawnCrate: _bbr = %1  |  _maxHeight = %2",_bbr,_maxHeight];
	_light attachTo [_crate, [0,0,(_maxHeight + 0.5)]];
};
_crate;
