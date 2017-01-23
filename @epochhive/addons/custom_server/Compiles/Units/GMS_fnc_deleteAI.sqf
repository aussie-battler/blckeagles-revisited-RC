/*
  Delete a unit.
  by Ghostrider
  Last updated 1/22/17   
*/

private["_ai","_group"];
params["_unit"];

if (blck_debugLevel > 2) then {diag_log format["_fnc_deleteAI::-> deleting unit = %1",_unit];};

{
	_unit removeAllEventHandlers  _x;
}forEach ["Killed","Fired","HandleDamage","HandleHeal","FiredNear"];
private _group = (group _unit);
[_unit] joinSilent grpNull;
deleteVehicle _unit;
if (count units _group isEqualTo 0) then
{
	deletegroup _group;
};

