/*
  Delete a unit.
  by Ghostrider
  Last updated 1/13/17   
*/

private["_ai"];
params["_unit"];

diag_log format["_fnc_deleteAI::-> deleting unit = %1",_unit];
{
	_unit removeAllEventHandlers  _x;
}forEach ["Killed","Fired","HandleDamage","HandleHeal","FiredNear"];
private _group = (group _unit);
deleteVehicle _unit;
if (count units _group < 1) then
{
	deletegroup _group;
};

