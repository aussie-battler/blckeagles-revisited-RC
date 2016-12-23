
//blck_customMarkers = [];

private _markers = [
		[31086.898,0,29440.51],"ServerRule","Server Rules:","mil_triangle","ColorRed"],
		[[31143.064,0,28674.146],"ServerRule1","No PVP","mil_dot","ColorWhite"],
		[[31136.533,0,27647.641],"ServerRule2","No THEFT from dead players, bases or unlocked vehicles.","mil_dot","ColorWhite"],
		[[31129.488,0,25672.701],"ServerRule3","Don't go to players bases. Not to look, not hang around.","mil_dot","ColorWhite"],
		[[31136.486,20.089996,26683.422],"ServerRule4","Racism, hacking, glitching, duping or theft will result in a ban.","mil_dot","ColorWhite"],
		[[31137.244,5.0910034,24665.658],"ServerRule5","Please be respectful of other players and admins. What an Admin says is final.","mil_dot","ColorWhite"],
		[[31140.377,28.001938,23660.883],"ServerRule6","Don't leave vehicles at the traders. These will be unlocked at restarts.","mil_dot","ColorWhite"],
		[[93.216553,5.6385589e+013,-577.87292],"MissionsRule","Mission Rules:","mil_triangle","ColorRed"],
		[[63.282959,5.6385589e+013,-1236.0565],"MissionRule1","Call missions in side chat and place a marker on the map with your name at the location of the mission you are headed to.","mil_dot","ColorWhite"],
		[[58.716553,0,-2213.2051],"MissionRule2","You call the mission when you are on the way to it, not when you are going to do something else.","mil_dot","ColorWhite"],
		[[52.185303,0,-3239.7109],"MissionRule3","Don't go to other players missions, you have nothing there to do.","mil_dot","ColorWhite"],
		[[45.140381,0,-5214.6504],"MissionRule4","First to call out the mission owns it, thats includes AI gear and mission loot. (If you haven't marked and called it out, you will loose if someone do that.)","mil_dot","ColorWhite"];
		[[52.138428,0,-4203.9287],"MissionRule5","You/Your group can only call one mission at time.","mil_dot","ColorWhite"],
		[[52.89624,0,-6221.6934],"MissionRule6","You don't need to call a out a mission if it is in the PVP zone. But if you are doing it from the outside of pvp zone, you will still be a target for PVP.","mil_dot","ColorWhite"],
		[[56.029053,7.7267151,-7226.4678],"MissionRule7","Mission that spawns inside or if the mission marker touches the pvp marker will be marked as pvp.","mil_dot","ColorWhite"],
		[[-12477.028,0,38781.328],"BuildingsRules","Buildings Rules:","mil_triangle","ColorRed"],
		[[{-12420.862,0,38014.969],"BuildingsRules1","Do not build in pre-buildings.","mil_dot","ColorWhite"],
		[[-12427.394,0,36988.461],"BuildingsRules2","Do not build on or so as to block roads.","mil_dot","ColorWhite"],
		[[-12434.438,2.7021473e+037,35013.523],"BuildingsRules3","When you build, look around and see if your flag will effect any loot spawning. Your flag has a 150m radius, so to be on the safe side build at least 175-200m from loot spawns.","mil_dot","ColorWhite"],
		[[-12427.44,0,36024.242],"BuildingsRules4","Do not build in or near high loot areas such as office buildings, airport hangers, or military installations. Flag poles block loot from spawning at these locations.","mil_dot","ColorWhite"],
		[[-12426.683,0,34006.477]],"BuildingsRules5","Do not build and sniperbases near mafia places, stronghold. (They are not your personal mission.)","mil_dot","ColorWhite"],
		[[-12423.55,0,33001.707,"BuildingsRules6","No air bases. Your base has to touch the ground.","mil_dot","ColorWhite"],
		[[-12419.35,0,32066.854],"BuildingsRules7","Admin will delete bases that are breaking these rules, and you will get nothing back.","mil_dot","ColorWhite"],
		[[24.283001,-4.3682598e-035,-8286.0889],"PVPZonesRule","PVP Zones Rules:","mil_triangle","ColorYellow"],
		[[80.448997,5.0616355e+037,-9052.4521],"PVPZonesRule1","Any things goes.","mil_dot","ColorWhite"],
		[[73.917999,-1.3038923e-012,-10078.958,"PVPZonesRule2","You can't be running around just outside the pvp zone and call pve if you get shoot, if you are there, you are a target.","mil_dot","ColorWhite"],
		[[66.873001,-6.6600447e-037,-12053.896],"PVPZonesRule3","Mission that spawns inside or if the mission marker touches the pvp marker will be marked as pvp.","mil_dot","ColorWhite"],
		[[73.871002,-7.911346e-021,-11043.177],"PVPZonesRule4","If anyone of your team/group is in the pvpzone and you are near it you will consider a legite target.","mil_dot","ColorWhite"],
		[[-12857.771,4.3924521e+035,45162.469],,"Good to know:","mil_triangle","ColorOrange"],
		[[-12801.605,0,44396.109],"GoodToKnow1","If you building or park your vehicles where missions spawns, be preper to login to a place where your vehicle are gone. As AI and player will have battles there.","mil_dot","ColorWhite"],
		[[-12808.137,0,43369.598],"GoodToKnow2","ArmA is a glitchy game. Don't park vehicles on floors/roofs. It may work 1 server session but go boom the next. And they will not be replaced by Admins.","mil_dot","ColorWhite"],
		[[12815.182,23135064,41394.66],"GoodToKnow3","What you do will effect your whole group. What your friends do will effect you. It's your job to look after your friends.","mil_dot","ColorWhite"],
		[[-12808.184,0,42405.379],"GoodToKnow4","If you gone park your vehicle inside your base, make sure your base is big enough to hold them in there.","mil_dot",,"ColorWhite"],
		[[-12833.245,-2.2216157e-031,40349.613],"GoodToKnow5","Use commen sense. Ask your self, would I like this happen too me?","mil_dot","ColorWhite"],
		[[-12848.92,-1.4167476e-034,39791.008],"GoodToKnow6","ON EPOCH:  Don't hord vehicles, 1 air, 2 land per player. Admin will delete them if think your breaking the limit.","mil_dot","ColorWhite"]
];

{
	_x call blck_fnc_addcustomMarker;
}forEach _markers;