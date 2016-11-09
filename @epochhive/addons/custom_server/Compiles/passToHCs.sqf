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

if (!isServer || !blck_useHC) exitWith {};

diag_log "passToHCs: Started";

//waitUntil {!isNil "HC"};
//waitUntil {!isNull HC};
_wait = true;
while {_wait} do{
	if (isNil "HC1") then
	{
		diag_log "passToHCs:  HC not connected";
	}	else 	{
		diag_log format["passToHCs:  owner HC1 = %1", owner HC1];
		_wait = false;
	};
	sleep 15;
};


_HC1_ID = -1; // Will become the Client ID of HC
_HC2_ID = -1; // Will become the Client ID of HC2
_HC3_ID = -1; // Will become the Client ID of HC3
rebalanceTimer = 10;  // Rebalance sleep timer in seconds
cleanUpThreshold = 200; // Threshold of number of dead bodies + destroyed vehicles before forcing a clean up

diag_log format["passToHCs: First pass will begin in %1 seconds", rebalanceTimer];

while {true} do {
   uisleep rebalanceTimer;
   try {
    _HC1_ID = owner HC1;

    if (_HC1_ID > 2) then {
      diag_log format ["passToHCs: Found HC with Client ID %1", _HC1_ID];
    } else { 
      diag_log "passToHCs: [WARN] HC disconnected";

      HC1 = objNull;
      _HC1_ID = -1;
    };
  } catch { diag_log format ["passToHCs: [ERROR] [HC] %1", _exception]; HC = objNull; _HC1_ID = -1; };
  {
    if (!isNull HC1) then 
	{
		// Pass the AI
		_numTransfered = 0;
		
		if (_x getVariable["blck_group",false]) then {
			diag_log format["group belongs to blckeagls mission system so time to transfer it"];
			_id = groupOwner _x;
			diag_log format["Owner of group %1 is %2",_x,_id];
			if (_id > 2) then 
			{
				diag_log format["group %1 is already assigned to an HC with _id of %2",_x,_id];
				_swap = false;
			} else {
				if (_numTransfered < 5) then
				{
				diag_log format["group %1 should be moved to an HC",_x];
				_rc = _x setGroupOwner _HC1_ID;
				if ( _rc ) then { _numTransfered = _numTransfered + 1; };
				};
			};
			
		} else {
			diag_log format["group %1 does not belong to blckeagls mission system",_x];
		};

  } forEach (allGroups);
};