
/*
GMS_fnc_addCustomMarker.sqf
adds a custom marker to the array of custom markers that should be shown.
*/

params["_marker"];
_type = [];
if (typeName _marker select 3 isEqualTo "STRING") then {_type = [_marker select 3,[],""]};
if (typeName _marker select 3 isEqualTo "ARRAY" and count (_marker select 3) isEqualTo 3) then {_type = _marker select 3};
private _m = [format["cm%1%2",_marker select 0 select 0,_marker select 0 select 1],_marker select 0,_marker select 1,_marker select 2,"",_marker select 4,_type];
diag_log format["customMarkers_Epoch.sqf:: _m = %1",_m];
if !(_type isEqualTo []) then 
{
	blck_customMarkers pushback _m;
};

true


