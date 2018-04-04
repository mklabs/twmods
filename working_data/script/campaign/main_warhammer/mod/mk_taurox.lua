local TAUROX_FORENAME = "names_name_709296598";
local TAUROX_NAME = "names_name_1301160797";
local TAUROX_FACTION = "mk_taurox_bst_beastmen";

local starting_general_id = 0;		-- undefined

function log(str)
  output('[taurox] ' .. str);
end;

function mk_taurox()
  log("\n\nloaded mk TAUROX script\n\n");
  log("Test name: " .. TAUROX_NAME);
  log("Test forename: " .. TAUROX_FORENAME);
  log("Test forename: " .. TAUROX_FACTION);
  log("Local faction: " .. local_faction);

  mk_taurox_ll_setup();
  Add_Moon_Phase_Listeners(TAUROX_FACTION);
  start();
  scrollCameraToFactionLeader(function() log('Scrolled camera to faction leader') end);
end;

-------------------------------------------------------
--	work out who starting general is
-------------------------------------------------------
function start()
  log('Start function called');
  if (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, TAUROX_FORENAME))
    or (cm:get_saved_value("starting_general_1") == TAUROX_FORENAME or cm:get_saved_value("starting_general_2") == TAUROX_FORENAME) then
    -- Khazrak
    starting_general_id = 1;
    log("\tTAUROX starting_general_id is 1 (Taurox)");
  else
    log('Couldnt determine starting lord as Taurox, doing nothing as its most likely a vanilla LL');
  end;

  if cm:is_new_game() then
    -- reposition starting lords for certain factions that require it
    log("TAUROX Teleporting Beastmen starting Lords:");

    -- Taurox...
    -- move to Badlands area
    log('TAUROX Reposition taurox');
    reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, TAUROX_FORENAME, 777, 600);

    log('TAUROX Reposition ghorros towards taurox');
    local taurox_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, "names_name_2147357951", 773, 599); -- second army

    if taurox_is_chosen_lord then
      cm:force_declare_war("wh_main_grn_top_knotz", TAUROX_FACTION, false, false);
    else
      cm:force_declare_war("wh_main_teb_estalia", TAUROX_FACTION, false, false);
    end;

  else
    log('TAUROX not a new game, not teleporting anything');
  end;
end;

-- load the listeners for every human faction
function mk_taurox_ll_setup()
  log('Setup legendary lord for ' .. TAUROX_FACTION);
	local bst = get_faction(TAUROX_FACTION);

	if bst and bst:is_human() then
		for i = 1, #ll_beastmen do
      log('Start legendary lord for ' .. TAUROX_FACTION);
			ll_beastmen[i]:start();
		end;
	end;

  if cm:is_new_game() then
    log('Locking LL lords at the start of the game');
    -- Khazrak
    cm:lock_starting_general_recruitment("1902772535", TAUROX_FACTION);
    -- Malagor
    cm:lock_starting_general_recruitment("2072135186", TAUROX_FACTION);
    -- Morghur
    cm:lock_starting_general_recruitment("203069748", TAUROX_FACTION);
  end;
end;

-- Credits to faction unlocker where this snippet comes from
function scrollCameraToFactionLeader(done)
  log("008 - Focus_Starting_Cameras");
  if cm:is_new_game() then
    log("008 - Focus_Starting_Cameras new game");
    local faction = get_faction(local_faction);
    local faction_leader_cqi = faction:faction_leader():command_queue_index();
    log("008 - cqi: " .. faction_leader_cqi);
    cm:scroll_camera_with_cutscene_to_character(6, done, faction_leader_cqi);
  end
end;


ll_beastmen = {
	-- Khazrak
	-- ll_unlock:new(
	--	TAUROX_FACTION,
	--	"1902772535",
	--	"names_name_1369338020",
	--	"CharacterPostBattleRelease",
	--	function(context)
	--		if context:character():faction():name() == TAUROX_FACTION then
	--			local release_count = cm:get_saved_value("ll_beastmen_khazrak_release_count");
	--			if release_count == nil then release_count = 0 end;
  --
	--			release_count = release_count + 1;
  --
	--			cm:set_saved_value("ll_beastmen_khazrak_release_count", release_count);
  --
	--			return release_count > 1;
	--		end
	--	end
	--),

	-- Khazrak Test
	ll_unlock:new(
		TAUROX_FACTION,
		"1902772535",
		"names_name_1369338020",
		"MilitaryForceBuildingCompleteEvent",
		function(context)
			return context:building() == "wh_dlc03_horde_beastmen_gors_2" and context:character():faction():name() == TAUROX_FACTION;
		end
	),

	-- Malagor
	ll_unlock:new(
		TAUROX_FACTION,
		"2072135186",
		"names_name_435392760",
		"MilitaryForceBuildingCompleteEvent",
		function(context)
			return context:building() == "wh_dlc03_horde_beastmen_gors_2" and context:character():faction():name() == TAUROX_FACTION;
		end
	),

	-- Morghur
	ll_unlock:new(
		TAUROX_FACTION,
		"203069748",
		"names_name_1871285548",
		"UnitCreated",
		function(context)
			return context:unit():unit_key() == "wh_dlc03_bst_mon_chaos_spawn_0" and context:unit():faction():name() == TAUROX_FACTION;
		end
	)
};
