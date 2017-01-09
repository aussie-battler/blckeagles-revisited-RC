/*
	Original Code by blckeagls
	Modified by Ghostrider
	Logic for adding AI Ammo, GL Shells and Attachments addapted from that by Buttface (A3XAI).
	Infinite Ammo fix by Narines.
	Code to delete dead AI bodies moved to AIKilled.sqf
	Everything having to do with spawning and configuring an AI should happen here
	Last Modified 11/12/16
*/

//Defines private variables so they don't interfere with other scripts
private ["_pos","_i","_weap","_ammo","_other","_skin","_aiGroup","_ai1","_magazines","_players","_owner","_ownerOnline","_nearEntities","_skillLevel","_aiSkills","_specialItems",
		"_Launcher","_launcherRound","_vest","_index","_WeaponAttachments","_Meats","_Drink","_Food","_aiConsumableItems","_weaponList","_ammoChoices","_attachment","_attachments",
		"_headGear","_uniforms","_pistols","_specialItems","_noItems"];

params["_pos","_weaponList","_aiGroup",["_skillLevel","red"],["_Launcher","none"],["_uniforms", blck_SkinList],["_headGear",blck_headgear],["_underwater",false]];
//_pos = _this select 0;  // Position at which to spawn AI
//_weaponList = _this select 1;  // List of weapons with which to arm the AI
//_aiGroup = _this select 2;  // Group to which AI belongs
//_skillLevel = [_this,3,"red"] call BIS_fnc_param;   // Assign a skill level in case one was not passed."blue", "red", "green", "orange"
//_Launcher = [_this, 4, "none"] call BIS_fnc_param; // Set launchers to "none" if no setting was passed.
//_uniforms = [_this, 5, blck_SkinList] call BIS_fnc_param;  // skins to add to AI
//_headGear =  [_this, 6, _shemag]  call BIS_fnc_param;// headGear to add to AI

if (isNull _aiGroup) exitWith {diag_log "[blckeagls] ERROR CONDITION:-->> NULL-GROUP Provided to _fnc_spawnUnit"};

_ai1 = ObjNull;
_modType = call blck_fnc_getModType;
if (_modType isEqualTo "Epoch") then
{
	"I_Soldier_EPOCH" createUnit [_pos, _aiGroup, "_ai1 = this", 0.7, "COLONEL"];
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
		case "blue":{_ai1 setVariable["ExileMoney",floor(random(blck_maxMoneyBlue)),true];};
		case "red":{_ai1 setVariable["ExileMoney",floor(random(blck_maxMoneyRed)),true];};
		case "green":{_ai1 setVariable["ExileMoney",floor(random(blck_maxMoneyGreen)),true];};
		case "orange":{_ai1 setVariable["ExileMoney",floor(random(blck_maxMoneyOrange)),true];};
	};
};
[_ai1] call blck_fnc_removeGear;
_skin = "";
_counter = 1;
while {_skin isEqualTo "" && _counter < 10} do
{
	_skin = selectRandom _uniforms;  // call BIS_fnc_selectRandom;
	//_ai1 forceAddUniform _skin;
	_ai1 forceAddUniform _skin;
	_skin = uniform _ai1;
	//diag_log format["_fnc_spawnUnit::-->> for unit _ai1 % uniform is %2",_ai1, uniform _ai1];
	_counter =+1;
};
//Stops the AI from being cleaned up
_ai1 setVariable["DBD_AI",1];

//Sets AI Tactics
_ai1 enableAI "TARGET";
_ai1 enableAI "AUTOTARGET";
_ai1 enableAI "MOVE";
_ai1 enableAI "ANIM";
_ai1 enableAI "FSM";
_ai1 allowDammage true;
_ai1 setBehaviour "COMBAT";
_ai1 setunitpos "AUTO";

if (_modType isEqualTo "Epoch") then
{
	// do this so the AI or corpse hangs around on Epoch servers.
	_ai1 setVariable ["LAST_CHECK",28800,true];
};

_ai1 addHeadgear (selectRandom _headGear);
// Add a vest to AI for storage
//_vest = selectRandom blck_vests;  // call BIS_fnc_selectRandom;
_ai1 addVest selectRandom blck_vests;

