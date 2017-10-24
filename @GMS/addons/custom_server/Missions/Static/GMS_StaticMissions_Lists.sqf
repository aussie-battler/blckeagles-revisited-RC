/*
	Run scripts exported from M3EDEN Editor plug in for Arma 3 or other map addons. 
	Add addons to the arrays for Epoch or Exile as appropriate.
	Arrays should contain ["mapname", "name of folder within mapaddons","name of file to execute"]
	by Ghostrider-DbD-
	8/15/17
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

if (!isServer) exitWith{};

private ["_staticMissions"];

_staticMissions = [
	// [mod (Epoch, Exile), map (Altis, Tanoa etc), mission center, eg [10445,2014,0], filename.sqf (name of static mission template for that mission)];
	//["Epoch","Altis","\q\addons\custom_server\Missions\Static\staticMissionExample1.sqf"],
	//["Exile","Altis","\q\addons\custom_server\Missions\Static\missions\staticMissionExample1.sqf"]
];

diag_log "[blckeagls] GMS_StaticMissions_Lists.sqf <Loaded>";
