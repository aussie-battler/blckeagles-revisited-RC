/*
	blck_fnc_spawnUnit
	Original Code by blckeagls
	Modified by Ghostrider

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private ["_i","_weap","_skin","_ai1","_skillLevel","_aiSkills","_launcherRound","_index","_ammoChoices","_modType","_optics","_pointers","_muzzles","_underbarrel","_legalOptics"];
params["_pos","_aiGroup",["_skillLevel","red"],["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_vests",blck_vests],["_backpacks",blck_backpacks],["_Launcher","none"],["_weaponList",[]],["_sideArms",[]],["_scuba",false]];
#ifdef blck_debugMode
if (blck_debugLevel > 2) then
{
	private _params = ["_pos","_aiGroup","_skillLevel","_uniforms","_headGear","_vests","_backpacks","_Launcher","_weaponList","_sideArms","_scuba"];  //"_weaponList",  "_Launcher"
	{
		diag_log format["_fnc_spawnUnit::-> _this select %1 (%2) = %3",_forEachIndex, _params select _forEachIndex, _this select _forEachIndex];
	}forEach _this;
	//{
		//diag_log format["_fnc_spawnUnit:: _this select %1 = %2",_forEachIndex,_x];
	//}forEach _this;
};
#endif
if (isNull _aiGroup) exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnUnit"};

_ai1 = ObjNull;
_modType = call blck_fnc_getModType;
if (_modType isEqualTo "Epoch") then
{
	"I_Soldier_EPOCH" createUnit [_pos, _aiGroup, "_ai1 = this", blck_baseSkill, "COLONEL"];
	_ai1 setVariable ["LAST_CHECK",28800,true];
	switch(_skillLevel) do
	{
		case "blue":{_ai1 setVariable["Crypto",1 + floor(random(blck_maxMoneyBlue)),true];};
		case "red":{_ai1 setVariable["Crypto",2 + floor(random(blck_maxMoneyRed)),true];};
		case "green":{_ai1 setVariable["Crypto",3 + floor(random(blck_maxMoneyGreen)),true];};
		case "orange":{_ai1 setVariable["Crypto",4 + floor(random(blck_maxMoneyOrange)),true];};
	};
};
if (_modType isEqualTo "Exile") then
{
	"i_g_soldier_unarmed_f" createUnit [_pos, _aiGroup, "_ai1 = this", blck_baseSkill, "COLONEL"];
	switch(_skillLevel) do
	{
		case "blue":{_ai1 setVariable["ExileMoney",2 + floor(random(blck_maxMoneyBlue)),true];};
		case "red":{_ai1 setVariable["ExileMoney",4 + floor(random(blck_maxMoneyRed)),true];};
		case "green":{_ai1 setVariable["ExileMoney",6 + floor(random(blck_maxMoneyGreen)),true];};
		case "orange":{_ai1 setVariable["ExileMoney",8 + floor(random(blck_maxMoneyOrange)),true];};
	};
};
#ifdef blck_debugMode
if (blck_debugLevel >= 2) then
{
	diag_log format["_fnc_spawnUnit::-->> unit spawned = %1",_ai1];
};
#endif
[_ai1] call blck_fnc_removeGear;
if (_scuba) then
{
	_ai1 swiminDepth (_pos select 2);
	#ifdef blck_debugMode
	if (blck_debugLevel >= 2) then
	{
		diag_log format["_fnc_spawnUnit:: -- >> unit depth = %1 and underwater for unit = %2",_pos select 2, underwater _ai1];
	};
	#endif
};
_skin = "";
_counter = 1;
diag_log format["_fnc_spawnUnit: _uniforms = %1",_uniforms];
while {_skin isEqualTo "" && _counter < 10} do
{
	_ai1 forceAddUniform (selectRandom _uniforms);
	_skin = uniform _ai1;
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["_fnc_spawnUnit::-->> for unit _ai1 % uniform is %2",_ai1, uniform _ai1];
	};
	#endif	
	_counter =+1;
};
//Sets AI Tactics
_ai1 enableAI "ALL";
_ai1 allowDammage true;
_ai1 setBehaviour "COMBAT";
_ai1 setunitpos "AUTO";

if (count _headGear > 0) then {_ai1 addHeadgear (selectRandom _headGear)};
if (count _vests > 0) then {_ai1 addVest (selectRandom _vests)};
if (count _weaponList isEqualTo 0) then {_weaponList = call blck_fnc_selectAILoadout};
_weap = selectRandom _weaponList;  
_ai1 addWeaponGlobal  _weap; 
_ammoChoices = getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
_optics = getArray (configfile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
_pointers = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
_muzzles = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
_underbarrel = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
_legalOptics = _optics - blck_blacklistedOptics;

_ai1 addMagazines [selectRandom _ammoChoices, 3];

if (random 1 < 0.4) then {_ai1 addPrimaryWeaponItem (selectRandom _muzzles)};
if (random 1 < 0.4) then {_ai1 addPrimaryWeaponItem (selectRandom _legalOptics)};
if (random 1 < 0.4) then {_ai1 addPrimaryWeaponItem (selectRandom _pointers)};
if (random 1 < 0.4) then {_ai1 addPrimaryWeaponItem (selectRandom _muzzles)};
if (random 1 < 0.4) then {_ai1 addPrimaryWeaponItem (selectRandom _underbarrel)};
if ((count(getArray (configFile >> "cfgWeapons" >> _weap >> "muzzles"))) > 1) then 
{
	_ai1 addMagazine "1Rnd_HE_Grenade_shell";
};

if (count _sideArms > 0) then
{
	_weap = selectRandom _sideArms;
	//diag_log format["[spawnUnit.sqf] _weap os %1",_weap];
	_ai1 addWeaponGlobal  _weap; 
	_ammoChoices = getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
	_ai1 addMagazines [selectRandom _ammoChoices, 2];
};
for "_i" from 1 to (1+floor(random(4))) do 
{
	_ai1 addItem (selectRandom blck_ConsumableItems);
};

// Add  First Aid or Grenade 50% of the time
if (round(random 10) <= 5) then 
{
	//diag_log format["spawnUnit.sqf] -- Item is %1", _item];
	_ai1 addItem selectRandom blck_specialItems;
};

if (_Launcher != "none" and (count _backpacks > 0)) then
{
	private["_bpck"];
	_ai1 addWeaponGlobal _Launcher;
	_ai1 addBackpack (selectRandom _backpacks);
	for "_i" from 1 to 3 do 
	{
		_ai1 addItemToBackpack (getArray (configFile >> "CfgWeapons" >> _Launcher >> "magazines") select 0); // call BIS_fnc_selectRandom;
	};
	_ai1 setVariable["Launcher",_launcher,true];
} else {
	if ( random (1) < blck_chanceBackpack and (count _backpacks > 0)) then
	{ 
		_ai1 addBackpack selectRandom _backpacks;
	};
};

if(sunOrMoon < 0.2 && blck_useNVG)then
{
	_ai1 addWeapon selectRandom blck_NVG;
	_ai1 setVariable ["hasNVG", true,true];
}
else
{
	_ai1 setVariable ["hasNVG", false,true];
};

#ifdef blck_debugMode
if (blck_debugLevel > 2) then
{
	diag_log format["_fnc_spawnUnit:: --> unit loadout = %1", getUnitLoadout _ai1];
};
#endif

_ai1 addEventHandler ["Reloaded", {_this call compile preprocessfilelinenumbers blck_EH_unitWeaponReloaded;}];
_ai1 addMPEventHandler ["MPKilled", {[(_this select 0), (_this select 1)] call compile preprocessfilelinenumbers blck_EH_AIKilled;}]; // changed to reduce number of concurrent threads, but also works as spawn blck_AIKilled; }];
_ai1 addMPEventHandler ["MPHit",{ [_this] call compile preprocessFileLineNumbers blck_EH_AIHit;}];

switch (_skillLevel) do 
{
	case "blue": {_index = 0;_aiSkills = blck_SkillsBlue;};
	case "red": {_index = 1;_aiSkills = blck_SkillsRed;};
	case "green": {_index = 2;_aiSkills = blck_SkillsGreen;};
	case "orange": {_index = 3;_aiSkills = blck_SkillsOrange;};
	default {_index = 0;_aiSkills = blck_SkillsBlue;};
};

[_ai1,_aiSkills] call blck_fnc_setSkill;
_ai1 setVariable ["alertDist",blck_AIAlertDistance select _index,true];
_ai1 setVariable ["intelligence",blck_AIIntelligence select _index,true];
_ai1 setVariable ["GMS_AI",true,true];

_ai1


