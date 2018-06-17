/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private["_mode","_sm_groups"];
_sm_groups = +blck_sm_Infantry;
//diag_log format["_fnc_monitorInfantry: time %2 |  blck_sm_Infantry %1",blck_sm_Infantry,diag_tickTime];
{
	_x params["_groupParameters","_group","_groupSpawned","_timesSpawned","_respawnAt","_maxRespawns"];
	//diag_log format["_fnc_monitorInfantry: _x %1",_x];
	//diag_log format["_fnc_monitorInfantry: _groupParameters = %1",_groupParameters];
	//diag_log format["_fnc_monitorInfantry (9): _group %1 | _groupSpawned %2 | _timesSpawned %3 | _respawnAt %4",_group,_groupSpawned,_timesSpawned,_respawnAt];
	_groupParameters params["_pos","_difficulty","_units","_patrolRadius","_respawnTime"];
	//diag_log format["_fnc_monitorInfantry: _pos = %1 | _difficulty = 2 | _units = %3 | _patrolRadius = %4 | _respawnTime = %5",_pos,_difficulty,_units,_patrolRadius,_respawnTime];
	private _element = +_x;//
	
	if (!(isNull _group) && {alive _x} count (units _group) == 0) then
	{
		deleteGroup _group;
		_group = grpNull;
	};
	if (isNull _group) then
	{
		_mode = -1;
		if ((_timesSpawned == 0) && (_groupSpawned == 0)) then {_mode = 1};  // spawn-respawn
		if (_timesSpawned > 0) then
		{
			if ((_groupSpawned == 1) && (_respawnTime == 0)) then {_mode = 0}; // remove patrol from further evaluation
			if ((_timesSpawned > _maxRespawns) && (_maxRespawns != -1)) then {_mode = 0}; 
			if ((_groupSpawned == 1) && (_respawnTime > 0)) then {_mode = 2}; // set up for respawn at a later time 
			if ((_groupSpawned == 0) && (diag_tickTime > _respawnAt)) then {_mode = 1};
		};
		switch (_mode) do
		{
			case 0: {blck_sm_Infantry deleteAt (blck_sm_Infantry find _x)};
			case 1: {
						
						if ([_pos,staticPatrolTriggerRange] call blck_fnc_playerInRange) then
						{
							private _numAI = [_units] call blck_fnc_getNumberFromRange;
							//params["_pos",  "_center", ["_numai1",5],  ["_numai2",10],  ["_skillLevel","red"], ["_minDist",20], ["_maxDist",35],["_configureWaypoints",true], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_weaponList",[]],["_sideArms",blck_Pistols], ["_scuba",false] ];
							_group = [
								_pos,_pos,_numAI,_numAI,_difficulty,_patrolRadius-1,_patrolRadius,true,
								[_difficulty] call blck_fnc_selectAIUniforms,
								[_difficulty] call blck_fnc_selectAIHeadgear,
								[_difficulty] call blck_fnc_selectAIVests,
								[_difficulty] call blck_fnc_selectAIBackpacks,
								[_difficulty] call blck_fnc_selectAILoadout,
								[_difficulty] call blck_fnc_selectAISidearms
							] call blck_fnc_spawnGroup;
							_timesSpawned = _timesSpawned + 1;
							_groupSpawned = 1;
							_respawnAt = 0;
							_element set[patrolGroup,_group];
							_element set[groupSpawned,1];
							_element set[timesSpawned,_timesSpawned];
							_element set[respawnAt,_respawnAt];	
							blck_sm_Infantry set[blck_sm_Infantry find _x,_element];
						};
					};
			case 2: {
						_groupSpawned = 0;
						_respawnAt = diag_tickTime + _respawnTime;
						_element set[respawnAt,_respawnAt];	
						_element set[groupSpawned,_groupSpawned];
						blck_sm_Infantry set[blck_sm_Infantry find _x,_element];
						//diag_log format["_fnc_monitorInfantry: update respawn time to %1",_respawnAt];						
					};
			default {};
		};
		//diag_log format["_fnc_monitorInfantry(56) respawn conditions evaluated : _group = %1 | _groupSpawned = %2 | _timesSpawned = %3",_group,_groupSpawned,_timesSpawned];
	} else {
		//diag_log format["_fnc_monitorInfantry: diag_tickTime = %1 | playerNearAt = %2",diag_tickTime,_group getVariable["playerNearAt",-1]];
		if ([_pos,staticPatrolTriggerRange] call blck_fnc_playerInRange) then
		{
			_group setVariable["playerNearAt",diag_tickTime];
			//diag_log format["_fnc_monitorInfantry: playerNearAt updated to %1",_group getVariable["playerNearAt",-1]];
		} else {
			if (diag_tickTime > (_group getVariable["playerNearAt",diag_tickTime]) + blck_sm_groupDespawnTime) then
			{
				//diag_log format["_fnc_monitorInfantry: despanwing patrol for _element %1",_element];
				_groupParameters set [2, {alive _x} count (units _group)];
				{[_x] call blck_fnc_deleteAI} forEach (units _group);
				deleteGroup _group;
				_element set[groupParameters,_groupParameters];
				_element set[patrolGroup ,grpNull];
				_element set[timesSpawned,(_timesSpawned - 1)];
				_element set[groupSpawned,0];
				blck_sm_Infantry set[(blck_sm_Infantry find _x), _element];
			};
		};
	};
}forEach _sm_groups;