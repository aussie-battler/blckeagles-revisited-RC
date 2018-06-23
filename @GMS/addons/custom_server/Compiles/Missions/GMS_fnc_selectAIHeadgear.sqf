
params["_aiDifficultyLevel"];
private["_headgear"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue": 	{_headGear = blck_headgear_blue};
	case "red": 	{_headGear = blck_headgear_red};
	case "green": 	{_headGear = blck_headgear_green};
	case "orange": 	{_headGear = blck_headgear_orange};
	default 		{_headGear = blck_headgear};
};
_headgear