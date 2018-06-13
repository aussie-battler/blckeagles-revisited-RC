
params["_aiDifficultyLevel"];
private["_noPara"];
switch (toLower (_aiDifficultyLevel)) do
{
		case "blue": 	{_noPara = blck_noParaBlue};
		case "red": 	{_noPara = blck_noParaRed};
		case "green": 	{_noPara = blck_noParaGreen};
		case "orange": 	{_noPara = blck_noParaOrange};
		default 		{_noPara = 0};
};
_noPara