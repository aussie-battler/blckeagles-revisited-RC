/*
	By Ghostrider [GRG]
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
if (isServer) then 
{
	#ifdef blck_debugMode
	if (blck_debugLevel > 1) then {diag_log format["_EH_AHit: _this = %1",_this]};
	#endif
	_this remoteExec["blck_fnc_processAIHit",2];
};


