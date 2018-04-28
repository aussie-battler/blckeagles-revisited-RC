
//_fn_destroyVehicleAndCrew = {
	params["_veh"];
	//private["_crew"];
	//_crew = crew _veh;
	//diag_log format["_fn_destroyVehicleAndCrew: called for _veh = %1",_veh];
	{[_x] call blck_fnc_deleteAI;} forEach (crew _veh);
	[_veh] call blck_fnc_deleteAIvehicle;
