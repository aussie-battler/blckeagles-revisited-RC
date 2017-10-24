
/*
	Killed handler for _units
	By Ghostrider-DbD
	Last Modified 4-11-17

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer"];

diag_log format["EH_AIKilled:: _units = %1 and _killer = %2",_unit,_killer];
[_unit,_killer] remoteExec ["blck_fnc_processAIKill",2];
