//This script sends Message Information to allplayers
// Last modified 1/4/17 by Ghostrider-DBD-
/*
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//blck_Message =  _this;
params["_msg",["_players",playableUnits]];
if (blck_debugLevel > 1) then {diag_log format["AIM.sqf ===]  _this = %1 | _msg = %2 | _players = %3",_this,_msg, _players];};
blck_Message = _msg;
{
	//diag_log format["AIM.sqf ===] _ = %2, and (owner _x) = %1", (owner _x), _x];
	(owner _x) publicVariableClient "blck_Message";
} forEach _players;
/*
if (_modType isEqualTo "Exile") then
{
	[_blck_Message] remoteExec["fn_blck_MessageHandler",0];
};
*/

