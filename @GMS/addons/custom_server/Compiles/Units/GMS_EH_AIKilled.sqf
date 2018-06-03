
/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer"];

#ifdef blck_debugMode
if (blck_debugLevel > 2) then
{
	private _vars = ["unit","killer","instigator","useEffects"];
	diag_log format["EH_AIKilled:: _this select %1 (_var select %2) = %3",_forEachIndex,_vars select _forEachIndex,_this select _forEachIndex];
};
#endif
[_unit,_killer] remoteExec ["blck_fnc_processAIKill",2];
