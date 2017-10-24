diag_log format["_fnc_HC_XferGroup:: _this = %1",_this];
private["_group","_client","_unit","_localEH","_tempEH"];
_group = _this select 0;
_client = clientOwner;
{
	_unit = _x;
	_localEH = [];
	{
		_unit removeAllEventHandlers  _x;
	}forEach ["Killed","Fired","HandleDamage","HandleHeal","FiredNear","Hit"];
	_tempEH = ["reloaded",_unit addEventHandler ["reloaded", {_this call compile preprocessfilelinenumbers blck_EH_unitWeaponReloaded;}]];
	_localEH pushBack _tempEH;
	//_unit addMPEventHandler ["mpkilled", {[(_this select 0), (_this select 1)] call compile preprocessfilelinenumbers blck_EH_AIKilled;}]; // changed to reduce number of concurrent threads, but also works as spawn blck_AIKilled; }];
	_tempEH = ["Hit",_unit addEventHandler ["Hit",{ [_this] call compile preprocessFileLineNumbers blck_EH_AIHit;}]];
	_localEH pushBack _tempEH;
	_x setVariable["localEH",_tempEH,true];
}forEach (units _group);