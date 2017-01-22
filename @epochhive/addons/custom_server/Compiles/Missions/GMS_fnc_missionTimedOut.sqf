/*
	[_blck_localMissionMarker, _coords, _objects] call blck_fnc_missionTimedOut;
*/
params["_blck_localMissionMarker", "_coords", "_objects"];

//["timeOut",_endMsg,_blck_localMissionMarker select 2] call blck_fnc_messageplayers;
[_blck_localMissionMarker select 0] execVM "debug\deleteMarker.sqf";
_blck_localMissionMarker set [1,[0,0,0]];
_blck_localMissionMarker set [2,""];
blck_ActiveMissionCoords = blck_ActiveMissionCoords - [ _coords];
[_objects, 1] spawn blck_fnc_cleanupObjects;