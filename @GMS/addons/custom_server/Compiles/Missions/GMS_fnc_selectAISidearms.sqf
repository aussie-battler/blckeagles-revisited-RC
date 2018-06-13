
params["_aiDifficultyLevel"];
private["_sideArms"];
switch (toLower (_aiDifficultyLevel)) do
{
	case "blue": 	{_sideArms = blck_Pistols_blue};
	case "red": 	{_sideArms = blck_Pistols_red};
	case "green": 	{_sideArms = blck_Pistols_green};
	case "orange": 	{_sideArms = blck_Pistols_orange};
	default 		{_sideArms = blck_Pistols};
};
_sideArms