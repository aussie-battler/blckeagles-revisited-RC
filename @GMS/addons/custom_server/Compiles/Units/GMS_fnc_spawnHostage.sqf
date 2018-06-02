/*
  by Ghostrider

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_coords","_hostageConfigs"];
private["_hostageGroup","_hostage"];
_hostage = [_coords,_hostageConfigs] call blck_fnc_spawnCharacter;
_hostage remoteExec["GMS_fnc_initHostage", -2, true];
_hostage setVariable["assetType",1,true];
/*
private _marker = createMarker [format["hostageMarger%1",getPos _hostage], getPos _hostage];
_marker setMarkerColor "ColorBlack";
_marker setMarkerType "mil_dot";
_marker setMarkerText "Hostage";
*/
_hostage


