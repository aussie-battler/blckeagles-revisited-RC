/*
 * passToHCs.sqf
 *
 * In the mission editor, name the Headless Clients "HC", "HC2", "HC3" without the quotes
 *
 * In the mission init.sqf, call passToHCs.sqf with:
 * execVM "passToHCs.sqf";
 *
 * It seems that the dedicated server and headless client processes never use more than 20-22% CPU each.
 * With a dedicated server and 3 headless clients, that's about 88% CPU with 10-12% left over.  Far more efficient use of your processing power.
 *
 */

_clientId = clientOwner;
_allGroups = allGroups;
_groupsOwned = {groupOwner _x isEqualTo _clientId)} count allGroups;
[_clientId,_groupsOwned] remoteExec ["blck_fnc_updateClientGroupCounts",2];
diag_log format["_fnc_HC_groupsAssigned:: %1 groups running on client %2",_groupsOwned,_clientId];
