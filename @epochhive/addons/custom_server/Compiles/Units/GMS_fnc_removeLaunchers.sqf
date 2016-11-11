/*
	by Ghostrider
	11-11-16
*/

private["_launcher","_launcherRounds","_objects","_weapons","_container"];
params["_unit"];  // = _this select 0;
_launcher = _unit getVariable ["Launcher",""];
_unit removeWeapon _Launcher;
if (_launcher != "") then 
{
	_unit removeWeapon _Launcher;
	{
		if (_launcher in weaponCargo _x) exitWith {
			deleteVehicle _x;
		};
	} forEach ((getPosATL _unit) nearObjects ["WeaponHolderSimulated",10]);	
	_launcherRounds = getArray (configFile >> "CfgWeapons" >> _Launcher >> "magazines"); //0;
	{
		if(_x in _launcherRounds) then {_unit removeMagazine _x;};
	} count magazines _unit;
};

