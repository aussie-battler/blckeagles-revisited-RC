
/*
	Send player a mesage regarding reward for the kill.
	
*/

params["_killer","_distanceBonus"];
private["_kills","_mt"];
_mt = call blck_fnc_getModType;
diag_log format["_fnc_sendRewardMessage:: -- >> _this = %1 and mod type = %2",_this, _mt];

if (_mt isEqualTo "Exile") then
{
	_kills =  getVariable [_killer,"ExileKills"];
	private _killerMsg = [];
	_killerMsg pushback "Enemy AI Killed";
	_killerMsg pushback _newKillerScore;
	_killerMsg pushback format["%1X Killstreak",_kills];
	_killerMsg pushback format["Killstreak Bonus %1",(_kills*2)];
	private _message = ["showFragRequest",_killerMsg];
	diag_log format ["_fnc_rewardKiller:: -- >> _killer %1 _kills %2 _distanceBonus %3 _killerMsg = %1",_killer, _kills, _distanceBonus, _killerMsg];
	_message remoteExecCall ["ExileClient_system_network_dispatchIncomingMessage", (owner _killer)];
};
