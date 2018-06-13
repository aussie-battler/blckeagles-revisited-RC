
params["_aiDifficultyLevel"];
private["_chanceHeliPatrol"];
	switch (toLower(_aiDifficultyLevel)) do
	{
		case "blue": 	{_chanceHeliPatrol = blck_chanceHeliPatrolBlue};
		case "red": 	{_chanceHeliPatrol = blck_chanceHeliPatrolRed};
		case "green": 	{_chanceHeliPatrol = blck_chanceHeliPatrolGreen};
		case "orange": 	{_chanceHeliPatrol = blck_chanceHeliPatrolOrange};
		default 		{_chanceHeliPatrol = 0};
	};
_chanceHeliPatrol