/*
	spawn a crate at a specific location and protect it against cleanup by Epoch
	returns the object (crate) that was created.
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last updated 9-4-16
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_crate","_px","_py","_defaultCrate"];
_defaultCrate = "Box_NATO_Wps_F";
params["_coords",["_crateType",_defaultCrate]];

_px = _coords select 0;
_py = _coords select 1;

_crate = objNull;
_crate = createVehicle [_crateType,_coords,[], 0, "CAN_COLLIDE"];
_crate setVariable ["LAST_CHECK", 100000];
_crate setPosATL [_px, _py, 0.5];
_crate allowDamage false;
_crate enableRopeAttach true;
[_crate] call blck_fnc_emptyObject;
_crate;
