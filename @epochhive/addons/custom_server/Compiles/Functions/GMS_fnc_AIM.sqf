//This script sends Message Information to allplayers
// Last modified 11/14/15 by Ghostrider-DBD-

//blck_Message =  _this;
params["_msg",["_players",playableUnits]];
diag_log format["AIM.sqf ===]  _this = %1 | _msg = %2 | _players = %3",_this,_msg, _players];
blck_Message = _msg;
{
	diag_log format["AIM.sqf ===] _ = %2, and (owner _x) = %1", (owner _x), _x];
	(owner _x) publicVariableClient "blck_Message";
} forEach _players;
/*
if (_modType isEqualTo "Exile") then
{
	[_blck_Message] remoteExec["fn_blck_MessageHandler",0];
};
*/

