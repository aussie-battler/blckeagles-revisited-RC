/*
  Delete alive AI.
  Now called from the main thread which tracks the time elapsed so that we no longer need to wait a proscribed period of time (see changes on lines 9 and 12)
  by Ghostrider
  Last updated 10/22/16   
*/

params["_aiList"];

{
	diag_log format["_fnc_cleanupAliveAI:: -> deleteing AI Unit %1",_x];
	[_x] call blck_fnc_deleteAI;
}forEach _aiList;

