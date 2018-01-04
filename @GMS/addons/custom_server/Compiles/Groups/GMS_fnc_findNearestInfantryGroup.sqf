
/*
	by Ghostrider
	 
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/

params["_pos"];
private["_nearestGroup","_modType"];

_modType = call blck_fnc_getModType;
if (_modType == "Epoch") then {_units = (_pos) nearEntities ["I_Soldier_EPOCH", 100]};
if (_modType == "Exile") then {_units = (_pos) nearEntities ["i_g_soldier_unarmed_f", 100]};
_nearestGroup = group (_units select 0);
{
	
	if ((group _x) != _group) then
	{
		if ( _x distance (leader _group) < ((leader _nearestGroup) distance (leader _group)) ) then
		{
			if ((vehicle _x == _x) ) then {_nearestGroup = group _x};
		};
	};
}forEach _units;

_nearestGroup
