/*
	blck_fnc_spawnMissionAI
	by Ghostrider-DbD-
	1/9/17
	[_coords,  // center of the area within which to spawn AI
	_minNoAI,  // minimum number of AI to spawn
	_maxNoAI,  // Max number of AI to spawn
	_aiDifficultyLevel,  // AI level [blue, red, etc]
	_uniforms,	//  Uniforms to use - note default is blck_sSkinList
	_headGear   // headgear to use - blck_BanditHeager is the default
	] call blck_fnc_spawnMissionAI
	returns an array of the units spawned
*/
	params["_coords",["_minNoAI",3],["_maxNoAI",6],["_aiDifficultyLevel","red"],["_uniforms",blck_SkinList],["_headGear",blck_BanditHeadgear]];
	private["_unitsToSpawn","_unitsPerGroup","_ResidualUnits","_newGroup","_blck_AllMissionAI"];
	_unitsToSpawn = round(_minNoAI + round(random(_maxNoAI - _minNoAI)));
	_unitsPerGroup = floor(_unitsToSpawn/_noAIGroups);
	_ResidualUnits = _unitsToSpawn - (_unitsPerGroup * _noAIGroups);
	_blck_AllMissionAI = [];
	diag_log format["_fnc_spawnMissionAI :: _unitsToSpawn %1 ; _unitsPerGroup %2  _ResidualUnits %3",_unitsToSpawn,_unitsPerGroup,_ResidualUnits];
	switch (_noAIGroups) do
	{
		case 1: {  // spawn the group near the mission center
				//params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
				_newGroup = [_coords,_unitsToSpawn,_unitsToSpawn,_aiDifficultyLevel,_coords,3,18,_uniforms,_headGear] call blck_fnc_spawnGroup;
				if !(isNull _newGroup) then
				{
					//_newAI = units _newGroup;
					_blck_AllMissionAI = _blck_AllMissionAI + units _newGroup;
					//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
				} else {
					_abortMissionSpawner = true;
				};
			 };
		case 2: {
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=2"];  // spawn groups on either side of the mission area
				_groupLocations = [_coords,_noAIGroups,15,30] call blck_fnc_findPositionsAlongARadius;
				{
					private["_adjusttedGroupSize"];
					if (_ResidualUnits > 0) then
					{
						_adjusttedGroupSize = _unitsPerGroup + _ResidualUnits;
						_ResidualUnits = 0;
					} else {
						_adjusttedGroupSize = _unitsPerGroup;
					};
					_newGroup = [_x,_adjusttedGroupSize,_adjusttedGroupSize,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					if (isNull _newGroup) exitWith {_abortMissionSpawner = true;};
					_newAI = units _newGroup;
					_blck_AllMissionAI = _blck_AllMissionAI + _newAI;
					//diag_log format["missionSpawner: Spawning 2 Groups: _newGroup=%1  _newAI = %2",_newGroup, _newAI];
				}forEach _groupLocations;

			};
		case 3: { // spawn one group near the center of the mission and the rest on the perimeter
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=3"];
				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
				if (isNull _newGroup) then {_abortMissionSpawner = true;} else 
				{
					_newAI = units _newGroup;
					_blck_AllMissionAI = _blck_AllMissionAI + _newAI;
					//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=3 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
					_groupLocations = [_coords,2,20,35] call blck_fnc_findPositionsAlongARadius;
					{
						_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
						if (isNull _newGroup) exitWith {_abortMissionSpawner = true;};
						_newAI = units _newGroup;
						_blck_AllMissionAI = _blck_AllMissionAI + _newAI;
						//diag_log format["missionSpawner: Spawning 2 Groups:_newGroup=%1  _newAI = %2",_newGroup, _newAI];
					}forEach _groupLocations;
				};
			};
		default {  // spawn one group near the center of the mission and the rest on the perimeter
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=default"];
				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
				_newAI = units _newGroup;
				_blck_AllMissionAI = _blck_AllMissionAI + _newAI;
				//diag_log format["missionSpawner: Spawning Groups: _noAIGroups=%3 _newGroup=%1 _newAI = %2",_newGroup, _newAI,_noAIGroups];
				_groupLocations = [_coords,(_noAIGroups - 1),20,40] call blck_fnc_findPositionsAlongARadius;
				{
					_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					if (isNull _newGroup) exitWith {_abortMissionSpawner = true;};
					_newAI = units _newGroup;
					_blck_AllMissionAI = _blck_AllMissionAI + _newAI;
					//diag_log format["missionSpawner: Spawning %3 Groups: _newGroup=%1  _newAI = %2",_newGroup, _newAI,_noAIGroups];
				}forEach _groupLocations;
			};
	};
	
_blck_AllMissionAI