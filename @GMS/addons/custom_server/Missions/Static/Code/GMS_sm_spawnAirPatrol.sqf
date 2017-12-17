/*
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_airPatrols"];
private["_aircraft","_pos","_difficulty","_uniforms","_headGear"];
_aircraft = _x select 0;
_pos = _x select 1;
_difficulty = _x select 2;
_uniforms = blck_SkinList; 
_headGear = blck_headgearList;
switch (_difficulty) do
{
	case "blue": {_weapons = blck_WeaponList_Blue;};
	case "red": {_weapons = blck_WeaponList_Red};
	case "green": {_weapons = blck_WeaponList_Green};
	case "orange": {_weapons = blck_WeaponList_Orange};
};
_return = [_pos,_difficulty,_weapons,_uniforms,_headGear,_aircraft] call blck_fnc_spawnMissionHeli;
_group = group (_return select 1 select 0);
_group

