diag_log "--  >> Loading Custom Markers for blckeagls Mission System";

blck_customMarkers = [];
blck_fnc_addCustomMarker = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\CustomMarkers\GMS_fnc_addCustomMarker.sqf";

if (!isServer) exitWith{};

_modType = call blck_getModType;
if (_modType isEqualTo "Epoch") then
{
	[] execVM "\q\addons\custom_server\Compiles\CustomMarkers\CustomMarkers_Epoch.sqf";
};

if (_modType isEqualTo "Exile") then
{
	[] execVM "\q\addons\custom_server\Compiles\CustomMarkers\CustomMarkers_Exile.sqf";
};

{
	[_x] execVM "debug\spawnMarker.sqf";
}forEach blck_customMarkers;

diag_log "-- >> Custom Markers Loaded";