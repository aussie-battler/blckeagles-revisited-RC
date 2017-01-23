// Configures a mission vehicle
// by Ghostrider-DBD-
// Last Updated 1/22/17

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
