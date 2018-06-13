/*
	by Ghostrider [GRG]

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";
params["_array","_patrolInformation"];
waitUntil {blck_sm_monitoring isEqualTo 0};
_array pushBack [
	_patrolInformation,
	grpNull,
	0, //  spawned at
	0, // respawn at
	0  // last time a player was nearby
];
_array
