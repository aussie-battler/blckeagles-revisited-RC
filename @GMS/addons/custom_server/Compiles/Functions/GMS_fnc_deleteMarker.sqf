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
private["_markerName"];
_markerName = _this select 0;
deleteMarker _markerName;
_markerName = "label" + _markerName;
deleteMarker _markerName;
//diag_log format["deleteMarker complete script for _this = %1",_this];