if ( random (1) < blck_chanceBackpack) then
{
	//_bpck = selectRandom blck_backpack;  
	_ai1 addBackpack selectRandom blck_backpacks;
};

_weap = selectRandom _weaponList;  

_ai1 addWeaponGlobal  _weap; 
_ammoChoices = getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
//_muzzles = getArray (configFile >> "CfgWeapons" >> _weap >> "muzzles");
_optics = getArray (configfile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
_pointers = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
_muzzles = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
_underbarrel = getArray (configFile >> "CfgWeapons" >> _weap >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
_legalOptics = [];
{
	if !(_x in blck_blacklistedOptics) then {_legalOptics pushback _x};
}forEach _optics;
_ammo = selectRandom _ammoChoices;  
//diag_log format["[spawnUnit.sqf] _ammo returned as %1",_ammo];
for "_i" from 2 to (floor(random 3)) do {
	_ai1 addMagazine _ammo;
};
//if (random 1 < 0.3) then {_unit addPrimaryWeaponItem (selectRandom _muzzles)};
_ai1 addPrimaryWeaponItem (selectRandom _legalOptics); 
_ai1 addPrimaryWeaponItem (selectRandom  _pointers);
_ai1 addPrimaryWeaponItem (selectRandom _muzzles);
_ai1 addPrimaryWeaponItem (selectRandom _underbarrel);
if ((count(getArray (configFile >> "cfgWeapons" >> _weap >> "muzzles"))) > 1) then {
	_ai1 addMagazine "1Rnd_HE_Grenade_shell";
};

_weap = selectRandom blck_Pistols;
//diag_log format["[spawnUnit.sqf] _weap os %1",_weap];
_ai1 addWeaponGlobal  _weap; 
_ammoChoices = getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
_ai1 addMagazine selectRandom _ammoChoices;

//add random items to AI.  _other = ["ITEM","COUNT"]
for "_i" from 1 to (1+floor(random(3))) do {
	_i = _i + 1;
	_ai1 addItem (selectRandom blck_ConsumableItems);
};

// Add an First Aid or Grenade 50% of the time
if (round(random 10) <= 5) then 
{
	//_item = selectRandom blck_specialItems;
	//diag_log format["spawnUnit.sqf] -- Item is %1", _item];
	_ai1 addItem selectRandom blck_specialItems;
};

if (_Launcher != "none") then
{
	private["_bpck"];
	_ai1 addWeaponGlobal _Launcher;
	for "_i" from 1 to 3 do 
	{
		_ai1 addItemToBackpack (getArray (configFile >> "CfgWeapons" >> _Launcher >> "magazines") select 0); // call BIS_fnc_selectRandom;
	};
	_ai1 setVariable["Launcher",_launcher];
};

if(sunOrMoon < 0.2 && blck_useNVG)then
{
	_ai1 addWeapon selectRandom blck_NVG;
	_ai1 setVariable ["hasNVG", true];

}
else
{
	_ai1 setVariable ["hasNVG", false];
};

// Infinite ammo
_ai1 addeventhandler ["fired", {(_this select 0) setvehicleammo 1;}];
_ai1 addEventHandler ["killed",{ [(_this select 0), (_this select 1)] call compile preprocessfilelinenumbers blck_EH_AIKilled;}]; // changed to reduce number of concurrent threads, but also works as spawn blck_AIKilled; }];
//_ai addEventHandler ["HandleDamage",{ [(_this select 0), (_this select 1)] execVM blck_EH_AIHandleDamage;}];

switch (_skillLevel) do 
{
	case "blue": {_index = 0;_aiSkills = blck_SkillsBlue;};
	case "red": {_index = 1;_aiSkills = blck_SkillsRed;};
	case "green": {_index = 2;_aiSkills = blck_SkillsGreen;};
	case "orange": {_index = 3;_aiSkills = blck_SkillsOrange;};
	default {_index = 0;_aiSkills = blck_SkillsBlue;};
};

//_alertDist = blck_AIAlertDistance select _index; 
//_intelligence = blck_AIIntelligence select _index;

[_ai1,_aiSkills] call blck_fnc_setSkill;
_ai1 setVariable ["alertDist",blck_AIAlertDistance select _index,true];
_ai1 setVariable ["intelligence",blck_AIIntelligence select _index,true];
_ai1 setVariable ["GMS_AI",true,true];

_ai1


