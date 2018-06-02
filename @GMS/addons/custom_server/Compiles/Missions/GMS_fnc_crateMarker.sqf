/*
Dynamic Loot Crate Spaw System for Exile Mod for Arma 3
by
Ghostrider [GRG]
for ghostridergaming
4-6-16

Spawn a crate on land or in the air
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_crate","_light","_beacon","_start","_maxHeight","_bbr","_p1","_p2"];
params["_crate"];
//_crate = _this select 0;
_start = diag_tickTime;
// If night, attach a chemlight
_signal = "SmokeShellOrange";
if (sunOrMoon < 0.2) then
{
	_signal = "FlareYellow_F";
};

_bbr = boundingBoxReal _crate;
_p1 = _bbr select 0;
_p2 = _bbr select 1;
_maxHeight = abs ((_p2 select 2) - (_p1 select 2));	

while {(diag_tickTime - _start) < 3*60} do
{
	_beacon = _signal createVehicle getPosATL _crate;
	_beacon setPos (getPos _crate);
	_beacon attachTo [_crate,[0,0,(_maxHeight + 0.05)]];
	uiSleep 30;
	deleteVehicle _beacon;
};
true