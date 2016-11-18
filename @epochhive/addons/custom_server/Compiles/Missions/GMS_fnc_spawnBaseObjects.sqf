/*
 Spawn objects from an array using offsects from a central location.
 The code provided by M3Editor EDEN has been addapted to add checks for vehicles, should they be present.
 Returns an array of spawned objects. 
 version of 11/9/16
*/
//diag_log format["_fnc_spawnBaseObjects: _this = %1",_this];
params["_center","_azi","_objects","_setVector"];
//diag_log format["_fnc_spawnBaseObjects: _objs = %1",_objects];

private ["_newObjs"];

_newObjs = [];

{
	//diag_log format["_fnc_spawnBaseObjects::-->> _x = %1",_x];
	private _obj = (_x select 0) createVehicle [0,0,0];
	_newObjs pushback _obj;
	_obj setDir ( (_x select 2) + _azi);
	_obj setPosATL (_center vectorAdd (_x select 1));
	_obj enableSimulationGlobal true;
	_obj allowDamage true;	
	// Lock any vehicles placed as part of the mission landscape. Note that vehicles that can be taken by players can be added via the mission template.
	if ( (typeOf _obj) isKindOf "LandVehicle" || (typeOf _obj) isKindOf "Air" || (typeOf _obj) isKindOf "Sea") then
	{
		//diag_log format["_fnc_spawnBaseObjects:: Locking vehicle of type %1",typeOf _obj];
		//_obj = _x select 0;
		_obj setVehicleLock  "LOCKEDPLAYER";
		_obj addEventHandler ["GetIn",{  // forces player to be ejected if he/she tries to enter the vehicle
		private ["_theUnit"];
		_theUnit = _this select 2;
		_theUnit action ["Eject", vehicle _theUnit];
		hint "Use of this vehicle is forbidden";
		}];
		
		clearItemCargoGlobal  _obj;
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
	};	
} forEach _objects;
//diag_log format["_fnc_spawnBaseObjects _newObjs = %1",_newObjs];
_newObjs
