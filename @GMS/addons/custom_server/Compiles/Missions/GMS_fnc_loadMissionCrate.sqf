#include "\q\addons\custom_server\Configs\blck_defines.hpp";
private _crate = _this select 0;
#ifdef blck_debugMode
diag_log format["_fnc_loadMisionLootcrate: _this = %1",_this];
diag_log format["_fnc_loadMisionLootcrate: difficulty = %1", _crate getVariable "difficulty"];
diag_log format["_fnc_loadMisionLootcrate: lootCounts = %1", _crate getVariable "lootCounts"];
diag_log format["_fnc_loadMisionLootcrate: lootArray = %1",_crate getVariable "lootArray"];
#endif
[_crate,(_crate getVariable "lootArray"),(_crate getVariable "lootCounts")] call blck_fnc_fillBoxes;
[_crate, _crate getVariable "difficulty"] call blck_fnc_addMoneyToObject;
_crate setVariable["lootLoaded",true];



	
