
/*
	calculate a reward player for AI Kills
	Code fragment adapted from VEMF
	call as [_unit,_killer] call blck_fnc_rewardKiller;
	Last modified 6/3/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

params["_unit","_killer"];
//diag_log format["rewardKiller::  _unit = %1 and _killer %2",_unit,_killer];

private["_modType","_reward","_maxReward","_dist","_killstreakReward","_distanceBonus","_newKillerScore","_newKillerFrags","_money"];
_modType = call blck_fnc_getModType;


//diag_log format["[blckeagles] rewardKiller:: - _modType = %1",_modType];

diag_log format["[blckeagles] rewardKiller:: - _modType = %1",_modType];

if (_modType isEqualTo "Epoch") exitWith {};  // Have players pull crypto from AI bodies now that this feature is available.

if (_modType isEqualTo "Exile") then
{
	private["_distanceBonus","_overallRespectChange","_newKillerScore","_newKillerFrags","_maxReward","_money","_message"];

	if ( (isPlayer _killer) && (_killer getVariable["ExileHunger",0] > 0) && (_killer getVariable["ExileThirst",0] > 0) ) then
	{
		_distanceBonus = floor((_unit distance _killer)/100);
		_killstreakBonus = 3 * (_killer getVariable["blck_kills",0]);
		_respectGained = 25 + _distanceBonus + _killstreakBonus;
		_score = _killer getVariable ["ExileScore", 0];

		//diag_log format["GMS_fnc_rewardKiller.sqf:: ExileScore = %1",_killer getVariable ["ExileScore", 0]];
		_score = _score + (_respectGained);
		//diag_log format["GMS_fnc_rewardKiller.sqf:: _new = %1",_score];		

		_killer setVariable ["ExileScore", _score];
		format["setAccountScore:%1:%2", _score,getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		_newKillerFrags = _killer getVariable ["ExileKills", 0];
		_newKillerFrags = _newKillerFrags + 1;
		_killer setVariable ["ExileKills", _newKillerFrags];
		format["addAccountKill:%1", getPlayerUID _killer] call ExileServer_system_database_query_fireAndForget;
		//_message = ["showFragRequest",_respectGained];
		_killer call ExileServer_object_player_sendStatsUpdate;
		if (blck_useKillScoreMessage) then
		{
			[["showScore",[_respectGained,_distanceBonus,_kills]], [_killer]] call blck_fnc_messageplayers;
		};
	};
};


/*
	if (_overallRespectChange > 0) then {
		_score = _killer getVariable ["ExileScore", 0];
		_score = _score + _overallRespectChange;
		_killer setVariable ["ExileScore", _score];
		format["setAccountScore:%1:%2", _score,_killerPlayerUID] call ExileServer_system_database_query_fireAndForget;
		[_killer, "showFragRequest", [_killerRespectPoints]] call A3XAI_sendExileMessage;
	};
	
	//["systemChatRequest", [_killMessage]] call ExileServer_system_network_send_broadcast; //To-do: Non-global version
	_newKillerFrags = _killer getVariable ["ExileKills", 0];
	_killer setVariable ["ExileKills", _newKillerFrags + 1];
	format["addAccountKill:%1", _killerPlayerUID] call ExileServer_system_database_query_fireAndForget;

	_killer call ExileServer_object_player_sendStatsUpdate;
};
