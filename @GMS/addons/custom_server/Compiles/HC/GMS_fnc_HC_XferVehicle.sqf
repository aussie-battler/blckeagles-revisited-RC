diag_log format["_fnc_HC_XferVehicle:: _this = %1",_this];
private["_veh","_tempEH","_localEH"];
_veh = _this select 0;
_tempEH = ["HandleDamage",_veh addMPEventHandler["HandleDamage",{ [_this] call compile preprocessFileLineNumbers blck_EH_AIVehicle_HandleDamage}]];
_localEH = [_tempEH];
_veh setVariable["localEH",_tempEH,true];
