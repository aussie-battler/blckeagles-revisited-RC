params["_name","_owner"];
diag_log format["_fnc_onPlayerDisconnected triggered with _name = %1 and _owner = %2",_name,_owner];
private["_HCownerids","_groupLocalEH","_vehicleLocalEH"];
// Remove the name of the HC from the list of active, connected HCs
if (toLower(_name) isEqualTo "headlessclient") then
{
	diag_log "_fnc_onPlayerDisconnected: a headless client disconnected, time to deal with the damage";
	_entities = entities "Headlessclient_F";
	_blck_connectedHCs = +blck_connectedHCs;
	_HCownerids = [];
	{
		if !(_x in _entities) then
		{
			// If the HC is not in the list of connected SC then delete it from the list maintained separately by blckeagls.
			blck_connectedHCs = blck_connectedHCs - [_x];
		} else {
			// Grab the owner ids for currently connected HCs.
			_HCownerids pushBack (owner _x);
		};
	}forEach _blck_connectedHCs;

	// Check whether there are any groups assigned to an owner that is not connected and deal with it
	{
		if !(_x getVariable["owner",0] in _HCownerids) then
		{
			diag_log format["_fnc_onPlayerDisconnected:: reseting eventHandlers for group %1",_x];
			// do any cleanup; at present this is simply removing locally added event handlers
			_groupLocalEH = _x getVariable["localEH",[]];
			{
				_x removeEventHandler _x;
			}forEach _groupLocalEH;
			_x setVariable["localEH",nil,true];
		};
	}forEach allGroups;
	{
		if !(_x getVariable["owner",0] in _HCownerids) then
		{
			diag_log format["_fnc_onPlayerDisconnected:: reseting eventHandlers for vehicle %1",_x];
			// do any cleanup; at present this is simply removing locally added event handlers
			_vehicleLocalEH = _x getVariable["localEH",[]];
			{
				_x removeEventHandler _x;
			}forEach _vehicleLocalEH;	
			_x setVariable["localEH",nil,true];			
		};
	}forEach blck_monitoredVehicles;	
};