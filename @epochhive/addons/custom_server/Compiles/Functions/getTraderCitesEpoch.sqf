// pull trader cities from config

if !(blck_blacklistTraderCities) exitWith {};
diag_log format["[blckeagls]  Adding Trader Cities to blacklisted locations based on setting for blck_blacklistTraderCities = %1",blck_blacklistTraderCities];
_traderCites = allMapMarkers;

{
	if (_x in ["center","respawn_east","respawn_west","respawn_north"] && blck_blacklistTraderCities) then
	{
		blck_locationBlackList pushback [getMarkerPos _x,1000];
		//if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getTraderCitiesEpoch:: -- >> Added epoch trader city location at %1", (getMarkerPos _x)];};
	};
}forEach _traderCites;
