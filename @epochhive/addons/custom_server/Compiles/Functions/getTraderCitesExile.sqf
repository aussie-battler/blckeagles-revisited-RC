// pull trader cities from config
private _traderCites = allMapMarkers;
_tc = [];
{
	if (getMarkerType _x isEqualTo "ExileTraderZone" && blck_blacklistTraderCities) then {
		blck_locationBlackList pushback [(getMarkerPos _x),1000];
		if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Trader location at %1", (getMarkerPos _x)];};
	};
		
	if ((getMarkerType _x isEqualTo "ExileSpawnZone") && blck_blacklistSpawns) then {
		blck_locationBlackList pushback [(getMarkerPos _x),1000];
		if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Spawn location at %1", (getMarkerPos _x)];};
	};
	//  
	if (getMarkerType _x isEqualTo "ExileConcreteMixerZone" && blcklistConcreteMixerZones) then {
		blck_locationBlackList pushback [(getMarkerPos _x),1000];
		if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Concrete Mixer location at %1", (getMarkerPos _x)];};
	};	
}forEach _traderCites;