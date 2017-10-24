/*
	Run scripts exported from M3EDEN Editor plug in for Arma 3 or other map addons. 
	Add addons to the arrays for Epoch or Exile as appropriate.
	Arrays should contain ["mapname", "name of folder within mapaddons","name of file to execute"]
	by Ghostrider-DbD-
	for DBD Clan
	11/12/16
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

//blck_fnc_sm_checkForPlayerNearMission = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\StaticMissions_checkForPlayerNearMission.sqf";
blck_fnc_sm_spawnAirPatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnAirPatrols.sqf";
blck_fnc_sm_spawnEmplaced = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnEmplaced.sqf";
blck_fnc_sm_spawnInfantryPatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnInfantryPatrols.sqf";
blck_fnc_sm_spawnLootContainers = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnLootContainers.sqf";
blck_fnc_sm_spawnObjects = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnObjects.sqf";
blck_fnc_sm_spawnVehiclePatrols = compileFinal  preprocessFileLineNumbers "\q\addons\custom_server\Missions\Static\Code\GMS_sm_spawnVehiclePatrols.sqf";

diag_log "[blckeagls] GMS_sm_init_functions.sqf <Loaded>";

blck_sm_functionsLoaded = true;