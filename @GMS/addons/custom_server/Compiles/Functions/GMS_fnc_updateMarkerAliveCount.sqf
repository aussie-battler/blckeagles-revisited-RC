/*
	by Ghostrider [GRG] 
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_marker","_rootText","_missionAI"];
//diag_log format["_fnc_updateMarkerAliveCount:  _this = %1",_this];
_marker setMarkerText format["%1 / %2 AI Alive",_rootText,{alive _x} count _missionAI];