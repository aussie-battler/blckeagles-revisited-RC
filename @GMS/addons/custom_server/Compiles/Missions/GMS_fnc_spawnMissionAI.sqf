/*
	blck_fnc_spawnMissionAI
	by Ghostrider-DbD-
	8/13/17
	[_coords,  // center of the area within which to spawn AI
	_minNoAI,  // minimum number of AI to spawn
	_maxNoAI,  // Max number of AI to spawn
	_aiDifficultyLevel,  // AI level [blue, red, etc]
	_uniforms,	//  Uniforms to use - note default is blck_sSkinList
	_headGear   // headgear to use - blck_BanditHeager is the default
	] call blck_fnc_spawnMissionAI
	returns an array of the units spawned
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
#ifdef blck_debugMode
if (blck_debugLevel >=2) then
{
	{
		diag_log format["_fnc_spawnMissionAI:: _this select %1 = %2",_forEachIndex,_x];
	}forEach _this;
};
#endif

	params["_coords",["_minNoAI",3],["_maxNoAI",6],["_aiDifficultyLevel","red"],["_uniforms",blck_SkinList],["_headGear",blck_BanditHeadgear],"_missionGroups"];
	private["_unitsToSpawn","_unitsPerGroup","_ResidualUnits","_newGroup","_blck_AllMissionAI","_abort"];
	_unitsToSpawn = [[_minNoAI,_maxNoAI]] call blck_fnc_getNumberFromRange;  //round(_minNoAI + round(random(_maxNoAI - _minNoAI)));
	_unitsPerGroup = floor(_unitsToSpawn/_noAIGroups);
	_ResidualUnits = _unitsToSpawn - (_unitsPerGroup * _noAIGroups);
	_blck_AllMissionAI = [];
	_abort = false;
	
	#ifdef blck_debugMode
	if (blck_debugLevel >= 2) then
	{
		diag_log format["_fnc_spawnMissionAI (30):: _unitsToSpawn %1 ; _unitsPerGroup %2  _ResidualUnits %3",_unitsToSpawn,_unitsPerGroup,_ResidualUnits];
	};
	#endif
if (count _missionGroups > 0) then
{
	{	
		_x params["_position","_minAI","_maxAI","_skillLevel","_minPatrolRadius","_maxPatrolRadius"];
		_groupSpawnPos = _coords vectorAdd _position;
		
		diag_log format["_fnc_spawnMissionAI:: _x= %1",_x];
		diag_log format["_fnc_spawnMissionAI:: _coords = %1 | _groupSpawnPos = %2 | _position = %3",_coords,_groupSpawnPos,_position];
		//  player modelToWorld [0,-1,3];
		//  params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear],["_configureWaypoints",true] ];
		_newGroup = [_groupSpawnPos,_minAI,_maxAI,_skillLevel,_coords,_minPatrolRadius,_maxPatrolRadius,_uniforms,_headGear,true] call blck_fnc_spawnGroup;
			
		#ifdef blck_debugMode
		if (blck_debugLevel >= 2) then
		{
			diag_log format["_fnc_spawnMissionAI (37):: case 1 - > _newGroup = %1",_newGroup];
		};
		#endif

		if (isNull _newGroup) then 
		{
			_abort = true;
		} 
		else
		{
			_newAI = units _newGroup;
			blck_monitoredMissionAIGroups pushback _newGroup;
			#ifdef blck_debugMode
			if (blck_debugLevel >= 2) then
			{
				diag_log format["_fnc_spawnMissionAI(41): Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
			};
			#endif
			
			_blck_AllMissionAI append _newAI;
			
		};
	}forEach _missionGroups;
};
if (_missionGroups isEqualTo []) then
{
	switch (_noAIGroups) do
	{
		case 1: {  // spawn the group near the mission center
				
				#ifdef blck_debugMode
				//params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
				if (blck_debugLevel >= 2) then
				{
					diag_log format["missionSpawner: Spawning Groups: _noAIGroups=1"];
				};
				#endif

				_newGroup = [_coords,_unitsToSpawn,_unitsToSpawn,_aiDifficultyLevel,_coords,25,30,_uniforms,_headGear,true] call blck_fnc_spawnGroup;
				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (37):: case 1 - > _newGroup = %1",_newGroup];
				};
				#endif

				if (isNull _newGroup) then 
				{
					_abort = true;
				} 
				else
				{
					_newAI = units _newGroup;
					blck_monitoredMissionAIGroups pushback _newGroup;
					#ifdef blck_debugMode
					if (blck_debugLevel >= 2) then
					{
						diag_log format["_fnc_spawnMissionAI(41): Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
					};
					#endif
					
					_blck_AllMissionAI append _newAI;
					
				};
			 };
		case 2: {

				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI(47): Spawning Groups: _noAIGroups=2"];  // spawn groups on either side of the mission area
				};
				#endif

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
					_newGroup = [_x,_adjusttedGroupSize,_adjusttedGroupSize,_aiDifficultyLevel,_coords,15,25,_uniforms,_headGear] call blck_fnc_spawnGroup;
					if (isNull _newGroup) then 
					{
						_abort = true;
					} 
					else 
					{
						_newAI = units _newGroup;

						#ifdef blck_debugMode
						if (blck_debugLevel >= 2) then
						{
							diag_log format["_fnc_spawnMissionAI(61): case 2: _newGroup=%1",_newGroup];
						};
						#endif

						_blck_AllMissionAI append _newAI;
					};
				}forEach _groupLocations;

			};
		case 3: { // spawn one group near the center of the mission and the rest on the perimeter
				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (68): Spawning Groups: _noAIGroups=3"];
				};
				#endif


				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,10,15,_uniforms,_headGear] call blck_fnc_spawnGroup;
				if (isNull _newGroup) then 
				{
					_abort = true;
				} 
				else
				{
					_newAI = units _newGroup;

					#ifdef blck_debugMode
					if (blck_debugLevel >= 2) then
					{
						diag_log format["_fnc_spawnMissionAI (73): Case 3:  _newGroup=%1",_newGroup];
					};
					#endif

					_blck_AllMissionAI append _newAI;

					_groupLocations = [_coords,2,20,35] call blck_fnc_findPositionsAlongARadius;
					{
						_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
						if (isNull _newGroup) then 
						{
							_abort = true;
						}
						else
						{
							_newAI = units _newGroup;

							#ifdef blck_debugMode
							if (blck_debugLevel >= 2) then
							{
								diag_log format["_fnc_spawnMissionAI(78): Case 3: line 81: _newGroup = %1",_newGroup];
							};
							#endif

							_blck_AllMissionAI append _newAI;
						};
					}forEach _groupLocations;
				};
			};
		default {  // spawn one group near the center of the mission and the rest on the perimeter

				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI (88): case 4:"];
				};
				#endif

				_newGroup = [_coords,_unitsPerGroup + _ResidualUnits,_unitsPerGroup + _ResidualUnits,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
				if (isNull _newGroup) then 
				{
					_abort = true;
				};
				_newAI = units _newGroup;
				
				#ifdef blck_debugMode
				if (blck_debugLevel >= 2) then
				{
					diag_log format["_fnc_spawnMissionAI(92): Spawning Groups: _noAIGroups=1 _newGroup=%1 _newAI = %2",_newGroup, _newAI];
				};
				#endif

				_blck_AllMissionAI append _newAI;
				_groupLocations = [_coords,(_noAIGroups - 1),20,40] call blck_fnc_findPositionsAlongARadius;
				{
					_newGroup = [_x,_unitsPerGroup,_unitsPerGroup,_aiDifficultyLevel,_coords,1,12,_uniforms,_headGear] call blck_fnc_spawnGroup;
					if (isNull _newGroup) then 
					{
						_abort = true;
					}
					else 
					{
						_newAI = units _newGroup;
						if (blck_debugLevel > 2) then
						{
							diag_log format["_fnc_spawnMissionAI(99): _newGroup=%1",_newGroup];
						};
						_blck_AllMissionAI append _newAI;
					};
				}forEach _groupLocations;
			};
	};
};
#ifdef blck_debugMode
if (blck_debugLevel >= 1) then
{
	diag_log format["_fnc_spawnMissionAI(133): _abort = %1 | _blck_AllMissionAI = %2",_abort,_blck_AllMissionAI];
};
#endif

private["_return"];
_return = [_blck_AllMissionAI,_abort];
_return
