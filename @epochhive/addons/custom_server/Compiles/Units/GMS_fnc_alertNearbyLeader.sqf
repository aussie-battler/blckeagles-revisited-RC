/*
	by Ghostrider
	9-20-15
	Because this is p-ecompiled there is less concern about keeping comments in.
*/

private["_knowsAbout","_intelligence";"_group"];
params["_unit","_target"];
_intelligence = _unit getVariable ["intelligence",1];
_group = group _unit;
{
	_knowsAbout = _x knowsAbout _target;
	_x reveal [_target,_knowsAbout + _intelligence];
}forEach units _group;



