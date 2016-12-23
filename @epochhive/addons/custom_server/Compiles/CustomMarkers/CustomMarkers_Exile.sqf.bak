
blck_customMarkers = [];
blck_fnc_addCustomMarker = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Compiles\CustomMarkers\GMS_fnc_addCustomMarkers.sqf";
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

}forEach blck_customMarkers;
