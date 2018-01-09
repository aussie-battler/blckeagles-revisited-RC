////////////////////////////////////////////
// Delete and change Mission Markers
// 7/10/15
// by Ghostrider-DbD-
//////////////////////////////////////////
// delete a marker

//diag_log format["blck_fnc_deleteMarker:: _this = %1",_this];
private["_markerName"];
_markerName = _this select 0;
deleteMarker _markerName;
_markerName = "label" + _markerName;
deleteMarker _markerName;
//diag_log format["deleteMarker complete script for _this = %1",_this];
