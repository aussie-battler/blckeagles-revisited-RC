/*
  Delete Dead AI and nearby weapons after an appropriate period.
  by Ghostrider
  Last updated 1/13/17   
*/

private["_aiList","_ai"];
_aiList = blck_deadAI;
{
	if ( diag_tickTime > _x getVariable ["blck_cleanupAt",0] ) then //  DBD_DeleteAITimer
	{
		_ai = _x;
		{
			deleteVehicle _x;
		}forEach nearestObjects [getPos _ai,["WeaponHolderSimulated","GroundWeapoonHolder"],3];	
		blck_deadAI = blck_deadAI - [_ai];
		deleteVehicle _ai;
	};
} forEach _aiList;

