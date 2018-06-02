

//blck_fnc_HC_getListConnected = 

private _hcs = [];
{
	if !(_x in _hcs) then {_hcs pushBack _x};
}forEach entities "HeadlessClient_F";
_hcs