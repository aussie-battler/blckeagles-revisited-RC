/*
Pulled from Arma
 version of 11/9/16
 Modified by Ghostrider-DbD-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_center","_azi","_objs","_setVector"];


private ["_newObjs"];

//If the object array is in a script, call it.
//_objs = call (compile (preprocessFileLineNumbers _script));

_newObjs = [];

{
	private _object = (_x select 0) createVehicle [0,0,0];
	_newObjs pushback _object;
	_object setDir ( (_x select 2) + _azi);
	_object setPosATL (_center vectorAdd (_x select 1));
	_object enableSimulationGlobal true;
	_object allowDamage true;	
	// Lock any vehicles placed as part of the mission landscape. Note that vehicles that can be taken by players can be added via the mission template.
	if ( (typeOf _object) isKindOf "LandVehicle" || (typeOf _object) isKindOf "Air" || (typeOf _object) isKindOf "Sea") then
	{
		#ifdef blck_debugMode
		diag_log format["MAP ADDONS:: Locking vehicle of type %1",typeOf _object];
		#endif
		//_object = _x select 0;
		_object setVehicleLock  "LOCKEDPLAYER";
		_object addEventHandler ["GetIn",{  // forces player to be ejected if he/she tries to enter the vehicle
		private ["_theUnit"];
		_theUnit = _this select 2;
		_theUnit action ["Eject", vehicle _theUnit];
		hint "Use of this vehicle is forbidden";
		}];
		
		clearItemCargoGlobal  _object;
		clearWeaponCargoGlobal _object;
		clearMagazineCargoGlobal _object;
		clearBackpackCargoGlobal _object;
	};	
} forEach _objects;
_newObjs


_newObjs