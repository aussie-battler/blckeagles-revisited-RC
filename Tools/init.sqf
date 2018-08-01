aiDifficulty = "green";
minAI = 5;
maxAI = 6;
minAIpatrolRadius = 25;
maxAIpatrolRadius = 40;


////////////////
patrolRadius = 40;
AI_respawnTime = 600;
aiVehiclePatrolRadius = 600;
vehiclePatrolRespawnTime = 600;
aiAircraftPatrolRadius = 1000;
aiAircraftPatrolRespawnTime = 600;
staticWeaponRespawnTime = 600;
aiShipPatrolRadius = 600;
aiShipPatrolRespawnTime = 600;
aiSubmarinePatrolRadius = 200;
vehicleSubmarineRespawnTime = 600;

player addAction["Center on Player","centerAtPlayerPos.sqf"];
player addAction["Center on Road Cone","setCenterAtNearestRoadCone.sqf"];
player addAction["Clear Center","clearCenter.sqf"];
player AddAction["Add Relative Position for All Mission Objects to Clipboard","pullAllRelativeUnclassified.sqf"];
player addAction["Add Dynamic Mission Configuration to Clipboard","pullRelativeClassified.sqf"];
player addAction["Add Static Mission Configuration to Clipboard","configurForStaticMission.sqf"];
