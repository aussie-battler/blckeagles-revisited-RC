
/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//#include "\q\addons\custom_server\Configs\blck_defines.hpp";
//diag_log format["_EH_processAIVehicleKill:  _this = %1",_this];
if !(isDedicated) exitWith {};
_this call blck_fnc_processAIVehicleKill;
