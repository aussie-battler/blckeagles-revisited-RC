
params["_aiDifficultyLevel"];
private["_uniforms"];
	switch (toLower (_aiDifficultyLevel)) do
	{
		case "blue": 	{_uniforms = blck_SkinList_blue};
		case "red": 	{_uniforms = blck_SkinList_red};
		case "green": 	{_uniforms = blck_SkinList_green};
		case "orange": 	{_uniforms = blck_SkinList_orange};
		default 		{_uniforms = blck_SkinList};
	};
_uniforms