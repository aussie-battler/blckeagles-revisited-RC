
/*
	Find Nearest Infantry Group
*/

params["_group"];
private["_nearestGroup","_modType"];

_modType = call blck_fnc_getModType;
if (_modType == "Epoch") then {_units = _group nearEntities ["I_Soldier_EPOCH", 100]};
if (_modType == "Exile") then (_units = _group nearEntities ["i_g_soldier_unarmed_f", 100]};
_nearestGroup = group _units select 0;
{
	if (group _x != _group && _x distance (leader _group) < ((leader _nearestGroup) distance (leader _group))) then {_nearestGroup = group _x};
}forEach _units;

_nearestGroup
