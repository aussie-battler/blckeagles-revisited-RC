if (isNil "CENTER") exitWith {systemChat "Please define the mission center"};

_obj = [];
_cb = "";
_mo = allMissionObjects "All";
{
	_line = format["[%1,%2,%3]",typeOf _x, (CENTER vectorDiff (getPosASL _x)),getDir _x];
	systemChat format["%1",_line];
	_obj pushBack _line;
	_cb = _cb + format["%1,%2",_line,endl];
}forEach _mo;
copyToClipboard _cb;
_msg = format["Objects formated for output and copied to clipboard at %1",diag_tickTime];
systemChat _msg;
hint _msg;
