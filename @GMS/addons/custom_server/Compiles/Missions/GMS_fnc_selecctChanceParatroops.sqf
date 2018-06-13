
params["_aiDifficultyLevel"];
private["_chancePara"];
switch (toLower (_aiDifficultyLevel)) do
{
		case "blue": 	{_chancePara = blck_chanceParaBlue};
		case "red": 	{_chancePara = blck_chanceParaRed};
		case "green": 	{_chancePara = blck_chanceParaGreen};
		case "orange": 	{_chancePara = blck_chanceParaOrange};
		default {_chancePara = blck_chanceParaRed};
};
_chancePara