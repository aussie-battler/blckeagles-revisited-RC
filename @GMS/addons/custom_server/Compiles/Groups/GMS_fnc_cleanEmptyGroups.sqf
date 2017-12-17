/*
   call as [] call blck_fnc_cleanEmptyGroups;
   Deletes any empty groups and thereby prevents errors resulting from createGroup returning nullGroup.
   By Ghostrider [GRG]
  3/18/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

#ifdef blck_debugMode
if (blck_debugLevel > 2) then
{
	diag_log format ["_fnc_cleanEmptyGroups:: -- >> group count = %1 ",(count allGroups)];
	diag_log format ["_fnc_cleanEmptyGroups:: -- >> Group count AI side = %1", call blck_fnc_groupsOnAISide];
};
#endif

private _grp = allGroups;
{
	//diag_log format["_fnc_cleanEmptyGroups:: - >> type of object _x = %1",typeName _x];
	if ((count units _x) isEqualTo 0) then {deleteGroup _x};
}forEach _grp;
#ifdef blck_debugMode
if (blck_debugLevel > 2) then {diag_log "_fnc_cleanEmptyGroups::  -- >> exiting function";};
#endif
