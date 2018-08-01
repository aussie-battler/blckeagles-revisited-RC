/*
"StaticWeapon"
"Car","Tank"
"Air","Plane","Helicopter"
"Ship",
"Man"

		(_x get3DENAttribute 'enableSimulation') select 0,
		(_x get3DENAttribute 'allowDamage') select 0
		
_missionLandscape = [
	["Land_Cargo_HQ_V2_F",[22885.4,16756.8,3.19],[[0,1,0],[0,0,1]],[true,false]],
_missionEmplacedWeapons = [
	["B_HMG_01_high_F",[22883.5,16757.6,6.31652],"blue",0,10]
_aiGroupParameters = [
	["B_HMG_01_high_F",[22883.5,16757.6,6.31652],"blue",0,10]
	[[22819.4,16929.5,0],"red",1, 75, 10]
_vehiclePatrolParameters = [
	["B_G_Offroad_01_armed_F",[22809.5,16699.2,0],"blue",600,10]
_airPatrols = [
	[selectRandom _aircraftTypes,[22830.2,16618.1,11.4549],"blue",1000,60]

_missionCenter = [22584.9,15304.8,0];	
_markerLabel = "";
//_markerType = ["ELIPSE",[200,200],"GRID"];
// An alternative would be:
_markerType = ["mil_triangle",[0,0]];  // You can replace mil_triangle with any other valid Arma 3 marker type https://community.bistudio.com/wiki/cfgMarkers
_markerColor = "ColorRed";  //  This can be any valid Arma Marker Color 	
*/
///////////////////
// Ensure that a center has been set
///////////////////
_cb = "";
diag_log "==========  <START>  ==========================";
//////////////////
// Configure Marker
/////////////////
_mk = allMapMarkers select 0;
_cb = _cb + format["_missionCenter = %1;%2",markerPos _mk,endl];
_cb = _cb + format['_markerType = "%1";%2;',getMarkerType _mk,endl];
_cb = _cb + format['_markerColor = "%1";%2',markerColor _mk,endl];
_cb = _cb + format['_markerLabel = "%1";%2',MarkerText _mk,endl];

if ((getMarkerType _mk) in ["ELIPSE","RECTANGLE"]) then
{
	_cb = _cb + format['_markerBrush = "%1";%2',markerBrush _mk,endl];
	_cb = _cb + format['_markerSize = "%1";%2',getMarkerSize _mk,endl];
};
_cb = _cb + format["%1%1",endl];
///////////////////
// Configure info for mission landscape
///////////////////
_land = allMissionObjects "Static";
systemChat format["%1 static objects",count _land];
_cb = _cb + format["_missionLandscape = [",endl];
{
	_line = format["[%1,%2,[%3,%4],%5,%6]",typeOf _x,getPosATL _x,VectorDir _x, vectorUp _x,'true','true'];
	systemChat _line;
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};	
}forEach allMissionObjects "Static";
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup information for infantry groups
///////////////////
_cb = _cb + format["_missionGroups = ["];
{
		//[[22920.4,16887.3,3.19144],"red",[1,2], 75,120],
	if !(surfaceIsWater (getPos _x)) then
	{
		_line = format['[%1,%2,[%3,%4],%5,%6]',getPosATL _x,aiDifficulty,minAI,maxAI,patrolRadius,AI_respawnTime];
		systemChat _line;
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};
	};
}forEach allMissionObjects "Man";
_cb = _cb + format["%1];%1%1",endl];

_cb = _cb+ format["_aiScubaGroupParameters = ["];
{
		//[[22920.4,16887.3,3.19144],"red",[1,2], 75,120],
	if (surfaceIsWater (getPos _x)) then
	{
		_line = format['[%1,%2,[%3,%4],%5,%6]',getPosATL _x,aiDifficulty,minAI,maxAI,patrolRadius,AI_respawnTime];
		systemChat _line;
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};
	};
}forEach allMissionObjects "Man";
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup Info for vehicle patrols
///////////////////
_cb = _cb + format["_missionPatrolVehicles = ["];
{
	if !((typeOf _x) isKindOf "SDV_01_base_F") then
	{
		_line = format["[%1,%2,%3,%4,%5]",typeOf _x, getPosATL _x, aiDifficulty,aiVehiclePatrolRadius,vehiclePatrolRespawnTime];	//["B_G_Offroad_01_armed_F",[22809.5,16699.2,0],"blue",600,10]
		systemChat _line;
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};	
	};
}forEach ((allMissionObjects "Car") + (allMissionObjects "Tank") + allMissionObjects "Ship");
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Configs for Air Patrols
///////////////////
_cb = _cb + "_airPatrols = [";
	//[selectRandom _aircraftTypes,[22830.2,16618.1,11.4549],"blue",1000,60]
{
	_line = format["%1,%2,%3,%4,%5]",typeOf _x, getPosATL _x, aiDifficulty,aiAircraftPatrolRadius,aiAircraftPatrolRespawnTime];
	systemChat _line;
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};		
}forEach allMissionObjects "Air";
_cb = _cb + format["%1];%1%1",endl];

///////////////////
// Setup info for static/emplaced weapons
///////////////////
_cb = _cb + format["_missionEmplacedWeapons = ["];
{
	// 	["B_HMG_01_high_F",[22883.5,16757.6,6.31652],"blue",0,10]
	_line = format['[%1,%2,%3,%4,%5]',typeOf _x,getPosATL _x,aiDifficulty,0,staticWeaponRespawnTime];	
	systemChat _line;	
	if (_forEachIndex == 0) then
	{
		_cb = _cb + format["%1%2",endl,_line];
	} else {
		_cb = _cb + format[",%1%2",endl,_line];
	};
}forEach allMissionObjects "StaticWeapon";
_cb = _cb + format["%1];%1%1",endl];

_cb = _cb + "_submarinePatrolParameters = [";
{
	if ((typeOf _x) isKindOf "SDV_01_base_F") then
	{
		_line = format["[%1,%2,%3,%4,%5]",typeOf _x, getPosATL _x, aiDifficulty,aiSubmarinePatrolRadius,vehicleSubmarineRespawnTime];	//["B_G_Offroad_01_armed_F",[22809.5,16699.2,0],"blue",600,10]
		systemChat _line;
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};
	};
}forEach allMissionObjects "Ship";
_cb = _cb + format["%1];%1%1",endl];

_cb = _cb + "_missionLootBoxes = [";
{
	//  [selectRandom blck_crateTypes,[22904.8,16742.5,6.30195],[[0,1,0],[0,0,1]],[true,false], _crateLoot, _lootCounts]
	_line = format["%1,%2,%3,[true,false],_crateLoot,_lootCounts]",typeOf _x,getPosATL _x,[VectorDir _x, VectorUp _x]];
		systemChat _line;
		if (_forEachIndex == 0) then
		{
			_cb = _cb + format["%1%2",endl,_line];
		} else {
			_cb = _cb + format[",%1%2",endl,_line];
		};	
}forEach allMissionObjects "ThingX";
_cb = _cb + format["%1];%1%1",endl];


///////////////////
// All done, notify the user and copy the output to the clipboard
///////////////////
_msg = "All Objects organzied, formated and copied to the Clipboard";
hint _msg;
systemChat _msg;
systemChat format["_cb has %1 characters",count _cb];
copyToClipboard _cb;
//if (true) exitWith{diag_log _cb};