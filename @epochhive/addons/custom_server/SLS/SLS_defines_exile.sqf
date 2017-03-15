/*
	Define constants for SLS for Exile

	for DBD Clan
	By Ghostrider-DBD-
	Copyright 2016
	Last Modified 3-14-17
	
	--------------------------
	License
	--------------------------
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

diag_log "[blckeagls] SLS : Loading Static Loot Container Spawning System for Exile";

_lootBoxes = 
[
	/*[	
		  
		"altis",  // map name
		"Camp1", // a name for this region for logging and debuging purpses and to help identify the definition down the road when changing things on the server
		2,  // number of locations specified from the list below at which to spawn crates 
		[  // format here is [[position x, y, z], direction, exact / loose placement (true/false), smoke near crate (true/false]
			[[23555.9,18422.7,0.730287],0,true, false], // loadout (0-4), false=random placement near position, true = show smoke at position
			[[23542.1,18435.9,0.00143886],0,true, false],
			[[23514,18452.5,0.00143886],0,true, false],
			[[23534.2,18418.8,0.00143886],0,false, true]		
		]
		
	],
	[	"altis",
		"refuel",
		2,
		[ 	// format here is [[position x, y, z], direction, exact / loose placement (true/false), smoke near crate (true/false]
			[[22963.8,17041.3,0.00143886],0,false, false], 
			[[22942.8,17038,0.00143886],0,false, false],
			[[22948.7,17054,0.00143886],0,false, false]
		] // No comma after this last one
	] //  No comma after this last one 
	*/
];

private["_loot_uniforms","_loot_pistols","_loot_rifles","_loot_snipers","_loot_LMG","_loot_silencers"];
// Edit these to your liking
//Uniforms
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_uniforms = ["U_O_CombatUniform_ocamo", "U_O_GhillieSuit", "U_O_PilotCoveralls", "U_O_Wetsuit", "U_OG_Guerilla1_1", "U_OG_Guerilla2_1", "U_OG_Guerilla2_3", "U_OG_Guerilla3_1", "U_OG_Guerilla3_2", "U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue",
				"U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody", "U_Wetsuit_uniform", "U_Wetsuit_White", "U_Wetsuit_Blue", 
				"U_Wetsuit_Purp", "U_Wetsuit_Camo", "U_CamoRed_uniform", "U_CamoBrn_uniform", "U_CamoBlue_uniform", "U_Camo_uniform", "U_ghillie1_uniform", "U_ghillie2_uniform", "U_ghillie3_uniform","U_B_FullGhillie_ard","U_I_FullGhillie_ard","U_O_FullGhillie_ard",
				"Full Ghillie Suit Semi-Arid:","U_B_FullGhillie_sard","U_O_FullGhillie_sard","U_I_FullGhillie_sard","Full Ghillie Suit Lush","U_B_FullGhillie_lsh","U_O_FullGhillie_lsh","U_I_FullGhillie_lsh"];

//Weapons
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

_loot_pistols = 	blck_Pistols;
_loot_rifles 	= 	blck_RifleAsault + blck_apexWeapons;
_loot_snipers 	= 	blck_RifleSniper + blck_DLC_Sniper;
_loot_LMG 		= 	blck_RifleLMG + blck_DLC_MMG;
_loot_magazines = 	[  //  Ignored 5.56, SMG and pistol ammo as most players seem to have little interest in it when given the choice to use higher caliber amo.
			"100Rnd_65x39_caseless_mag",
			"100Rnd_65x39_caseless_mag_Tracer",
			"10Rnd_127x54_Mag",
			"10Rnd_338_Mag",
			"10Rnd_762x54_Mag",
			"10Rnd_93x64_DMR_05_Mag",
			"130Rnd_338_Mag", // SPMG
			"150Rnd_762x54_Box",
			"150Rnd_762x54_Box_Tracer",
			"150Rnd_93x64_Mag", // NAVID
			"16Rnd_9x21_Mag",
			"200Rnd_65x39_cased_Box",
			"200Rnd_65x39_cased_Box_Tracer",
			"20Rnd_762x51_Mag",
			"30Rnd_65x39_caseless_green",
			"30Rnd_65x39_caseless_green_mag_Tracer",
			"30Rnd_65x39_caseless_mag",
			"30Rnd_65x39_caseless_mag_Tracer",
			// Apex
			"30Rnd_580x42_Mag_F",
			"30Rnd_580x42_Mag_Tracer_F",
			"100Rnd_580x42_Mag_F",
			"100Rnd_580x42_Mag_Tracer_F",
			"20Rnd_650x39_Cased_Mag_F",
			"10Rnd_50BW_Mag_F",
			"150Rnd_556x45_Drum_Mag_F",
			"150Rnd_556x45_Drum_Mag_Tracer_F",
			"30Rnd_762x39_Mag_F",
			"30Rnd_762x39_Mag_Green_F",
			"30Rnd_762x39_Mag_Tracer_F",
			"30Rnd_762x39_Mag_Tracer_Green_F",
			"30Rnd_545x39_Mag_F",
			"30Rnd_545x39_Mag_Green_F",
			"30Rnd_545x39_Mag_Tracer_F",
			"30Rnd_545x39_Mag_Tracer_Green_F",
			"200Rnd_556x45_Box_F",
			"200Rnd_556x45_Box_Red_F",
			"200Rnd_556x45_Box_Tracer_F",
			"200Rnd_556x45_Box_Tracer_Red_F",
			"10Rnd_9x21_Mag"
	];
	
