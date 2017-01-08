/*
	Author: Ghostrider-DbD-
	Inspiration: blckeagls / A3EAI / VEMF / IgiLoad / SDROP
	License: Attribution-NonCommercial-ShareAlike 4.0 International
	called once all tasks required at the mission are complete.
*/

_grpPilot = _this select 0;
_heli = _this select 1;

diag_log "reinforcements deployed:: send heli back to spawn";

// select a random location abotu 2K from the mission
_spawnVector = round(random(360));
_spawnDistance = 2000;
_pos = getPos _heli;

// Use the new functionality of getPos
//  https://community.bistudio.com/wiki/getPos
_home = _pos getPos [_spawnDistance,_spawnVector];

// Send the heli back to base
_grpPilot = group this;
[_grpPilot, 0] setWPPos _pos; 
[_grpPilot, 0] setWaypointType "MOVE";
[_grpPilot, 0] setWaypointSpeed "FULL";
[_grpPilot, 0] setWaypointBehaviour "CARELESS";
[_grpPilot, 0] setWaypointCompletionRadius 200;
[_grpPilot, 0] setWaypointStatements ["true", "{deleteVehicle _x} forEach units group this;deleteVehicle (vehicle this);diag_log ""helicopter and crew deleted"""];
[_grpPilot, 0] setWaypointName "GoHome";
[_grpPilot,0] setWaypointTimeout [0.5,0.5,0.5];


diag_log "reinforcements:: sending Heli Home";
// End of sending heli home
////////////////////////

_fn_cleanupHeli = {

	params["_supplyHeli","_homePos","_grpPilot"];
	// run some tests to be sure everything went OK

	_heliHome = false;
	_startTime = diag_tickTime;

	while { !(_heliHome) } do
	{
		_heliHome = (_supplyHeli distance _pos) < 300;
		if ( !_heliHome && ((diag_tickTime - _startTime) > 300) ) then
		{
			_heliHome = true;
			deleteVehicle _supplyHeli;
			{
				deleteVehicle _x;
			}forEach units _grpPilot;
			deleteGroup _grpPilot;
	};
	
	uiSleep 2;
	};
};

[_supplyHeli,_spawnPos,_grpPilot] spawn _fn_cleanupHeli;

diag_log "reinforcements:: script done";

