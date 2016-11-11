// Adds a bipod, optic and suppressor to AI weapons.
// 11/11/16

_bipods = ["bipod_01_F_blk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_blk","bipod_03_F_oli"];

params["_unit"];
_wep = primaryWeapon _unit;
_muzzles = = getArray (configFile >> "CfgWeapons" >> _wep >> "muzzles");
_optics = configfile >> "CfgWeapons" >> _wep >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems";

if (random 1 < 0.3) then {_unit addPrimaryWeaponItem (selectRandom _muzzles)};
if (random 1 < 0.3) then {_unit addPrimaryWeaponItem (selectRandom _optics; _unit addPrimaryWeaponItem (selectRandom  _bipods);};