//Silencers
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_silencers = ["muzzle_sr25S_epoch","muzzle_snds_H","muzzle_snds_M","muzzle_snds_L","muzzle_snds_B","muzzle_snds_H_MG","muzzle_snds_acp","muzzle_snds_93mmg","muzzle_snds_93mmg_tan",
					"muzzle_snds_338_black","muzzle_snds_338_greenmuzzle_snds_338_sand"];

private["_loot_optics","_loot_backpacks","_loot_vests","_loot_headgear","_loot_food","_loot_misc","_loot_build"];
//Optics
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_optics = ["optic_NVS","optic_tws","optic_tws_mg","optic_SOS","optic_LRPS","optic_DMS","optic_Arco","optic_Hamr","Elcan_epoch","Elcan_reflex_epoch","optic_MRCO","optic_Holosight",
				"optic_Holosight_smg","optic_Aco","optic_ACO_grn","optic_Aco_smg","optic_ACO_grn_smg","optic_Yorris","optic_MRD","optic_AMS","optic_AMS_khk","optic_AMS_snd",
				"optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan"];

//Backpacks
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_backpacks = blck_backpacks;

//Vests
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_vests = blck_vests;

//Head Gear
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_headgear = 
[
	"H_Cap_blk",
	"H_Cap_blk_Raven",
	"H_Cap_blu",
	"H_Cap_brn_SPECOPS",
	"H_Cap_grn",
	"H_Cap_headphones",
	"H_Cap_khaki_specops_UK",
	"H_Cap_oli",
	"H_Cap_press",
	"H_Cap_red",
	"H_Cap_tan",
	"H_Cap_tan_specops_US",
	"H_Watchcap_blk",
	"H_Watchcap_camo",
	"H_Watchcap_khk",
	"H_Watchcap_sgg",
	"H_MilCap_blue",
	"H_MilCap_dgtl",
	"H_MilCap_mcamo",
	"H_MilCap_ocamo",
	"H_MilCap_oucamo",
	"H_MilCap_rucamo",
	"H_Bandanna_camo",
	"H_Bandanna_cbr",
	"H_Bandanna_gry",
	"H_Bandanna_khk",
	"H_Bandanna_khk_hs",
	"H_Bandanna_mcamo",
	"H_Bandanna_sgg",
	"H_Bandanna_surfer",
	"H_Booniehat_dgtl",
	"H_Booniehat_dirty",
	"H_Booniehat_grn",
	"H_Booniehat_indp",
	"H_Booniehat_khk",
	"H_Booniehat_khk_hs",
	"H_Booniehat_mcamo",
	"H_Booniehat_tan",
	"H_Hat_blue",
	"H_Hat_brown",
	"H_Hat_camo",
	"H_Hat_checker",
	"H_Hat_grey",
	"H_Hat_tan",
	"H_StrawHat",
	"H_StrawHat_dark",
	"H_Beret_02",
	"H_Beret_blk",
	"H_Beret_blk_POLICE",
	"H_Beret_brn_SF",
	"H_Beret_Colonel",
	"H_Beret_grn",
	"H_Beret_grn_SF",
	"H_Beret_ocamo",
	"H_Beret_red",
	"H_Shemag_khk",
	"H_Shemag_olive",
	"H_Shemag_olive_hs",
	"H_Shemag_tan",
	"H_ShemagOpen_khk",
	"H_ShemagOpen_tan",
	"H_TurbanO_blk",
	"H_HelmetB",
	"H_HelmetB_black",
	"H_HelmetB_camo",
	"H_HelmetB_desert",
	"H_HelmetB_grass",
	"H_HelmetB_light",
	"H_HelmetB_light_black",
	"H_HelmetB_light_desert",
	"H_HelmetB_light_grass",
	"H_HelmetB_light_sand",
	"H_HelmetB_light_snakeskin",
	"H_HelmetB_paint",
	"H_HelmetB_plain_blk",
	"H_HelmetB_sand",
	"H_HelmetB_snakeskin",
	"H_HelmetCrew_B",
	"H_HelmetCrew_I",
	"H_HelmetCrew_O",
	"H_HelmetIA",
	"H_HelmetIA_camo",
	"H_HelmetIA_net",
	"H_HelmetLeaderO_ocamo",
	"H_HelmetLeaderO_oucamo",
	"H_HelmetO_ocamo",
	"H_HelmetO_oucamo",
	"H_HelmetSpecB",
	"H_HelmetSpecB_blk",
	"H_HelmetSpecB_paint1",
	"H_HelmetSpecB_paint2",
	"H_HelmetSpecO_blk",
	"H_HelmetSpecO_ocamo",
	"H_CrewHelmetHeli_B",
	"H_CrewHelmetHeli_I",
	"H_CrewHelmetHeli_O",
	"H_HelmetCrew_I",
	"H_HelmetCrew_B",
	"H_HelmetCrew_O",
	"H_PilotHelmetHeli_B",
	"H_PilotHelmetHeli_I",
	"H_PilotHelmetHeli_O"	
	];

