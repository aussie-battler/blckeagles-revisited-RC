/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
//#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private _clientId = clientOwner;
private _groupsOwned = {groupOwner _x isEqualTo _clientId)} count allGroups;
//diag_log format["_fnc_HC_groupsAssigned:: %1 groups running on client %2",_groupsOwned,_clientId];
_groupsOwned
//[_clientId,_groupsOwned] remoteExec ["blck_fnc_updateClientGroupCounts",2];

