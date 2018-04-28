diag_log format["_fnc_HC_XferGroup:: _this = %1",_this];
private["_group","_client","_unit","_tempEH"];
_group = _this select 0;
_client = clientOwner;
{
	_unit = _x;
	_localEH = [];
	_tempEH = ["reloaded",_unit addEventHandler ["reloaded", {_this call compile preprocessfilelinenumbers blck_EH_unitWeaponReloaded;}]];
	_localEH pushBack _tempEH;
	_x setVariable["localEH",_localEH,true];
	if(_unit != vehicle _unit) then
	{
		diag_log format["_fnc_HC_XferGroup: _unit %1 is in vehicle %2",_unit, vehicle _unit];
		blck_HC_monitoredVehicles pushBack (vehicle _unit);
		diag_log format["_fnc_HC_XferGroup: blck_HC_monitoredVehicles = %1", blck_HC_monitoredVehicles];
	};
}forEach (units _group);
diag_log format["blckHC:: group %1 transferred to HC %1",_group,_client];