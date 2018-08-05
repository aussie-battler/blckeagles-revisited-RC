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

if (!isServer) exitWith {};
blck_fnc_countGroupsAssigned = {
	params["_HC"];
	private["_result"];
	_result = {(groupOwner _x) == (owner _HC)} count allGroups;
	//diag_log format["_fnc_countGroupsAssigned = %1",_result];
	_result
};


//diag_log format["_fnc_passToHCs:: function called at server time %1",diag_tickTime];
private["_numTransfered","_clientId","_allGroups","_groupsOwned","_idHC","_id","_swap","_rc"];
_numTransfered = 0;
_idHC = -2;
blck_connectedHCs = call blck_fnc_HC_getListConnected;  //  Double check on this function; seems overly complicated.
//diag_log format["_fnc_passToHCs:: blck_connectedHCs = %1 | count _HCs = %2 | server FPS = %3",blck_connectedHCs,count blck_connectedHCs,diag_fps];
if ( (count blck_connectedHCs) > 0) then
{
	_idHC = [blck_connectedHCs] call blck_fnc_HC_leastBurdened;
	//diag_log format["passToHCs: evaluating passTos for HC %1 || owner HC = %2",_idHC, owner _idHC];
	{
		// Pass the AI

		if (_x getVariable["blck_group",false]) then 
		{
			//diag_log format["group belongs to blckeagls mission system so time check if we should transfer it"];
			//diag_log format["Owner of group %1 is %2",_x,groupOwner _x];
			if ((groupOwner _x) == 2) then 
			{
				//diag_log format["blckeagls group %1 is on the server: we should be moved to HC %2 with _idHC %3",_x,_idHC];
				//_x setVariable["owner",owner _idHC];				
				//_x setVariable["Group",group (driver _x)),true]
				private _sgor = _x setGroupOwner (owner _idHC);
				//diag_log format["setGroupOwner returned %1",_sgor];
				//diag_log format["_veh %1 variable owner set to %2",getVariable _veh["owner",-1]];
				//diag_log format["_veh %1 Group set to %2",_veh getVariable["Group",grpNull]];
				if (_sgor) then
				{
					[_x] remoteExec["blck_fnc_HC_XferGroup",_idHC];
					_numTransfered = _numTransfered + 1;
					//diag_log format["group %1 transferred to %2",_x, groupOwner _x];
				} else {
					//diag_log format["something went wrong with the transfer of group %1",_x];
				};
			};
		} else {
			//diag_log format["group %1 does not belong to blckeagls mission system",_x];
		};
	} forEach (allGroups);
	diag_log format["[blckeagls] _passToHCs:: %1 groups transferred to HC %2",_numTransfered,_idHC];
	//_numTransfered = 0;
	// Note : the owner of a vehicle is the owner of the driver so vehicles are automatically transferred to the HC when the group to which the driver is assigned is transferred.

} else {
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then {diag_log "_fnc_passToHCs:: No headless clients connected"};
	#endif
};
