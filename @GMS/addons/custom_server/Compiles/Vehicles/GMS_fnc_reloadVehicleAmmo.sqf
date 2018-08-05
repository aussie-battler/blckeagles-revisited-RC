

/*
	Killed handler for _units
	By Ghostrider-GRG-

	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
#include "\q\addons\custom_server\Configs\blck_defines.hpp";

	params["_veh"];
	private ["_crew","_mag","_allMags","_cnt"];
	//  https://community.bistudio.com/wiki/fullCrew
	//							0				1			2					3				4
	// returns Array - format [[<Object>unit,<String>role,<Number>cargoIndex,<Array>turretPath,<Boolean>personTurret], ...] 
	//diag_log format["_fnc_vehicleMonitor:: (65) _veh = %1",_veh];
	if ({alive _x and !(isPlayer _x)} count (crew _veh) > 0) then
	{
		_crew = fullCrew _veh;
		//diag_log format["_fnc_vehicleMonitor:: (67) _crew = %1",_crew];
		{
			//diag_log format ["_fnc_vehicleMonitor:: (69) _x = %1",_x];
			_mag = _veh currentMagazineTurret (_x select 3);
			if (count _mag > 0) then
			{
				//diag_log format["_fnc_vehicleMonitor:: (71) _mag is typeName %1", typeName _mag];
				//diag_log format ["_fnc_vehicleMonitor:: (71) length _mag = %2 and _mag = %1",_mag,count _mag];	
				_allMags = magazinesAmmo _veh;
				//diag_log format["_fnc_vehicleMonitor:: (71) _allMags = %1",_allMags];			
				_cnt = ( {_mag isEqualTo (_x select 0)}count _allMags);
				//diag_log format["_fnc_vehicleMonitor:: (75) _cnt = %1",_cnt];
				if (_cnt < 2) then {_veh addMagazineCargo [_mag,2]};
			};
		} forEach _crew;
	};
//};