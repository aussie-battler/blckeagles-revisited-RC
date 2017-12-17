// Configures a mission vehicle
/*
	By Ghostrider [GRG]
	Copyright 2016
	Last updated 3-14-17
	
	spawns a vehicle of _vehType and mans it with units in _group.
	returns _veh, the vehicle spawned.
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_veh",["_clearInventory",true]];
private["_unit"];
if (_clearInventory) then 
{
	[_veh] call blck_fnc_emptyObject;
};
_veh setVehicleLock "LOCKEDPLAYER";
_veh addEventHandler ["GetIn",{  // Note: only fires when vehicle is local to player
	private["_unit","_veh"];
	_unit = _this select 2;
	_veh = _this select 0;
	if (isPlayer _unit) then
	{
		_unit action ["eject",_veh];
		titleText ["You are not allowed to enter that vehicle at this time","PLAIN DOWN"];
	};
}];	

_veh
