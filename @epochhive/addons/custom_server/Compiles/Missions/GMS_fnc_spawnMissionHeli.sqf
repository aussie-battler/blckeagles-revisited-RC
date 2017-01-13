
params["_coords","_grpPilot","_chanceLoot"];
_chopperType = selectRandom blck_AIHelis;

diag_log format["_fnc_missionSpawner:: _chopperType seleted = %1",_chopperType];

_spawnVector = round(random(360));
_spawnDistance = 1000; // + floor(random(1500)); // We need the heli to be on-site quickly to minimize the chance that a small mission has been completed before the paratroops are deployed and added to the list of live AI for the mission
_dropLoot = (random(1) < _chanceLoot);

// Use the new functionality of getPos
//  https://community.bistudio.com/wiki/getPos
_spawnPos = _coords getPos [_spawnDistance,_spawnVector];

diag_log format["_fnc_missionSpawner:: vector was %1 with distance %2 yielding a spawn position of %3 at distance from _coords of %4",_spawnVector,_spawnDistance,_spawnPos, (_coords distance2d _spawnPos)];

_grpPilot setBehaviour "CARELESS";
_grpPilot setCombatMode "RED";
_grpPilot setSpeedMode "FULL";
_grpPilot allowFleeing 0;

private["_supplyHeli"];
//create helicopter and spawn it
_supplyHeli = createVehicle [_chopperType, _spawnPos, [], 90, "FLY"];
if ([] call blck_fnc_getModType isEqualTo "Epoch") then
{
	_supplyHeli call EPOCH_server_setVToken;
};
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
diag_log format["_fnc_missionSpawner:: heli spawned and pilot added"];

//set waypoint for helicopter
private["_wpDestination"];
[_grpPilot, 0] setWPPos _coords; 
[_grpPilot, 0] setWaypointType "MOVE";
[_grpPilot, 0] setWaypointSpeed "FULL";
[_grpPilot, 0] setWaypointBehaviour "CARELESS";
[_grpPilot, 0] setWaypointCompletionRadius 30;
[_grpPilot, 0] setWaypointStatements ["true","[this, 0] setWaypointName ""done"" ;"];
[_grpPilot,0] setWaypointTimeout [0.5,0.5,0.5];
_grpPilot setCurrentWaypoint [_grpPilot,0];

diag_log format["_fnc_missionSpawner:: initial pilot waypoints set"];
		
_supplyHeli