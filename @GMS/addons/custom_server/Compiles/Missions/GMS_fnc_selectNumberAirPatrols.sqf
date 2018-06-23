
params["_aiDifficultyLevel"];
private["_noChoppers"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue": 	{_noChoppers = blck_noPatrolHelisBlue};
	case "red": 	{_noChoppers = blck_noPatrolHelisRed};
	case "green": 	{_noChoppers = blck_noPatrolHelisGreen};
	case "orange": 	{_noChoppers = blck_noPatrolHelisOrange};
	default 		{_noChoppers = 0};
};
_noChoppers