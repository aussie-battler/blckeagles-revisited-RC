/*
	Adds the basic list of parameters that define a mission such as the marker name, mission list, mission path, AI difficulty, and timer settings, to the arrays that the main thread inspects.
	
	by Ghostrider-DbD-
	Last modified 1-21-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//private _mission = _this;
//diag_log format["_fnc_addMissionToQue::  -- >>  _mission - %1",_mission];
//    0                     1           2          3           4             5 
//  [_missionListOrange,_pathOrange,"OrangeMarker","orange",blck_TMin_Orange,blck_TMax_Orange,] 
params["_missionList","_path","_marker","_difficulty","_tMin","_tMax",["_noMissions",1],["_allowReinforcements",true]];

for "_i" from 1 to _noMissions do
{
	private _waitTime = diag_tickTime + (_tMin) + random((_tMax) - (_tMin));
						// 0		  1		2						3			4		5		6		7	   8
	private _mission = [_missionList,_path,format["%1%2",_marker,_i],_difficulty,_tMin,_tMax,_waitTime,[0,0,0],_allowReinforcements];
	if (blck_debugLevel > 0) then {diag_log format["-fnc_addMissionToQue::-->> _mission = %1",_mission];};
	blck_pendingMissions  pushback _mission;
};

if (blck_debugLevel > 1) then {diag_log format["_fnc_addMissionToQue::  -- >> Result - blck_pendingMissions = %1",blck_pendingMissions];};
