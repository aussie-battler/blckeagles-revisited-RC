/*
	Run scripts exported from M3EDEN Editor plug in for Arma 3 or other map addons. 
	Add addons to the arrays for Epoch or Exile as appropriate.
	Arrays should contain ["mapname", "name of folder within mapaddons","name of file to execute"]
	by Ghostrider-DbD-
	for DBD Clan
	11/12/16
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


