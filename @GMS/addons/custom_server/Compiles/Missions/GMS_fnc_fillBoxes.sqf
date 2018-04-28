
/*
	for ghostridergaming
	By Ghostrider [GRG]
	Fill a crate with items
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	private["_a1","_item","_diff","_tries"];
	params["_crate","_boxLoot","_itemCnts"];
	//diag_log format["_fnc_fillBoxes: _this = %1",_this];
	#ifdef blck_debugMode
	{
		diag_log format["_fnc_fillBoxes: _this select %1 = %2",_foreachindex, _this select _foreachindex];
	}foreach _this;
	#endif
	_itemCnts params["_wepCnt","_magCnt","_opticsCnt","_materialsCnt","_itemCnt","_bkcPckCnt"];
	_tries = [_wepCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (26): loading %1 weapons",_wepCnt];
	if (_tries > 0) then
	{
		_a1 = _boxLoot select 0; // choose the subarray of weapons and corresponding magazines
		// Add some randomly selected weapons and corresponding magazines
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];
			if (typeName _item isEqualTo "ARRAY") then  //  Check whether weapon name is part of an array that might also specify an ammo to use
			{ 
				_crate addWeaponCargoGlobal [_item select 0,1];  // if yes then assume the first element in the array is the weapon name
				if (count _item >1) then {  // if the array has more than one element assume the second is the ammo to use.
					_crate addMagazineCargoGlobal [_item select 1, 1 + round(random(3))];
				} else { // if the array has only one element then lets load random ammo for it
					_crate addMagazineCargoGlobal [selectRandom (getArray (configFile >> "CfgWeapons" >> (_item select 0) >> "magazines")), 1 + round(random(3))];
				};
			} else {
				if (_item isKindOf ["Rifle", configFile >> "CfgWeapons"]) then
				{
					_crate addWeaponCargoGlobal [_item, 1];
					_crate addMagazineCargoGlobal [selectRandom (getArray (configFile >> "CfgWeapons" >> _item >> "magazines")), 1 + round(random(3))];
				};
			};
		};
	};
	_tries = [_magCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (26): loading %1 magazines",_magCnt];	
	if (_tries > 0) then
	{	
	// Add Magazines, grenades, and 40mm GL shells
		_a1 = _boxLoot select 1;
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];
			if (typeName _item isEqualTo "ARRAY") then
			{
				_diff = (_item select 2) - (_item select 1);  // Take difference between max and min number of items to load and randomize based on this value
				_crate addMagazineCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];
			};
			if (typeName _item isEqualTo "STRING") then
			{
				_crate addMagazineCargoGlobal [_item, 1];
			};
		};
	};
	_tries = [_opticsCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (72): loading %1 weapons",_wepCnt];	
	if (_tries > 0) then
	{
		// Add Optics
		_a1 = _boxLoot select 2;
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];
			if (typeName _item isEqualTo "ARRAY") then
			{
				_diff = (_item select 2) - (_item select 1); 
				_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];		
			};
			if (typeName _item isEqualTo "STRING") then
			{
				_crate addItemCargoGlobal [_item,1];
			};
		};
	};
	_tries = [_materialsCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (92): loading %1 materials",_materialsCnt];	
	if (_tries > 0) then
	{
		// Add materials (cindar, mortar, electrical parts etc)
		_a1 = _boxLoot select 3;
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];
			if (typeName _item isEqualTo "ARRAY") then
			{
				_diff = (_item select 2) - (_item select 1); 
				_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];
			};
			if (typeName _item isEqualTo "STRING") then
			{
				_crate addItemCargoGlobal [_item, 1];
			};
		};
	};
	_tries = [_itemCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (112): loading %1 items",_itemCnt];	
	if (_tries > 0) then
	{
		// Add Items (first aid kits, multitool bits, vehicle repair kits, food and drinks)
		_a1 = _boxLoot select 4;
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];
			if (typeName _item isEqualTo "ARRAY") then
			{
				_diff = (_item select 2) - (_item select 1); 
				_crate additemCargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];		
			};
			if (typeName _item isEqualTo "STRING") then
			{
				_crate addItemCargoGlobal [_item, 1];
			};
		};
	};	
	_tries = [_bkcPckCnt] call blck_fnc_getNumberFromRange;
	//diag_log format["_fnc_fillBoxes (132): loading %1 backpacs",_bkcPckCnt];	
	if (_tries > 0) then
	{
		_a1 = _boxLoot select 5;
		for "_i" from 1 to _tries do {
			_item = selectRandom _a1;
			//diag_log format["_fnc_fillBoxes: _item = %1",_item];			
			if (typeName _item isEqualTo "ARRAY") then
			{
				_diff = (_item select 2) - (_item select 1); 
				_crate addbackpackcargoGlobal [_item select 0, (_item select 1) + round(random(_diff))];
			};
			if (typeName _item isEqualTo "STRING") then
			{
				_crate addbackpackcargoGlobal [_item, 1];
			};
		};
	};

	//diag_log "_fnc_fillBoxes <END>";