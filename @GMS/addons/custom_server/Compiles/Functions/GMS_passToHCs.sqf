if (!isServer) exitWith {};
blck_fnc_countGroupsAssigned = {
	params["_HC"];
	private["_result"];
	_result = {(groupOwner _x) == (owner _HC)} count allGroups;
	//diag_log format["_fnc_countGroupsAssigned = %1",_result];
	_result
};
blck_fnc_leastBurdened = {
	params["_HC_List"];
	private["_result","_fewestGroupsAssigned","_leastBurdened","_groupsAssigned"];
	if (count _HC_List == 0) exitWith {_result = objNull; _result};
	_fewestGroupsAssigned = [_HC_List select 0] call blck_fnc_countGroupsAssigned;
	_leastBurdened = _HC_List select 0;
	{
		_groupsAssigned = [_x] call blck_fnc_countGroupsAssigned;
		if (_groupsAssigned < _fewestGroupsAssigned) then 
		{
			_leastBurdened = _x;
			_fewestGroupsAssigned = _groupsAssigned;
		};
	}forEach _HC_List;
	//diag_log format["_fnc_leastBurdened:: _fewestGroupsAssigned = %1 and _leastBurdened = %2",_fewestGroupsAssigned,_leastBurdened];
	_leastBurdened
};
//diag_log format["_fnc_passToHCs:: function called at server time %1",diag_tickTime];
private["_numTransfered","_clientId","_allGroups","_groupsOwned","_idHC","_id","_swap","_rc"];
{
	if !(_x in blck_connectedHCs) then {blck_connectedHCs pushBack _x};
}forEach entities "HeadlessClient_F";
diag_log format["_fnc_passToHCs:: blck_connectedHCs = %1  with count _HCs = %2",blck_connectedHCs,count blck_connectedHCs];
if ((count blck_connectedHCs) > 0) then
{
	_idHC = [blck_connectedHCs] call blck_fnc_leastBurdened;
	//diag_log format["passToHCs: evaluating passTos for HC %1 || owner HC = %2",_idHC, owner _idHC];
	{
		// Pass the AI
		_numTransfered = 0;
		if (_x getVariable["blck_group",false]) then 
		{
			//diag_log format["group belongs to blckeagls mission system so time to transfer it"];
			if ((typeName _x) isEqualTo "GROUP") then
			{
				_id = groupOwner _x;
				//diag_log format["Owner of group %1 is %2",_x,_id];
				if (_id > 2) then 
				{
					//diag_log format["group %1 is already assigned to an HC with _id of %2",_x,_id];
					_swap = false;
				} else {
					diag_log format["group %1 should be moved to HC %2 with _idHC %3",_x,_idHC];
					_x setVariable["owner",owner _idHC];				
					_rc = _x setGroupOwner (owner _idHC);
					[_x] remoteExec["blck_fnc_HC_XferGroup",_idHC];
					if ( _rc ) then 
					{
						_numTransfered = _numTransfered + 1;
						//diag_log format["group %1 transferred to %2",_x, groupOwner _x];
					} else {
						//diag_log format["something went wrong with the transfer of group %1",_x];
					};
				};
			};
		} else 
		{
			//diag_log format["group %1 does not belong to blckeagls mission system",_x];
		};
	} forEach (allGroups);
	diag_log format["_passToHCs:: %1 groups transferred to HC %2",_numTransfered,_idHC];
	_numTransfered = 0;
	/*
	{
		if (typeName _x isEqualTo "GROUP") then {_idHC = groupOwner _x};
		if (typeName _x isEqualTo "OBJECT") then {_idHC = owner _x};
		if (_idHC > 2) then
		{
				//diag_log format["vehicle %1 is already assigned to an HC with _id of %2",_x,_id];
				_swap = false;		
		} else {
			//diag_log format["vehicle %1 should be moved to an HC",_x];
			_x setVariable["owner",_idHC];	
			if (typeOf _x isEqualTo "GROUP") then {_rc = _x setGroupOwner _idHC};
			if (typeOf _x isEqualTo "OBJECT") then {_rc = _x setOwner _idHC};			
				[_x] remoteExec["blck_fnc_HC_XferVehicle",_idHC];
			if ( _rc ) then 
			{
				_numTransfered = _numTransfered + 1;
				//diag_log format["group %1 transferred to %2",_x, groupOwner _x];
			} else {
				//diag_log format["something went wrong with the transfer of group %1",_x];
			};		
		};
	}forEach blck_monitoredVehicles;
	*/
	diag_log format["_passToHCs:: %1 vehicles transferred",_numTransfered];
} else {
	diag_log "_fnc_passToHCs:: No headless clients connected";
};
