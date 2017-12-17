/*
	by Ghostrider [GRG]
	for ghostridergaming
	12/5/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
{
	private ["_missionCenter"];
	_missionCenter = _x select 0;
	if ([_missionCenter,2000] call blck_fnc_playerInRange then ([_missionCenter] execVM format["%1", _x select 1];
} forEach blck_staticMissions;