//Food
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_food = blck_ConsumableItems;

//Misc
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_Misc = ["Exile_Item_InstaDoc","Exile_Item_Matches","Exile_Item_CookingPot","Exile_Item_CanOpener"];

//Construction
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_build = ["Exile_Item_Rope","Exile_Item_DuctTape","Exile_Item_ExtensionCord","Exile_Item_FuelCanisterEmpty",
				"Exile_Item_JunkMetal","Exile_Item_LightBulb","Exile_Item_CamoTentKit","Exile_Item_WorkBenchKit",
				"Exile_Item_MetalBoard","Exile_Item_MetalPole"];
_loot_tools = ["Exile_Item_Handsaw","Exile_Item_Pliers","Exile_Item_Grinder","Exile_Item_Foolbox"];

// Explosives
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_loot_explosives = [["HandGrenade",3],["MiniGrenade",3],["SatchelCharge_Remote_Mag",3],["DemoCharge_Remote_Mag",3],["ClaymoreDirectionalMine_Remote_Mag",3]];
_loot_launchers = ["launch_NLAW_F","launch_RPG32_F","launch_B_Titan_F","launch_Titan_short_F"];

//  Loot Configuration 1: Heavy Weapons and explosives
_box1_Pistols = 3;
_box1_Rifles = 5;
_box1_LMG = 4;
_box1_Snipers = 3;
_box1_Mags = [2,6];
_box1_Optics = 6;
_box1_Silencers = 5;
_box1_Explosives = 6;
_box1_FoodDrink = 6;
_box1_Misc = 3;
_box1_Backpacks = 3;
_box1_BuildingSupplies = 3;
_box1_Tools = 0;
_box1_launchers = 0;
//  Note that the bonus items are listed in a nexted array within the _box1_cbonus array. It was more difficult to ocde otherwise and would have needed indexing to make it work.
_box1_bonus_items = [["ItemGPS",1],["Rangefinder",1],["SatchelCharge_Remote_Mag",3],["DemoCharge_Remote_Mag",3],["ClaymoreDirectionalMine_Remote_Mag",3]];
_box1_bonus = 1;

// Loot Configuration 2: Sniper Weapons and sniper scopes
_box2_Pistols = 3;
_box2_Rifles = 5;
_box2_LMG = 4;
_box2_Snipers = 3;
_box2_Mags = [2,6];  // [number of times to select a mag, min # of that mag to add, max # of that mag to add]
_box2_Optics = 6;
_box2_Silencers = 5;
_box2_Explosives = 6;
_box2_FoodDrink = 6;
_box2_Misc = 3;
_box2_Backpacks = 3;
_box2_BuildingSupplies = 3;
_box2_Tools = 0;
_box2_Misc = 0;
_box2_launchers = 0;
_box2_bonus_items = [["ItemGPS",2],["Rangefinder",2],["SatchelCharge_Remote_Mag",1],["DemoCharge_Remote_Mag",10]];
_box2_bonus = 1;

// Loot Configuration 3: building materials and tools
_box3_Pistols = 2;
_box3_Rifles = 2;
_box3_LMG = 1;
_box3_Snipers = 1;
_box3_Mags = [4,2,6];
_box3_Optics = 1;
_box3_Silencers = 1;
_box3_Explosives = 2;
_box3_FoodDrink = 3;
_box3_Misc = 3;
_box3_Backpacks = 1;
_box3_BuildingSupplies = [8,15]; // [Number of items, min for item, max for item]
_box3_Tools = 4;
_box3_Misc = 6;
_box3_launchers = 0;
_box3_bonus_items = [["Exile_Item_Matches",2],[	"Exile_Item_CookingPot",2],["Exile_Item_CanOpener",3],["Exile_Item_Handsaw",2],["Exile_Item_Pliers",2],["Exile_Item_Grinder",1],["Exile_Item_Foolbox",1]];
_box3_bonus = 1;


////////////////////////////
// End of configurations
