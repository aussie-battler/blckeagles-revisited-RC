//////////////////////////////////////////////////////
// test whether the end conditions for a mission have been met
// by Ghostrider-DBD- 
// Last modified 1/12/17
/////////////////////////////////////////////////////

params ["_locations","_blck_AllMissionAI","_endCondition"];
private{"_missionComplete","_endIfPlayerNear","_endIfAIKilled"];
 _missionComplete = false;
 _endIfAIKilled - false;
 _endIfPlayerNear = false;
switch (_endCondition) do
{
	case "playerNear": {_endIfPlayerNear = true;};
	case "allUnitsKilled": {_endIfAIKilled = true;};
	case "allKilledOrPlayerNear": {_endIfPlayerNear = true;_endIfAIKilled = true;};
};
if (blck_debugON) then {diag_log format["_fnc_missionEndConditionMet:: -> _endIfPlayerNear = %1, _endIfAIKilled = %2, _endCondition = %3",_endIfPlayerNear,_endIfAIKilled,_endCondition];
if (blck_debugLevel isEqualTo 3) then
{
	uiSleep 60;
	diag_log "_fnc_missionEndConditionMet::-> bypassing end condtions, blck_debugLevel == 3";
} else {
	while {!_missionComplete} do
	{
		uiSleep 5;
		if (_endIfPlayerNear) then {
			if ( { (isPlayer _x) && ([_x,_locations,20] call blck_fnc_objectInRange) && (vehicle _x == _x) } count allPlayers > 0) then {
				_missionComplete = true;
			};
		};

		if (_endIfAIKilled) then {
			private _alive = ({alive _x} count _blck_AllMissionAI) > 0;
			diag_log format["missionSpawner:: count alive _blck_AllMissionAI = %1",_alive];
			if (({alive _x} count _blck_AllMissionAI) < 1 ) then {
				_missionComplete = true;
				diag_log format["missionSpawner:: _blck_AllMissionAI = %1","testing case _endIfAIKilled"];
			};
		};
	};
};
true
