/*
 Spawn objects from an array using offsects from a central location.
 The code provided by M3Editor EDEN has been addapted to add checks for vehicles, should they be present.
 Returns an array of spawned objects. 
 version of 10/13/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_center","_objects"];
if (count _center == 2) then {_center pushBack 0};
//diag_log format["_spawnBaseObjects:: -> _objects = %1",_objects];
private ["_newObjs"];

_newObjs = [];

{
	//diag_log format["_fnc_spawnBaseObjects::-->> _x = %1",_x];
	private _obj = (_x select 0) createVehicle [0,0,0];
	//diag_log format["_fnc_spawnBaseObjects: _obj = %1",_obj];
	_newObjs pushback _obj;
	//diag_log format["_fnc_spawnBaseObjects: _center = %1 and _x select 1 = %2",_center,_x select 1];
	private _spawnPos = (_center vectorAdd (_x select 1));
	if (surfaceIsWater _spawnPos) then 
	{
		_obj setPosASL _spawnPos;
		//diag_log "_fnc_spawnBaseObjects: detected surface == water";
	} else {
		_obj setPosATL _spawnPos;
		//diag_log "_fnc_spawnBaseObjects: detected surface = Land";
	};
	_obj setDir (_x select 2);
	_obj enableDynamicSimulation true;
	_obj allowDamage true;	
	// Lock any vehicles placed as part of the mission landscape. Note that vehicles that can be taken by players can be added via the mission template.
	if ( (typeOf _obj) isKindOf "LandVehicle" || (typeOf _obj) isKindOf "Air" || (typeOf _obj) isKindOf "Sea") then
	{
		[_obj] call blck_fnc_configureMissionVehicle;
	};	
} forEach _objects;
//diag_log format["_fnc_spawnBaseObjects: _newObjs = 51",_newObjs];
_newObjs

