/*
	for ghostridergaming
	By Ghostrider [GRG]
	Copyright 2016

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

#include "\q\addons\custom_server\Configs\blck_defines.hpp";

blck_blacklistedVests = [

];

blck_blacklistedUniforms = [

];

blck_blacklistedBackpacks = [

];

blck_blacklistedHeadgear = [

];

blck_blacklistedPrimaryWeapons = [

];

blck_blacklistedSecondaryWeapons = [

];

blck_blacklistedLaunchersAndSwingWeapons = [

];

blck_blacklistedOptics = [

];

blck_blacklistedAttachments = [

];

blck_blacklistedItems = [

];

blck_headgearList = [];
blck_SkinList = [];
blck_vests = [];
blck_backpacks = [];
blck_Pistols = [];
blck_primaryWeapons = [];
//blck_throwable = [];

_allWeaponRoots = ["Pistol","Rifle","Launcher"];
_allWeaponTypes = ["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","Pistol","SubmachineGun","Handgun","MissileLauncher","RocketLauncher","Throw","GrenadeCore"];
_addedBaseNames = [];
_allBannedWeapons = [];
_wpnAR = []; //Assault Rifles
_wpnARG = []; //Assault Rifles with GL
_wpnLMG = []; //Light Machine Guns
_wpnSMG = []; //Sub Machine Guns
_wpnDMR = []; //Designated Marksman Rifles
_wpnLauncher = [];
_wpnSniper = []; //Sniper rifles
_wpnHandGun = []; //HandGuns/Pistols
_wpnShotGun = []; //Shotguns
_wpnThrow = []; // throwables
_wpnUnknown = []; //Misc
_wpnUnderbarrel = [];
_wpnMagazines = [];
_wpnOptics = [];
_wpnPointers = [];
_wpnMuzzles = [];
_allBannedWearables = [];
_uniforms = [];
_headgear = []; 
_glasses = []; 
_masks = []; 
_backpacks = []; 
_vests = [];
_goggles = []; 
_NVG = []; 
_misc = [];
_baseClasses = [];	

_classnameList = [];
diag_log format["blck_modType = %1",blck_modType];
if (blck_modType isEqualTo "Epoch") then
{
	_classnameList = (missionConfigFile >> "CfgPricing" ) call BIS_fnc_getCfgSubClasses;
};
if (blck_modType isEqualTo "Exile") then
{
	_classnameList = (missionConfigFile >> "CfgExileArsenal" ) call BIS_fnc_getCfgSubClasses;
};
diag_log format["_fnc_dynamicConfigsConfigurator: count _classnameList = %1",count _classnameList];
{
	private _temp = [_x] call bis_fnc_itemType;
	//diag_log _temp;
	_itemCategory = _temp select 0;
	_itemType = _temp select 1;
	_price = 1000000;
	if (blck_modType isEqualTo "Epoch") then
	{
		_price = getNumber(missionConfigFile >> "CfgPricing" >> _x >> "price");
	};
	if (blck_modType isEqualTo "Exile") then
	{
		_price = getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price");
	};
	//diag_log format["_fnc_dynamicConfigsConfigurator: _price = %1",_price];
	if (_price < blck_maximumItemPriceInAI_Loadouts) then
	{
	//if (_itemCategory != "") then {diag_log format["_fnc_dynamicConfigsConfigurator: _itemCategory = %1 | _itemType = %2",_itemCategory,_itemType]};
	if (_itemCategory isEqualTo "Weapon") then
	{
		switch (_itemType) do
		{
			case "AssaultRifle": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnAR pushBack _x}};
			case "MachineGun": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnLMG pushBack _x}};
			case "SubmachineGun": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnSMG pushBack _x}};
			case "Shotgun": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnShotGun pushBack _x}};
			case "Rifle": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnAR pushBack _x}};
			case "SniperRifle": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnSniper pushBack _x}};
			case "Handgun": {if !(_x in blck_blacklistedSecondaryWeapons) then {_wpnHandGun pushBack _x}};
			case "Launcher": {if !(_x in blck_blacklistedLaunchersAndSwingWeapons) then {_wpnLauncher pushBack _x}};
			case "RocketLauncher": {if !(_x in blck_blacklistedLaunchersAndSwingWeapons) then {_wpnLauncher pushBack _x}};
			case "Throw": {if !(_x in blck_blacklistedItems) then {_wpnThrow pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
		};
	};
	
	if (_itemCategory isEqualTo "Item") then
	{
		//diag_log format["Evaluating Item class name %1",_x];
		switch (_itemType) do
		{
			case "AccessoryMuzzle": {if !(_x in blck_blacklistedAttachments) then {_wpnMuzzles pushBack _x}};
			case "AccessoryPointer": {if !(_x in blck_blacklistedAttachments) then {_wpnPointers pushBack _x}};
			case "AccessorySights": {if !(_x in blck_blacklistedOptics) then {_wpnOptics pushBack _x}};
			case "AccessoryBipod": {if !(_x in blck_blacklistedAttachments) then {_wpnUnderbarrel pushBack _x}};
			case "Binocular": {if !(_x in blck_blacklistedItems) then {_misc pushBack _x}};
			case "Compass": {if !(_x in blck_blacklistedItems) then {_misc pushBack _x}};
			case "GPS": {if !(_x in blck_blacklistedItems) then {_misc pushBack _x}};
			case "NVGoggles": {if !(_x in blck_blacklistedItems) then {_NVG pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};
			//case "": {if !(_x in ) then { pushBack _x}};			
		};
	};
	
	
	if (_itemCategory isEqualTo "Equipment") then
	{
		//diag_log format["Evaluating Equipment class name %1",_x];
		switch (_itemType) do
		{
			case "Glasses": {if !(_x in blck_blacklistedItems) then {_glasses pushBack _x}};
			case "Headgear": {if !(_x in blck_blacklistedHeadgear) then {_headgear pushBack _x}};
			case "Vest": {if !(_x in blck_blacklistedVests) then {_vests pushBack _x}};
			case "Uniform": {if !(_x in blck_blacklistedUniforms) then {_uniforms pushBack _x}};
			case "Backpack": {if !(_x in blck_blacklistedBackpacks) then {_backpacks pushBack _x}};
		};
	};
	};
} forEach _classnameList;

blck_primaryWeapons = _wpnAR + _wpnLMG + _wpnSMG + _wpnShotGun + _wpnSniper;
blck_WeaponList_Blue = blck_primaryWeapons;
blck_WeaponList_Red = blck_primaryWeapons;
blck_WeaponList_Green = blck_primaryWeapons;
blck_WeaponList_Orange = blck_primaryWeapons;

blck_pistols = _wpnHandGun;
blck_Pistols_blue = blck_Pistols;
blck_Pistols_red = blck_Pistols;
blck_Pistols_green = blck_Pistols;
blck_Pistols_orange = blck_Pistols;

blck_headgearList = _headgear;
blck_headgear_blue = blck_headgearList;
blck_headgear_red = blck_headgearList;
blck_headgear_green = blck_headgearList;
blck_headgear_orange = blck_headgearList;
	
blck_SkinList = _uniforms;
blck_SkinList_blue = blck_SkinList;
blck_SkinList_red = blck_SkinList;
blck_SkinList_green = blck_SkinList;
blck_SkinList_orange = blck_SkinList;

blck_vests = _vests;
blck_vests_blue = blck_vests;
blck_vests_red = blck_vests;
blck_vests_green = blck_vests;
blck_vests_orange = blck_vests;

blck_backpacks = _backpacks;
blck_backpacks_blue = blck_backpacks;
blck_backpacks_red = blck_backpacks;
blck_backpacks_green = blck_backpacks;
blck_backpacks_orange = blck_backpacks;
	
blck_explosives = 	_wpnThrow;

blck_configsLoaded = true;
