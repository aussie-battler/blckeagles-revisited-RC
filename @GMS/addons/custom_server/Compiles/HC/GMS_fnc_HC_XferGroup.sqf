/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//#include "\q\addons\custom_server\Configs\blck_defines.hpp";

diag_log format["_fnc_HC_XferGroup:: _this = %1",_this];
private["_group","_client","_unit","_tempEH"];
_group = _this select 0;
blck_HC_monitoredGroups pushBack _group;
_client = clientOwner;
{
	_unit = _x;
	_localEH = [];
	_tempEH = ["reloaded",_unit addEventHandler ["reloaded", {_this call compile preprocessfilelinenumbers blck_EH_unitWeaponReloaded;}]];
	_localEH pushBack _tempEH;
	_x setVariable["localEH",_localEH,true];
}forEach (units _group);
diag_log format["blckHC:: group %1 transferred to HC %1",_group,_client];