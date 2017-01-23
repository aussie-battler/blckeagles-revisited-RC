/*
	by Ghostrider-Dbd-
	1/13/17
*/
params["_vehicle"];
{
	_vehicle removeAllEventHandlers  _x;
}forEach ["GetIn","GetOut","Killed","Fired","HandleDamage","HandleHeal","FiredNear"];
deleteVehicle _vehicle;