//This script sends Message Information to allplayers
// Last modified 1/4/17 by Ghostrider [GRG]
/*
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_msg",["_players",allplayers]];
#ifdef blck_debugMode
if (blck_debugLevel > 1) then {diag_log format["AIM.sqf ===]  _this = %1 | _msg = %2 | _players = %3",_this,_msg, _players];};
#endif
{
	if (isPlayer _x) then {_msg remoteExec["fn_handleMessage",(owner _x)]};
} forEach _players;



