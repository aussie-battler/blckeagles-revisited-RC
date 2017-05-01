/*
  Delete alive AI.
  Now called from the main thread which tracks the time elapsed so that we no longer spawn a wait timer for each completed mission.
  by Ghostrider
  Last updated 4/11/17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

/*
_fn_deleteAIfromList = {
	params["_aiList"];
	#ifdef blck_debugMode
	if (blck_debugLevel > 0) then {diag_log format["_fn_deleteAIfromList:: _aiList = %1",_aiList];};
	#endif

	{
		#ifdef blck_debugMode
		if (blck_debugLevel > 1) then {diag_log format["_fn_deleteAIfromList:: -> deleteing AI Unit %1",_x];};
		#endif

		[_x] call blck_fnc_deleteAI;
	}forEach _aiList;
};

#ifdef blck_debugMode
if (blck_debugLevel > 1) then {diag_log format["_fnc_cleanupAliveAI called at %1",diag_tickTime];};
#endif
*/
for "_i" from 1 to (count blck_liveMissionAI) do
{
	if ((_i) <= count blck_liveMissionAI) then
	{
		_units = blck_liveMissionAI select (_i - 1);
		//diag_log format["_fnc_cleanupAliveAI:: (34) evaluating with delete time = %2 and diag_tickTime %1", diag_tickTime, _units select 1];
		if (diag_tickTime > (_units select 1) ) then
		{
			diag_log format["_fnc_cleanupAliveAI:: cleaning up AI group %1",_units];
			{
			
				diag_log format["_fnc_cleanupAliveAI:: deleting unit %1",_x];
				diag_log format["_fnc_cleanupAliveAI:: vehicle _x = %1",vehicle _x];
				diag_log format["_fnc_cleanupAliveAI:: objectParent _x = %1",objectParent _x];
				
				if ((alive _x) && !(isNull objectParent _x)) then // mark the vehicle for deletion
				{
					diag_log format["_fnc_cleanupAliveAI: deleteing objectParent %1 [%3] for unit %2",objectParent _x, _x, typeName (objectParent _x), typeOf (objectParent _x)];
					[objectParent _x] call blck_fn_deleteAIvehicle;
				};
				[_x] call blck_fnc_deleteAI;
			}forEach (_units select 0);
			uiSleep 0.1;
			blck_liveMissionAI set[(_i - 1), -1];
			blck_liveMissionAI = blck_liveMissionAI - [-1];  // Remove that list of live AI from the list.

			#ifdef blck_debugMode
			if (blck_debugLevel > 1) then {diag_log format["_fnc_mainTread:: blck_liveMissionAI updated to %1",blck_liveMissionAI];};
			#endif
		};
	};
};

