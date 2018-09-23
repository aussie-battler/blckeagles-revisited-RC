

	params["_objClassName","_objPosn",["_objDir",0],["_enableSimulation",true],["_enableDamage",true],["_enableRopes",true],["_mode","NONE"]];
    //diag_log format["_fnc_spawnSingleObject: _objClassName = %1 | _objPosn = %2 | _objPosn = %3",_objClassName,_objPosn,_objDir];
	private _obj = createVehicle[_objClassName,_objPosn,[],0,_mode];
	_obj setDir _objDir;
    _obj allowDamage _enableDamage;
    _obj enableDynamicSimulation _enableSimulation;
    //diag_log format["created object %1 at %2 heading %3",_obj,getPosATL _obj, getDir _obj];
	_obj