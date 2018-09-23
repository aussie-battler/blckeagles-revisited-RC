

    params["_center","_landscape"];
   // diag_log format["fnc_spawnMissionLandscapeRelative: _center = %1",_center];
    private["_obj","_objects"];
    _objects = [];
    {
        _x params["_objClassName","_objRelPos","_objDir"];
        _obj = [_objClassName, _objRelPos vectorAdd _center, _objDir,enableSimulationForObject,enableDamageForObject,enableRopesforObject,"CAN_COLLIDE"] call blck_fnc_spawnSingleObject;
        _objects pushBack _obj;
    }forEach _landscape;
    _landscape