/*
  Delete alive AI.
  Now called from the main thread which tracks the time elapsed so that we no longer spawn a wait timer for each completed mission.
  by Ghostrider
  Last updated 3/13/17
*/

//diag_log format["_fnc_cleanupAliveAI:: blck_liveMissionAIGroups = %1",blck_liveMissionAIGroups];
if (blck_debugLevel > 1) then {diag_log format["_fnc_cleanupAliveAI called at %1",diag_tickTime];};
//  blck_liveMissionAIGroups is an array of groups
for "_i" from 1 to (count blck_liveMissionAIGroups) do
{
	if ((_i) <= count blck_liveMissionAIGroups) then
	{
		private["_missionGroups","_groupsToClean"];
		_missionGroups = blck_liveMissionAIGroups select (_i - 1);
		//diag_log format["_fnc_cleanupAliveAI:: _missionGroups = %1", _missionGroups];
		//diag_log format["_fnc_cleanupAliveAI:: (19) evaluating with delete time = %2 and diag_tickTime %1", diag_tickTime, _missionGroups select 1];
		
		if ( diag_tickTime > (_missionGroups select 1) ) then
		{
			_groupsToClean = _missionGroups select 0;
			//diag_log format["_fnc_cleanupAliveAI:: cleaning up AI groups %1",_groupsToClean];
			{
				if !(_x isEqualTo grpNull) then
					{private["_group"];
					_group = _x; // for coding clarity only
					//diag_log format["_fnc_cleanupAliveAI:: cleaning up %2 units for group %1",_group, count (units _group)];
					{
						//diag_log format["_fnc_cleanupAliveAI:: deleting unit %1",_x];
						[_x] call blck_fnc_deleteAI;
					} forEach (units _group);
				};
			}forEach (_groupsToClean);
			uiSleep 0.1;
			blck_liveMissionAIGroups set[(_i - 1), -1];
			blck_liveMissionAIGroups = blck_liveMissionAIGroups - [-1];  // Remove that list of live AI from the list.
			//if (blck_debugLevel > 1) then {diag_log format["_fnc_mainTread:: blck_liveMissionAI updated to %1",blck_liveMissionAIGroups];};
		};
	};
};

