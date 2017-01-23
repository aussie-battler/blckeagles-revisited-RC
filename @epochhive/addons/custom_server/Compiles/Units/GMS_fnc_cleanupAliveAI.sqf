/*
  Delete alive AI.
  Now called from the main thread which tracks the time elapsed so that we no longer need to wait a proscribed period of time (see changes on lines 9 and 12)
  by Ghostrider
  Last updated 1/22/17
*/

params["_aiList"];

{
	if (blck_debugLevel > 2) then {diag_log format["_fnc_cleanupAliveAI:: -> deleteing AI Unit %1",_x];};
	[_x] call blck_fnc_deleteAI;
}forEach _aiList;

