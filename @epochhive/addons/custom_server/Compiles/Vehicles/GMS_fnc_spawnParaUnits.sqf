/*
	Author: Ghostrider-DbD-
	Inspiration: blckeagls / A3EAI / VEMF / IgiLoad / SDROP
	License: Attribution-NonCommercial-ShareAlike 4.0 International
	3/17/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

params["_missionPos","_paraGroup","_numAI","_skillAI","_weapons","_uniforms","_headGear",["_heli",objNull]];
private["_arc","_dir","_spawnPos","_chute","_unit","_launcherType"];

diag_log format["_fnc_spawnParaUnits (17)::_missionPos %1 | _paraGroup %2 | _numAI %3 | _skillAI %4 | _heli = %5",_missionPos,_paraGroup,_numAI,_skillAI,_heli];

_launcherType = "none";
private ["_arc","_spawnPos"];
_arc = 45;
_dir = 0;
_pos = _missionPos;
for "_i" from 1 to _numAI do
{
	if (_heli isKindOf "Air") then {_pos = getPos _heli};
	_spawnPos = _pos getPos[1.5,_dir];
	_chute = createVehicle ["Steerable_Parachute_F", [100, 100, 200], [], 0, "FLY"];
	[_chute] call blck_fnc_protectVehicle;
	_unit = [[_spawnPos select 0, _spawnPos select 1, 100],_weapons,_paraGroup,_skillAI,_launcherType,_uniforms,_headGear] call blck_fnc_spawnAI;
	_chute setPos [_spawnPos select 0, _spawnPos select 1, 125];  //(_offset select 2) - 10];
	_unit assignAsDriver _chute;
	_unit moveInDriver _chute;
	_unit allowDamage true;
	_dir = _dir + _arc;
	diag_log format["_fnc_spawnParaUnits:: spawned unit %1, at location %2 and vehicle _unit %1",_unit,getPos _unit, vehicle _unit];
	uiSleep 2;
};

_paraGroup selectLeader ((units _paraGroup) select 0);
//params["_pos","_minDis","_maxDis","_group"];
[_missionPos,10,20,_paraGroup] call blck_fnc_setupWaypoints;

diag_log "_fnc_spawnParaUnits (44):  All Units spawned";
/*
diag_log "_fnc_spawnParaUnits:: waiting for paratroops to land";


private["_troopsOnGround"];
params["_group"];
_troopsOnGround = false;
	
while {!_troopsOnGround} do
{
	_troopsOnGround = true;
	{
		diag_log format["reinforments:: Tracking Paratroops unit %1 position %4  altitue %2 velocity %3 attachedTo %4",_x, (getPos _x select 2), (velocity _x select 2), getPosATL _x, attachedTo _x];
		if ( (getPosATL _x select 2) < 0.1) then {
			if (surfaceIsWater (position _x)) then {
				diag_log format["_fnc_spawnParaUnits:: unit %1 at %2 deleted",_x, getPos _x];
				[_x] call blck_fnc_deleteAI;
			};
		} 
		else 
		{_troopsOnGround = false;};
	}forEach units _paraGroup;
	uiSleep 5;	
};

diag_log "spawnParatroops:: All Units on the Ground";
*/
