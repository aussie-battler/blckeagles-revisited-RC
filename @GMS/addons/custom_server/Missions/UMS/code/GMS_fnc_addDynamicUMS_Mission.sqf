/*
	by Ghostrider [GRG]
	for ghostridergaming
	12/5/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_pos"];
diag_log format["_fnc_addDynamicUMS_Mission: _pos = %1",_pos];
private["_UMS_mission","_waitTime","_mission"];
_UMS_mission = selectRandom blck_dynamicUMS_MissionList;
_waitTime = (blck_TMin_UMS) + random(blck_TMax_UMS - blck_TMin_UMS);
_mission = format["%1%2","Mafia Pirates",floor(random(1000000))];
//_pos = call blck_fnc_findShoreLocation;
blck_UMS_ActiveDynamicMissions pushBack _pos;
blck_missionsRunning = blck_missionsRunning + 1;
blck_dynamicUMS_MissionsRuning = blck_dynamicUMS_MissionsRuning + 1;
//diag_log format["[blckeagls] UMS Spawner:-> waiting for %1",_waitTime];
uiSleep _waitTime;
//diag_log format["[blckeagls] UMS Spawner:-> spawning mission %1",_UMS_mission];
[_pos,_mission] spawn compileFinal preprocessFileLineNumbers format["q\addons\custom_server\Missions\UMS\dynamicMissions\%1",_UMS_mission];