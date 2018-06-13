
params["_aiDifficultyLevel"];
private["_backpacks"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue": 	{_backpacks = blck_backpacks_blue};
	case "red": 	{_backpacks = blck_backpacks_red};
	case "green": 	{_backpacks = blck_backpacks_green};
	case "orange": 	{_backpacks = blck_backpacks_orange};
	default 		{_backpacks = blck_backpacks};
};
_backpacks