local TAUROX_FORENAME = 'names_name_709296598';
local GHORROS_FORENAME = 'names_name_2049222507';
local TAUROX_FACTION = 'mk_taurox_bst_beastmen';

function log(str)
  output('[taurox] ' .. str);
end;

function mk_taurox()
  log('\n\nloaded mk TAUROX script\n\n');
  log('Local faction: ' .. local_faction);

  Add_Moon_Phase_Listeners(TAUROX_FACTION);
  local chosen_lord = start();
  mk_taurox_ll_setup(chosen_lord);
  mk_taurox_ll_lock(chosen_lord);
  scrollCameraToFactionLeader(function() log('Scrolled camera to faction leader') end);
end;

-------------------------------------------------------
--	work out who starting general is
-------------------------------------------------------
function start()
  log('Start function called');
  if not cm:is_new_game() then
    return;
  end;

  log('Teleporting Beastmen starting Lords:');

  -- Taurox... move to Chaos wastelands area, Chaos start position
  log('Reposition taurox');
  reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, TAUROX_FORENAME, 777, 600);
  local taurox_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, 'names_name_2147357951', 773, 599); -- second army

  -- Ghorros... move to Morghur start position
  log('Reposition Ghorros');
  reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, TAUROX_FORENAME, 508, 550);
  local ghorros_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, 'names_name_2147357951', 501, 556); -- second army

  if taurox_is_chosen_lord then
    cm:force_declare_war('wh_main_grn_top_knotz', TAUROX_FACTION, false, false);
  elseif ghorros_is_chosen_lord then
    cm:force_declare_war('wh2_main_def_naggarond', TAUROX_FACTION, false, false);
  else
    cm:force_declare_war('wh_main_teb_estalia', TAUROX_FACTION, false, false);
  end;

  return chosen_lord;
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
end;

function mk_taurox_ll_lock(chosen_lord)
  if cm:is_new_game() then
    log('Locking LL lords at the start of the game');
    -- Khazrak
    cm:lock_starting_general_recruitment('1902772535', TAUROX_FACTION);
    -- Malagor
    cm:lock_starting_general_recruitment('2072135186', TAUROX_FACTION);
    -- Morghur
    cm:lock_starting_general_recruitment('203069748', TAUROX_FACTION);
    -- Taurox
    if not chosen_lord == TAUROX_FORENAME then
      cm:lock_starting_general_recruitment('1403603105', TAUROX_FACTION);
    end;
    -- Ghorros
    if not chosen_lord == GHORROS_FORENAME then
      cm:lock_starting_general_recruitment('681847135', TAUROX_FACTION);
    end;
    log('Locked LL lords');
  end;
end;

-- Credits to faction unlocker where this snippet comes from
function scrollCameraToFactionLeader(done)
  log('008 - Focus_Starting_Cameras');
  if cm:is_new_game() then
    log('008 - Focus_Starting_Cameras new game');
    local faction = get_faction(local_faction);
    local faction_leader_cqi = faction:faction_leader():command_queue_index();
    log('008 - cqi: ' .. faction_leader_cqi);
    cm:scroll_camera_with_cutscene_to_character(6, done, faction_leader_cqi);
  end
end;


ll_beastmen = {
	 -- Khazrak
	 ll_unlock:new(
		TAUROX_FACTION,
		'1902772535',
		'names_name_1369338020',
		'CharacterPostBattleRelease',
		function(context)
			if context:character():faction():name() == TAUROX_FACTION then
				local release_count = cm:get_saved_value('ll_beastmen_khazrak_release_count');
				if release_count == nil then release_count = 0 end;

				release_count = release_count + 1;

				cm:set_saved_value('ll_beastmen_khazrak_release_count', release_count);

				return release_count > 9;
			end
		end
	),

	-- Malagor
	ll_unlock:new(
		TAUROX_FACTION,
		'2072135186',
		'names_name_435392760',
		'MilitaryForceBuildingCompleteEvent',
		function(context)
			return context:building() == 'wh_dlc03_horde_beastmen_gors_2' and context:character():faction():name() == TAUROX_FACTION;
		end
	),

	-- Morghur
	ll_unlock:new(
		TAUROX_FACTION,
		'203069748',
		'names_name_1871285548',
		'UnitCreated',
		function(context)
			return context:unit():unit_key() == 'wh_dlc03_bst_mon_chaos_spawn_0' and context:unit():faction():name() == TAUROX_FACTION;
		end
	),

	-- Taurox
	ll_unlock:new(
		TAUROX_FACTION,
		'1403603105',
		'names_name_709296598',
		'MilitaryForceBuildingCompleteEvent',
		function(context)
			return context:building() == 'wh_dlc03_horde_beastmen_minotaurs_1' and context:character():faction():name() == TAUROX_FACTION;
		end
	),

	-- Ghorros
	ll_unlock:new(
		TAUROX_FACTION,
		'681847135',
		'names_name_2049222507',
    'MilitaryForceBuildingCompleteEvent',
		function(context)
			return context:unit():unit_key() == 'wh_dlc03_horde_beastmen_centigors' and context:unit():faction():name() == TAUROX_FACTION;
		end
	),
};
