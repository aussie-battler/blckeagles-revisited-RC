// pull trader cities from config
/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if (blck_modType isEqualTo "Epoch") then
{
	_blckListPrior = blck_locationBlackList;
	private _config = configFile >> "CfgEpoch";
	private _configWorld = _config >> worldname;
	private _telePos = getArray(configFile >> "CfgEpoch" >> worldName >> "telePos" );
	//diag_log format["[blckeagls] _fnc_getTraderCities:  _config = %1 | _configWorld = %2",_config,_configWorld];
	//diag_log format["[blckegle] _fnc_getTraderCities: count _telePos = %1 || _telepos = %2",count _telePos,_telePos];
	//if (true) exitWith {};
	{
		blck_locationBlackList pushback [_x select 3, 1000];
		#ifdef blck_debugMode
		if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getTraderCitiesEpoch:: -- >> Added epoch trader city location at %1", (_x select 3)];};
		#endif
	} foreach _telePos;  // (getArray(_configWorld >> "telePos"));
	diag_log format["[blckeagls] blckListPrior = %1",_blckListPrior];
	diag_log format["[blckeagls] ] blck_locationBlackList = %1",blck_locationBlackList];
};

if (blck_modType isEqualTo "Exile") then
{
	if (blck_blacklistTraderCities || blck_blacklistSpawns || blck_listConcreteMixerZones) then 
	{
		private _traderCites = allMapMarkers;
		private _tc = [];
		{
			//if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Evaluating Markertype of %1", (getMarkerType _x)];};
			if (getMarkerType _x isEqualTo "ExileTraderZone" && blck_blacklistTraderCities) then {
				blck_locationBlackList pushback [(getMarkerPos _x),1000];
				#ifdef blck_debugMode
				if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Trader location at %1", (getMarkerPos _x)];};
				#endif
			};
				
			if ((getMarkerType _x isEqualTo "ExileSpawnZone") && blck_blacklistSpawns) then {
				blck_locationBlackList pushback [(getMarkerPos _x),1000];
				#ifdef blck_debugMode
				if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Spawn location at %1", (getMarkerPos _x)];};
				#endif			
			};
			//  
			if (getMarkerType _x isEqualTo "ExileConcreteMixerZone" && blck_listConcreteMixerZones) then {
				blck_locationBlackList pushback [(getMarkerPos _x),1000];
				#ifdef blck_debugMode
				if (blck_debugON) then {diag_log format["[blckeagls]  _fnc_getExileLocations :: -- >> Added Exile Concrete Mixer location at %1", (getMarkerPos _x)];};
				#endif			
			};	
		}forEach _traderCites;
	};
};
