/*
  Set skills for an AI Unit
  by Ghostrider
  Last updated 8/14/16   
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

// Self explanatory
// [_group, _skill] call blck_setSkill;
params ["_unit","_skillsArrray"];

{
	_unit setSkill [(_x select 0),(_x select 1)];
} forEach _skillsArrray;
