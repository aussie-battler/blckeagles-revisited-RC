/*
	Run scripts exported from M3EDEN Editor plug in for Arma 3 or other map addons. 
	Add addons to the arrays for Epoch or Exile as appropriate.
	Arrays should contain ["mapname", "name of folder within mapaddons","name of file to execute"]
	by Ghostrider-DbD-
	for DBD Clan
	11/12/16
*/
if (!isServer) exitWith{};
_addonsPath = "\q\addons\custom_server\MapAddons\mapcontent\";
_addonsEpoch = [
	//["mapName","subfolder","filename.sqf"]
	// when "subfolder" equals "" then the spawner will look for the file in the mapcontent directory 
	// See the examples below for an idea as to how to set these arrays up.
	/*
	["Altis","Altis","trader_ATMs.sqf"],
	["Altis","Altis","DBD_EPOCH_Altis_Dump_SH.FINAL.sqf"],
	["Altis","Altis","altis_epoch_beach_SH-DBD_final.sqf"],
	["Tanoa","Tanoa","tanoaatmmil.sqf"]
	*/
];

_addonsExile = [
	/*
	["Altis","Altis","altis_epoch_beach_SH-DBD_final.sqf"],
	["Altis","Altis","DBD_EPOCH_Altis_Dump_SH.FINAL.sqf"],
	["Altis","Altis","packStronghold-1.sqf"],
	["Altis","Altis","packStrongholdMolos.sqf"],
	["Namalsk","Namalsk","namalsklockers.sqf"]	
	*/
];


_fnc_runIt = 
{
	params["_addons"];
	if (blck_debugON) then {diag_log format["[blckeagls] MapAddons:: addons list is %1",_addons];};
	_worldName = toLower (worldName);
	{
		if (toLower format["%1",_x select 0] isEqualTo _worldName) then
		{
			_path = "";
			if ( (_x select 1) isEqualTo "") then 
			{
				_path = _addonsPath;
			} else {
				_path = format["%1%2%3",_addonsPath,_x select 1,"\"];
			};
			if (blck_debugON) then {diag_log format["[blckeagls] MapAddons::-->> Running the following script: %1%2",_path,_x select 2];};
			[] execVM format["%1%2",_path,_x select 2];
		};
	}forEach _addons;
};
_modType = call blck_getModType;
if (_modType isEqualTo "Epoch") then
{
	diag_log "[blckeagls] Running Map Addons for Epoch";
	[_addonsEpoch] call _fnc_runIt;
};
if (_modType isEqualTo "Exile") then
{
	diag_log "[blckeagls] Running Map Addons for Epoch";
	[_addonsExile] call _fnc_runIt;
};