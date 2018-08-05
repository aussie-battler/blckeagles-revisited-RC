
/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_veh"];
	blck_monitoredVehicles = blck_monitoredVehicles - [_veh];
	//diag_log format["_fnc_releaseVehicleToPlayersl: _veh = %1 | (owner _veh) = %2",_veh,(owner _veh)];
	//diag_log format["_fnc_releaseVehicleToPlayersl: initial lock state of vehicle 51 = %2",_veh,locked _veh];
	//_veh setVehicleLock "UNLOCKED" ;
	_locked = true;
	_count = 0;
	_timeIn = diag_tickTime;
	while {_count < 2} do 
	{
		//diag_log format["_fnc_releaseVehicleToPlayersl: attempting to unlock vehicle %1",_veh];
		[_veh,"UNLOCKED"] remoteExec ["setVehicleLock",0];  //  unlock on all clients so we don't have to worry about any change of ownership when the driver is ejected. 
															// a bit of bandwidth seems worth ensuring that vehicles do in fact get unlocked.
		uiSleep 0.1;
		_count = _count + 1;
		diag_log format["_fnc_releaseVehicleToPlayersl: locked state of vehicle %1 = ^%2",_veh, locked _veh];
		//if ((_veh locked) isEqualTo "UNLOCKED" || (diag_tickTime - _timeIn) > 5) then {_locked = false};
	};
	//  {player setAmmo [primaryWeapon player, 1];} remoteExec ["bis_fnc_call", 0]; 
	//{[_veh setVehicleLock "UNLOCKED"];} remoteExec ["BIS_fnc_call",(owner _veh)];
	{
		_veh removealleventhandlers _x;
	} forEach ["GetIn","GetOut","fired","hit","hitpart","reloaded","dammaged","HandleDamage"];
	{
		_veh removeAllMPEventHandlers _x;
	} forEach ["MPHit","MPKilled"];
	_veh setVariable["blck_DeleteAt",diag_tickTime + blck_vehicleDeleteTimer,true];
	if ((damage _veh) > 0.6) then {_veh setDamage 0.6};

	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_veh];
	};
	#endif
//diag_log format["_fnc_vehicleMonitor:: case of patrol vehicle released to players where vehicle = %1",_veh];