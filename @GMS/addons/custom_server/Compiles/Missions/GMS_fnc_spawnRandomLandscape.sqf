/*
	spawn a group of objects in random locations aligned with the radial from the center of the region to the object.
	By Ghostrider [GRG]
	copyright 2016
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_coords","_missionLandscape",["_min",3],["_max",15],["_nearest",1]];
private["_objects","_wreck","_dir","_dirOffset"];
#define objectSpawnRadius 15
_objects = [];
_wreck = createVehicle ["RoadCone_L_F", _coords];  //  To designate the mission center
_wreck allowDamage true;
_wreck enableSimulation false;
_wreck enableSimulationGlobal false;
_wreck enableDynamicSimulation false;
_objects pushBack _wreck;
{
	//Random Position Objects based on distance in array
	//  https://community.bistudio.com/wiki/BIS_fnc_findSafePos
	private _posX = ((_coords select 0) + random(objectSpawnRadius)) * (selectRandom[1,-1]);
	private _posY = ((_coords select 1) + random(objectSpawnRadius)) * (selectRandom[1,-1]);
	_pos = [_coords,_min,_max,_nearest,0,5,0] call BIS_fnc_findSafePos;
	_wreck = createVehicle[_x, _pos, [], 2];
	//diag_log format["_fnc_spawnRandomLandscape: _x = %1 | _wreck = %2",_x,_wreck];	
	_wreck allowDamage true;
	_wreck enableSimulation false;
	_wreck enableSimulationGlobal false;
	_wreck enableDynamicSimulation false;
	_dirOffset = random(30) * ([1,-1] call BIS_fnc_selectRandom);
	_dir = _dirOffset +([_wreck,_coords] call BIS_fnc_dirTo);
	_wreck setDir _dir;
	//_wreck setDir (_wreck relativeDir _coords);
	_objects pushback _wreck;
	sleep 0.1;
} forEach _missionLandscape;

#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log format["_fnc_spawnRandomLandscape::-->> _objects = %1",_objects];};
#endif

_objects
