
params["_aiDifficultyLevel"];
private["_missionHelis"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue":	{_missionHelis = blck_patrolHelisBlue};
	case "red":		{_missionHelis = blck_patrolHelisRed};
	case "green": 	{_missionHelis = blck_patrolHelisGreen};
	case "orange": 	{_missionHelis = blck_patrolHelisOrange};
	default			{_missionHelis = blck_patrolHelisBlue};
};
_missionHelis