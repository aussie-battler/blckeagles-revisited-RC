////////////////////////////////////////////
// Delete and change Mission Markers
// 8/3/17
// by Ghostrider-DbD-
//////////////////////////////////////////
// delete a marker

private["_markerName"];
_markerName = _this select 0;
_markerName = "label" + _markerName;
deleteMarker _markerName;

