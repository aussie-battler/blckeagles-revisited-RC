

    params["_center","_emplaced","_garrisonGroup"];
    private["_obj","_objects"];
    _group = call blck_fnc_create_AI_Group;
    _objects = [];
    {
        _x params["_objClassName","_objRelPos","_objDir"];
        _obj = [_objClassName, [0,0,0],0] call blck_fnc_spawnSingleObject;
        _objects pushBack _obj;
        _obj setPosATL (_objRelPos vectorAdd _center);
        _obj setDir _objDir;
        _unit = [_group] call blck_fnc_spawnUnit;
        _unit moveInGunner _unit;         
        _wep addMPEventHandler["MPHit",{ [_this] call compile preprocessFileLineNumbers blck_EH_AIVehicle_HandleDamage}];
        //_empGroup setVariable["groupVehicle",_wep];
        //_wep setVariable["vehicleGroup",_empGroup];
        _wep setVariable["GRG_vehType","emplaced"];	
        [_wep,false] call blck_fnc_configureMissionVehicle;	        
    }forEach _emplaced;
    blck_monitoredVehicles append _emplacedWeps;
    _return = [_emplacedWeps,_group,_abort];
    _return