/*
  Spawn and configure a group
	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 1/22/17
*/

private["_numbertospawn","_groupSpawned","_safepos","_weaponList","_useLauncher","_launcherType"];	

params["_pos", ["_numai1",5], ["_numai2",10], ["_skillLevel","red"], "_center", ["_minDist",20], ["_maxDist",35], ["_uniforms",blck_SkinList], ["_headGear",blck_headgear] ];
if (blck_debugLevel > 1) then
{
	diag_log format["[blckeagls] _fnc_spawnGroup called parameters: _numai1 %1, _numbai2 %2, _skillLevel %3, _center %4",_numai1,_numai2,_skillLevel,_center];
};
//Spawns correct number of AI
if (_numai2 > _numai1) then {
	_numbertospawn = floor( (random (_numai2 - _numai1) + _numai1 ) );
} else {
	_numbertospawn = _numai2;
};
if (blck_debugLevel  > 1) then
{
	diag_log format["spawnGroup.sqf:  _numbertospawn = %1",_numbertospawn];
};

_groupSpawned = createGroup blck_AI_Side; 
if !(isNull _groupSpawned) then
{
	if (blck_debugLevel  > 1) then {diag_log format["_fnc_spawnGroup::  -- >> Group created = %1",_groupSpawned]};
	_groupSpawned setcombatmode blck_combatMode;
	_groupSpawned allowfleeing 0;
	_groupSpawned setspeedmode "FULL";
	_groupSpawned setFormation blck_groupFormation; 
	_groupSpawned setVariable ["blck_group",true,true];

	//diag_log format["spawnGroup:: group is %1",_groupSpawned];
	// Determines whether or not the group has launchers
	_useLauncher = blck_useLaunchers;

	// define weapons list for the group
	switch (_skillLevel) do {
		case "blue": {_weaponList = blck_WeaponList_Blue;};
		case "red": {_weaponList = blck_WeaponList_Red;};
		case "green": {_weaponList = blck_WeaponList_Green;};
		case "orange": {_weaponList = blck_WeaponList_Orange;};
		default {_weaponList = blck_WeaponList_Blue;};
	};


	//Spawns the correct number of AI Groups, each with the correct number of units
	//Counter variable
	_i = 0;
	while {_i < _numbertospawn} do {
		_i = _i + 1;
		if (blck_useLaunchers && _i <= blck_launchersPerGroup) then
		{
			_launcherType = selectRandom blck_launcherTypes;
		} else {
			_launcherType = "none";
		};
		
		//Finds a safe positon to spawn the AI in the area given
		_safepos = [_pos,0,30,2,0,20,0] call BIS_fnc_findSafePos;

		//Spawns the AI unit
		 //diag_log format["spawnGroup:: spawning unit #%1",_i];
		 //  params["_pos","_weaponList","_aiGroup",["_skillLevel","red"],["_Launcher","none"],["_uniforms",blck_SkinList],["_headGear",blck_BanditHeadgear]];
		[_safepos,_weaponList,_groupSpawned,_skillLevel,_launcherType,_uniforms,_headGear] call blck_fnc_spawnAI;
	};
	_groupSpawned selectLeader (units _groupSpawned select 0);
	[_pos,_minDist,_maxDist,_groupSpawned] spawn blck_fnc_setupWaypoints;

	//diag_log format["fnc_spawnGroup:: Group spawned was %1 with units of %2",_groupSpawned, units _groupSpawned];
} else {
	diag_log "_fnc_spawnGroup:: ERROR CONDITION : NULL GROUP CREATED";
};
_groupSpawned
