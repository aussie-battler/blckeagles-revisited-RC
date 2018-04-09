/*
	by Ghostrider

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

private["_missionType","_wasRunover","_launcher","_legal"];
params["_unit","_killer"];
#ifdef blck_debugMode
if (blck_debugLevel > 1) then {diag_log format["##-processIlleagalAIKills.sqf-## processing illeagal kills for unit %1",_unit]};
#endif
_launcher = _unit getVariable ["Launcher",""];
_legal = true;

_fn_targetVehicle = {  // force AI to fire on the vehicle with launchers if equiped
	params["_unit","_vk"];
	private["_unit"];
	{
		if ( ( (getPos _vk) distance2d (getPos _x) ) < 500 ) then 
		{
			_x reveal [_vk, 4];
			_x dowatch _vk; 
			_x doTarget _vk; 
		};
	} forEach (call blck_fnc_allPlayers);
};

_fn_applyVehicleDamage = {  // apply a bit of damage 
	private["_vd"];
	params["_vk"];
	_vd = getDammage _vk;
	_vk setDamage (_vd + blck_RunGearDamage);
};

_fn_deleteAIGear = {
	params["_ai"];
	{deleteVehicle _x}forEach nearestObjects [(getPosATL _ai), ['GroundWeaponHolder','WeaponHolderSimulated','WeaponHolder'], 3];   //Adapted from the AI cleanup logic by KiloSwiss
	[_ai] call blck_fnc_removeGear;
};

_fn_msgIED = {
	params["_killer"];
	//diag_log format["fn_msgIED:: -- >> msg = %1 and owner _killer = %2",blck_Message, (owner _killer)];
	[["IED","",0,0],[_killer]] call blck_fnc_MessagePlayers;
};

if (typeOf _killer != typeOf (vehicle _killer)) then  // AI was killed by a vehicle
{
	if(_killer == driver(vehicle _killer))then{  // The AI was runover
		if(blck_RunGear) then {  // If we are supposed to delete gear from AI that were run over then lets do it. 
			[_unit] call _fn_deleteAIGear;
			#ifdef blck_debugMode
			if (blck_debugLevel > 2) then
			{
				diag_log format["<<--->> Unit %1 was run over by %2",_unit,_killer];
			};
			#endif
		};
		if (blck_VK_RunoverDamage) then {//apply vehicle damage
			[vehicle _killer] call _fn_applyVehicleDamage;
			if (blck_debugON) then{diag_log format[">>---<< %1's vehicle has had damage applied",_killer];};			
			[_killer] call _fn_msgIED;
		};
		[_unit, vehicle _killer] call _fn_targetVehicle;
		_legal = false;
	};
};

if ( blck_VK_GunnerDamage ) then
{
	if ((typeOf vehicle _killer) in blck_forbidenVehicles) then 
	{_legal = false;}
	else {
		if ((currentWeapon _killer) in blck_forbidenVehicleGuns) then {	_legal = false;};
	};
	#ifdef blck_debugMode
	if (blck_debugLevel > 2) then
	{
		diag_log format["!!---!! Unit was killed by a forbidden vehicle or gun",_unit];
	};
	#endif
	if (blck_VK_Gear) then {[_unit] call _fn_deleteAIGear;};
	if !(_legal) then
	{
		[_unit, vehicle _killer] call _fn_targetVehicle;
		[vehicle _killer] call _fn_applyVehicleDamage;
		[_killer] call _fn_msgIED;
	};
};

_legal
