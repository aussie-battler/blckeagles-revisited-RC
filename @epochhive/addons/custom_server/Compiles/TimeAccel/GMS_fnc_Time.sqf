// GMS_fnc_time.sqf
// by Ghostrider-DBD_
// 
// Creds to AWOL, A3W, LouD and Creampie for insights.

if (!isServer) exitWith {};
private["_startTime"];
_startTime = diag_tickTime;
_world = toLower format ["%1", worldName];
private["_nightAccel","_dayAccel","_duskAccel"];
switch (_world) do {
	case "altis":{_nightAccel = 3;_dayAccel=0.5; _duskAccel = 3;};
	case "napf":{_nightAccel = 12; _dayAccel = 2;_duskAccel = 6;};
	case "namalsk":{_nightAccel = 12; _dayAccel = 2;_duskAccel = 6;};
	case "tanoa":{_nightAccel = 12; _dayAccel = 3.2;_duskAccel = 6;};
};

switch (sunOrMoon) do {
		// Nighttime
		case {sunOrMoon < 0.1}: {setTimeMultiplier _nightAccel; diag_log format["time accel updated to %1; sunOrMoon = %2; time of day = %3",_nightAccel,sunOrMoon,dayTime];};
		// Daylight
		case {sunOrMoon > 0.5}: {setTimeMultiplier _dayAccel;diag_log format["time accel updated to %1; sunOrMoon = %2; time of day = %3",_dayAccel,sunOrMoon,dayTime];};
		// Dusk
		default {setTimeMultiplier _duskAccel;diag_log format["time accel updated to %1; sunOrMoon = %2; time of day = %3",_duskAccel,sunOrMoon,dayTime];};
	};


