
params["_aiDifficultyLevel"];
private["_vests"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue": 	{_vests = blck_vests_blue};
	case "red": 	{_vests = blck_vests_red};
	case "green": 	{_vests = blck_vests_green};
	case "orange": 	{_vests = blck_vests_orange};
	default 		{_vests = blck_vests};
};
_vests