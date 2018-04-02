local TAUROX_FORENAME = "names_name_709296598";
local TAUROX_NAME = "names_name_1301160797";
local TAUROX_FACTION = "mk_taurox_bst_beastmen";

local starting_general_id = 0;		-- undefined

function mk_taurox()
  output("\n\nloaded mk TAUROX script\n\n");
  output("Test name: " .. TAUROX_NAME);
  output("Test forename: " .. TAUROX_FORENAME);
  output("Test forename: " .. TAUROX_FACTION);
  output("Local faction: " .. local_faction);

  start();
  ll_setup();
  Add_Moon_Phase_Listeners(TAUROX_FACTION);
end;

-------------------------------------------------------
--	work out who starting general is
-------------------------------------------------------
function start()
  output('Start function called');
  if (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, TAUROX_FORENAME))
    or (cm:get_saved_value("starting_general_1") == TAUROX_FORENAME or cm:get_saved_value("starting_general_2") == TAUROX_FORENAME) then
    -- Khazrak
    starting_general_id = 1;
    output("\tTAUROX starting_general_id is 1 (Taurox)");
  else
    output('Couldnt determine starting lord as Taurox, doing nothing as its most likely a vanilla LL');
  end;

  if cm:is_new_game() then
    -- reposition starting lords for certain factions that require it
    output("TAUROX Teleporting Beastmen starting Lords:");

    -- Taurox...
    -- move to Badlands area
    output('TAUROX Reposition taurox');
    reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, TAUROX_FORENAME, 643, 191);

    output('TAUROX Reposition ghorros towards taurox');
    local taurox_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, "names_name_2147357951", 629, 190); -- second army

    if taurox_is_chosen_lord then
      cm:force_declare_war("wh_main_grn_top_knotz", TAUROX_FACTION, false, false);
    else
      cm:force_declare_war("wh_main_teb_estalia", TAUROX_FACTION, false, false);
    end;

  else
    output('TAUROX not a new game, not teleporting anything');
  end;
end;

-- load the listeners for every human faction
function ll_setup()
  output('Setup legendary lord for ' .. TAUROX_FACTION);
	local bst = get_faction(TAUROX_FACTION);

	if bst and bst:is_human() then
		for i = 1, #ll_beastmen do
      output('Start legendary lord for ' .. TAUROX_FACTION);
			ll_beastmen[i]:start();
		end;
	end;

  if cm:is_new_game() then
    output('Locking LL lords at the start of the game');
    -- Khazrak
    cm:lock_starting_general_recruitment("1902772535", TAUROX_FACTION);
    -- Malagor
    cm:lock_starting_general_recruitment("2072135186", TAUROX_FACTION);
    -- Morghur
    cm:lock_starting_general_recruitment("203069748", TAUROX_FACTION);
  end;
end;

ll_beastmen = {
	-- Khazrak
	ll_unlock:new(
		TAUROX_FACTION,
		"2140784064",
		"names_name_2147352487",
		"CharacterPostBattleRelease",
		function(context)
			if context:character():faction():name() == TAUROX_FACTION then
				local release_count = cm:get_saved_value("ll_beastmen_khazrak_release_count");
				if release_count == nil then release_count = 0 end;

				release_count = release_count + 1;

				cm:set_saved_value("ll_beastmen_khazrak_release_count", release_count);

				return release_count > 1;
			end
		end
	),

	-- Malagor
	ll_unlock:new(
		TAUROX_FACTION,
		"2140784127",
		"names_name_2147357619",
		"MilitaryForceBuildingCompleteEvent",
		function(context)
			return context:building() == "wh_dlc03_horde_beastmen_gors_2" and context:character():faction():name() == TAUROX_FACTION;
		end
	),

	-- Morghur
	ll_unlock:new(
		TAUROX_FACTION,
		"2140784189",
		"names_name_2147352897",
		"UnitCreated",
		function(context)
			return context:unit():unit_key() == "wh_dlc03_bst_mon_chaos_spawn_0" and context:unit():faction():name() == TAUROX_FACTION;
		end
	)
};
