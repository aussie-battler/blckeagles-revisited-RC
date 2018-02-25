/*
  Set Alive AI Count
*/

params["_mArray","_count"];

_mArray params["_missionType","_markerPos","_markerLabel","_markerLabelType","_markerColor","_markerType"];

//diag_log "++++++++++++++--- marker label arrow detected";
_name = "ai_count" + _name;
_textPos = [(_pos select 0) + (count toArray (_text) * 12), (_pos select 1) + (_size select 0), 0];
_MainMarker = createMarker [_name, _textPos];
_MainMarker setMarkerShape "Icon";
_MainMarker setMarkerType "HD_Arrow";
_MainMarker setMarkerColor "ColorBlack";
_MainMarker setMarkerText format["% Alive",_count];

//_MainMarker setMarkerDir 37;