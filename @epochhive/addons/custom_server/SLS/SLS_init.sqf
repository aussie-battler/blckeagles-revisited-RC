/*
	Static loot crate spawner
	by Ghostrider-DbD-
	For Arma 3 Exile and Epoch
	Last Updated 11/12/16
	Written to be independent of blckeagles functions for now.
	However, as written it relies on variables defined in in the configurations files for Epoch / Exile for blckeagls.
	It could easily be addapted to other purposes.
*/

if not (isNull( configFile >> "CfgPatches" >> "a3_epoch_server" )) then
{
	[] execVM "\q\addons\custom_server\SLS\SLS_init_epoch.sqf";
};

if not (isNull ( configFile >> "CfgPatches" >> "exile_server" ) ) then
{
	[] execVM "q\addons\custom_server\SLS\SLS_init_exile.sqf";
};