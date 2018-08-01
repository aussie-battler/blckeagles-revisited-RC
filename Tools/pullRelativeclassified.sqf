/*
"StaticWeapon"
"Car","Tank"
"Air","Plane","Helicopter"
"Ship",
"Man"
"ThingX"

		(_x get3DENAttribute 'enableSimulation') select 0,
		(_x get3DENAttribute 'allowDamage') select 0
*/
///////////////////
// Ensure that a center has been set
///////////////////
if (isNil "CENTER") exitWith {systemChat "Please define the mission center"};

diag_log "==========  <START>  ==========================";
_fn_getRelPos_x = {
	_opz = (getPos (_this select 0)) select 2;
	_cpz = CENTER select 2;
	_zd = _opz - _cpz;
	private _p = (getPos (_this select 0)) vectorDiff CENTER;
	_p set [2,_zd];
	_p;
};
///////////////////
// Configure info for mission landscape
///////////////////
_land = allMissionObjects "Static";
//systemChat format["%1 static objects",count _land];
_cb = format["_missionLandscape = [",endl];
_landscape = allMissionObjects "Static";
//systemchat format["%1 objects found",count _landscape];
//uiSleep 3;
{
	//systemChat format["typeOf %1 | posn %2",typeOf _x, getPosASL _x];
	//systemChat format["get3DENAttirbute 'enableSimulation' = 51",(_x get3DENAttribute "enableSimulation") select 0];
	//uiSleep 2;
	_line = format["[%1,%2,%3,%4,%5]",typeOf _x,[_x] call _fn_getRelPos_x,getDir _x, 'true','true'];
	diag_log _line;
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};	
}forEach _landscape;
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup information for infantry groups
///////////////////
_cb = _cb +format["_missionGroups = ["];
{
	_line = format['[%1,%2,%3,%4,%5,%6]',[_x] call _fn_getRelPos_x,aiDifficulty,minAI,maxAI,minAIpatrolRadius,maxAIpatrolRadius];
	//systemChat _line;
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};
}forEach allMissionObjects "Man";
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup Info for vehicle patrols
///////////////////
_cb = _cb + format["_missionPatrolVehicles = ["];
{
	if (_x getVariable["lootVehilcle",0] == 0) then
	{
		_line = format['[%1,%2,%3]',typeOf _x,[_x] call _fn_getRelPos_x,getDir _x];
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};	
	};
}forEach ((allMissionObjects "Car") + (allMissionObjects "Tank"));
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup Info for loot vehicles
///////////////////
_cb = _cb + format["_missionLootVehicles = ["];
{
	if (_x getVariable["lootVehilcle",0] == 1) then
	{
		//["Exile_Car_Van_Box_Guerilla02",[22896.8,16790.1,3.18987],[[0,1,0],[0,0,1]],[true,false], _crateLoot, [[1,2],[4,6],[2,6],[5,8],6,1]],
		_line = format['[%1,%2,%3,_crateLoot,_lootCounts]',typeOf _x,[_x] call _fn_getRelPos_x,getDir _x];
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};	
	};
}forEach ((allMissionObjects "Car") + (allMissionObjects "Tank"));
_cb = _cb + format["%1];%1%1",endl];

//////////////////
// Setup Info for loot crates
///////////////////
_cb = _cb + format["_missionLootBoxes = ["];
{
		//[selectRandom blck_crateTypes,[22893,16766.8,6.31652],[[0,1,0],[0,0,1]],[true,false], _crateLoot, _lootCounts],
		systemChat format["Crate %1 | pos %2",_x, getPosATL _x];
		_line = format['[%1,%2,%3,_crateLoot,_lootCounts]',typeOf _x,[_x] call _fn_getRelPos_x,getDir _x];
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};	
}forEach ((allMissionObjects "ThingX"));
_cb = _cb + format["%1];%1%1",endl];
///////////////////
// for future use
///////////////////
{

}forEach allMissionObjects "Air";

///////////////////
// Setup info for static/emplaced weapons
///////////////////
_cb = _cb + format["_missionEmplacedWeapons = ["];
{
	systemChat format["HMB %1 | pos %2",_x, getPosATL _x];
	_line = format['[%1,%2]',typeOf _x,[_x] call _fn_getRelPos_x];	
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};
}forEach allMissionObjects "StaticWeapon";
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// If needed you can uncomment this and configure using the schema above
///////////////////
/*
_ship = [];
{
	_cn = typeOf _x;
	_ship pushback format['[%1,%2,"green"]',_cn,getPos _x];
} forEach allMissionObjects "Ship";
*/

///////////////////
// All done, notify the user and copy the output to the clipboard
///////////////////
_msg = "All Objects organzied, formated and copied to the Clipboard";
hint _msg;
systemChat _msg;
//systemChat format["_cb has %1 characters",count _cb];
copyToClipboard _cb;
//if (true) exitWith{diag_log _cb};