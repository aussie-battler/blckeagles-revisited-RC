
/*
	By Ghostrider-DbD-
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_grpPilot","_chanceLoot"];
_chopperType = selectRandom blck_AIHelis;
_grpPilot setVariable["groupVehicle",_chopperType];
#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionHeli:: _chopperType seleted = %1",_chopperType];
#endif

_spawnVector = round(random(360));
_spawnDistance = 1000; // + floor(random(1500)); // We need the heli to be on-site quickly to minimize the chance that a small mission has been completed before the paratroops are deployed and added to the list of live AI for the mission
_dropLoot = (random(1) < _chanceLoot);

// Use the new functionality of getPos
//  https://community.bistudio.com/wiki/getPos
_spawnPos = _coords getPos [_spawnDistance,_spawnVector];

#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionHeli:: vector was %1 with distance %2 yielding a spawn position of %3 at distance from _coords of %4",_spawnVector,_spawnDistance,_spawnPos, (_coords distance2d _spawnPos)];
#endif

_grpPilot setBehaviour "CARELESS";
_grpPilot setCombatMode "RED";
_grpPilot setSpeedMode "FULL";
_grpPilot allowFleeing 0;

private["_supplyHeli"];
//create helicopter and spawn it
_supplyHeli = createVehicle [_chopperType, _spawnPos, [], 90, "FLY"];
blck_monitoredVehicles pushback _supplyHeli;
[_supplyHeli] call blck_fnc_protectVehicle;
_supplyHeli setVariable["vehicleGroup",_grpPilot];

_supplyHeli setDir (_spawnVector -180);
_supplyHeli setFuel 1;
_supplyHeli engineOn true;
_supplyHeli flyInHeight 250;
_supplyHeli setVehicleLock "LOCKED";
_supplyHeli addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];

clearWeaponCargoGlobal _supplyHeli;
clearMagazineCargoGlobal _supplyHeli;
clearItemCargoGlobal _supplyHeli;
clearBackpackCargoGlobal  _supplyHeli;

_unitPilot = _grpPilot createUnit ["I_helipilot_F", getPos _supplyHeli, [], 0, "FORM"];
_unitPilot setSkill 1;
_unitPilot assignAsDriver _supplyHeli;
_unitPilot moveInDriver _supplyHeli;
_grpPilot selectLeader _unitPilot;
_grpPilot setVariable["paraGroup",_paraGroup];

#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionHeli:: heli spawned and pilot added"];
#endif

//set waypoint for helicopter
//params["_pos","_minDis","_maxDis","_group",["_mode","random"],["_wpPatrolMode","SAD"],["_soldierType","null"] ];
[_coords,25,40,_grpPilot,"random","SAD","helicpoter"] spawn blck_fnc_setupWaypoints;

#ifdef blck_debugMode
diag_log format["_fnc_spawnMissionHeli:: initial pilot waypoints set"];
#endif
_supplyHeli allowDamage true;
_supplyHeli
