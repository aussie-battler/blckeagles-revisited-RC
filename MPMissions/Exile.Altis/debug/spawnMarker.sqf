////////////////////////////////////////////
// Create Mission Markers that are visible to JIP players
// 8/3/17
// by Ghostrider-DbD-
//////////////////////////////////////////
// spawn a round marker of a size and color specified in passed parameters

private["_blck_fn_configureRoundMarker"];

private["_blck_fn_configureRoundMarker"];
_blck_fn_configureRoundMarker = {
	private["_name","_pos","_color","_size","_MainMarker","_labelType"];
	params["_name","_pos","_color","_text","_size","_labelType"];

	// Do not show the marker if it is in the left upper corner
	if ((_pos distance [0,0,0]) < 10) exitWith {};
	
	_MainMarker = createMarker [_name, _pos];
	_MainMarker setMarkerColor _color;
	_MainMarker setMarkerShape "ELLIPSE";
	_MainMarker setMarkerBrush "Grid";
	_MainMarker setMarkerSize _size; //
	if (count toArray(_text) > 0) then
	{
		switch (_labelType) do {
			case "arrow":
			{
				_name = "label" + _name;
				_textPos = [(_pos select 0) + (count toArray (_text) * 12), (_pos select 1) - (_size select 0), 0];
				_MainMarker = createMarker [_name, _textPos];
				_MainMarker setMarkerShape "Icon";
				_MainMarker setMarkerType "HD_Arrow";
				_MainMarker setMarkerColor "ColorBlack";
				_MainMarker setMarkerText _text;
				};
			case "center": 
			{
				_name = "label" + _name;
				_MainMarker = createMarker [_name, _pos];
				_MainMarker setMarkerShape "Icon";
				_MainMarker setMarkerType "mil_dot";
				_MainMarker setMarkerColor "ColorBlack";
				_MainMarker setMarkerText _text;
				};
			};
	};
};

_blck_fn_configureIconMarker = {
	private["_MainMarker"];
	params["_name","_pos",["_color","ColorBlack"],["_text",""],["_icon","mil_triangle"]];
	
	_name = "label" + _name;
	_MainMarker = createMarker [_name, _pos];
	_MainMarker setMarkerShape "Icon";
	_MainMarker setMarkerType _icon;
	_MainMarker setMarkerColor _color;
	_MainMarker setMarkerText _text;	
};

params["_mArray"];

_mArray params["_missionType","_markerPos","_markerLabel","_markerLabelType","_markerColor","_markerType"];
_markerType params["_mShape","_mSize","_mBrush"];
if ((_markerType select 0) in ["ELIPSE","RECTANGLE"]) then // not an Icon .... 
{		
	switch (_missionType) do {
		// params["_missionType","_pos","_text","_labelType","_color","_type","_size","_brush"];
		// Type					Size				Brush
		default {[_missionType,_markerPos,_markerColor,_markerLabel, _mSize,_markerLabelType,_mShape,_mBrush] call _blck_fn_configureRoundMarker;};
	};
};
if !((_markerType select 0) in ["ELIPSE","RECTANGLE"]) then 
{  //  Deal with case of an icon
	[_missionType,_markerPos, _markerColor,_markerLabel,_markerType select 0] call _blck_fn_configureIconMarker;
};