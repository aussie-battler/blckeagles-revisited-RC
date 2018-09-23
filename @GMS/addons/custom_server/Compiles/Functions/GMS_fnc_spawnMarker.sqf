/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_blck_fn_configureRoundMarker"];
_blck_fn_configureRoundMarker = {
	//diag_log format["_blck_fn_configureRoundMarker: _this = %1",_this];
	//  [[""OrangeMarker1"",[11736.1,9272.76,0],""Soylent Green"",""center"",""ColorPink"",[""ellipse"",[250,250],""Cross""]]]"
	private["_name","_pos","_color","_size","_MainMarker","_arrowMarker","_labelMarker","_labelType"];
	// [_missionType,_markerPos,_markerColor,_markerLabel, _mSize,_markerLabelType,_mShape,_mBrush]
	params["_name","_pos","_color","_text","_size","_labelType","_mShape","_mBrush"];
	if ((_pos distance [0,0,0]) < 10) exitWith {};
	
	_MainMarker = createMarker [_name, _pos];
	_MainMarker setMarkerColor _color;
	_MainMarker setMarkerShape "ELLIPSE";
	_MainMarker setMarkerBrush "Grid";
	_MainMarker setMarkerSize _size; //
	//diag_log format["_blck_fn_configureRoundMarker: -: _labelType = %1", _labelType];
	if (count toArray(_text) > 0) then
	{
		switch (_labelType) do {
			case "arrow":
			{
				//diag_log "++++++++++++++--- marker label arrow detected";
				_name = "label" + _name;
				_textPos = [(_pos select 0) + (count toArray (_text) * 12), (_pos select 1) - (_size select 0), 0];
				_arrowMarker = createMarker [_name, _textPos];
				_arrowMarker setMarkerShape "Icon";
				_arrowMarker setMarkerType "HD_Arrow";
				_arrowMarker setMarkerColor "ColorBlack";
				_arrowMarker setMarkerText _text;
				//_MainMarker setMarkerDir 37;
				};
			case "center": 
			{
				//diag_log "++++++++++++++--- marker label dot detected";
				_name = "label" + _name;
				_labelMarker = createMarker [_name, _pos];
				_labelMarker setMarkerShape "Icon";
				_labelMarker setMarkerType "mil_dot";
				_labelMarker setMarkerColor "ColorBlack";
				_labelMarker setMarkerText _text;
				};
			};
	};
	if (isNil "_labelMarker") then {_labelMarker = ""};
	_labelMarker
};

_blck_fn_configureIconMarker = {
	private["_MainMarker"];
	//diag_log format["_blck_fn_configureIconMarker: _this = %1",_this];
	params["_name","_pos",["_color","ColorBlack"],["_text",""],["_icon","mil_triangle"]];
	_name = "label" + _name;
	_MainMarker = createMarker [_name, _pos];
	_MainMarker setMarkerShape "Icon";
	_MainMarker setMarkerType _icon;
	_MainMarker setMarkerColor _color;
	_MainMarker setMarkerText _text;	
	_MainMarker
};

//diag_log format["spawnMarker::  --  >> _this = %1",_this];
params["_mArray"];
private["_marker"];
_mArray params["_missionMarkerName","_markerPos","_markerLabel","_markerLabelType","_markerColor","_markerTypeInfo"];
//  add defaults to provide backward compatibility for older missions that do not specify a brush.
_markerTypeInfo params["_mShape",["_mSize",[0,0]],["_mBrush","GRID"]];
//diag_log format["spawnMarker.sqf::  --  >> _missionMarkerName %1 | _markerPos %2 | _markerLabel %3 | _markerLabelType %4 | _markerColor %5 | _markerTypeInfo %6 | _mShape %7",_missionMarkerName,_markerPos,_markerLabel,_markerLabelType,_markerColor,_markerTypeInfo,_mShape];

if (toUpper(_mShape) in ["ELIPSE","ELLIPSE","RECTANGLE"]) then // not an Icon .... 
{		
	_marker = [_missionMarkerName,_markerPos,_markerColor,_markerLabel, _mSize,_markerLabelType,_mShape,_mBrush] call _blck_fn_configureRoundMarker;
};
if !(toUpper(_mShape) in ["ELIPSE","ELLIPSE","RECTANGLE"]) then 
{  
	_marker = [_missionMarkerName,_markerPos, _markerColor,_markerLabel,_mShape] call _blck_fn_configureIconMarker;
};
//diag_log format["spawnMarker complete script with _marker = %1",_marker];
if (isNil "_marker") then {_marker = ""};
_marker
