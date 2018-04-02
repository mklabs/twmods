-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--  FACTION SCRIPT
--
--  Custom script for this faction starts here. The should_load_first_turn is
--  queried to determine whether to load the startup script for the full-prelude
--  first turn or just the standard startup script.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

local TAUROX_FORENAME = "names_name_709296598";
local TAUROX_NAME = "names_name_1301160797";
local TAUROX_FACTION = "mk_taurox_bst_beastmen";

-- include the intro, prelude and quest chain scripts
cm:load_faction_script(local_faction .. "_prelude");

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--  FACTION SCRIPT
--
--  This script sets up the default start camera (for a multiplayer game) and
--  the intro cutscene/objective for a playable faction. The filename for this
--  script must match the name of the faction.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
output("campaign script loaded for " .. local_faction);

-------------------------------------------------------
--  work out who starting general is
-------------------------------------------------------

starting_general_id = 0;    -- undefined

cam_mp_start_x = 266.6;
cam_mp_start_y = 204.8;
cam_mp_start_d = 10;
cam_mp_start_b = 0;
cam_mp_start_h = 10;

if (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, TAUROX_FORENAME))
  or (cm:get_saved_value("starting_general_1") == TAUROX_FORENAME or cm:get_saved_value("starting_general_2") == TAUROX_FORENAME) then

  starting_general_id = 1;
  output("\tstarting_general_id is 1 (Taurox)");

  -- Khazrak chapter missions, for now
  if not cm:is_multiplayer() then
    chapter_one_mission = chapter_mission:new(1, local_faction, "wh_dlc03_objective_beastmen_main_khazrak_01", nil);
    chapter_two_mission = chapter_mission:new(2, local_faction, "wh_dlc03_objective_beastmen_main_khazrak_02", nil);
    chapter_three_mission = chapter_mission:new(3, local_faction, "wh_dlc03_objective_beastmen_main_khazrak_03", nil);
    chapter_four_mission = chapter_mission:new(4, local_faction, "wh_dlc03_objective_beastmen_main_khazrak_04", nil);
    chapter_five_mission = chapter_mission:new(5, local_faction, "wh_dlc03_objective_beastmen_main_khazrak_05", nil);
  end;
else
  script_error("ERROR: couldn't determine who starting lord is in Beastmen campaign, starting_general_1 in savegame is " .. tostring(cm:get_saved_value("starting_general_1")) .. " and starting_general_2 is " .. tostring(cm:get_saved_value("starting_general_2")));
end;

-- AI Beastmen armies can get stuck in encampment stance attempting to
-- replenish losses that they suffer from low army morale attrition
-- Mitch, 04/07/16
function apply_effect_bundles()
  output('Applying effect bundles to own faction for low morale immunity and animosity bonus');
  cm:apply_effect_bundle("wh_dlc03_low_morale_attrition_immunity", TAUROX_FACTION, -1);
  cm:apply_effect_bundle("wh2_main_bundle_greenskin_animosity_bonus", TAUROX_FACTION, -1);
end;

function add_beastmen_final_battle_listener()
  if not cm:get_saved_value("bst_final_battle_quest") then
    core:add_listener(
      "Beastmen_Final_Battle",
      "FactionTurnStart",
      function(context)
        local faction = context:faction();
        return faction:is_human() and faction:name() == TAUROX_FACTION and are_all_beastmen_final_battle_factions_dead();
      end,
      function()
        output('Trigger mission wh_dlc03_qb_bst_the_final_battle');
        cm:trigger_mission(TAUROX_FACTION, "wh_dlc03_qb_bst_the_final_battle", true);
        cm:set_saved_value("bst_final_battle_quest", true);
      end,
      false
    );
  end;
end;

function are_all_beastmen_final_battle_factions_dead()
  local factions = {
  --  "wh_main_teb_estalia"
  };

  for i = 1, #factions do
    if not get_faction(factions[i]):is_dead() then
      return false;
    end;
  end;

  return true;
end;

function apply_beastmen_default_diplomacy()
  -- if Empire/Bretonnia/Dwarfs are human controlled (i.e. MPC) then all options are available to Beastmen (except trade)
  if cm:is_multiplayer() then
    local emp = get_faction("wh_main_emp_empire");
    local beast = get_faction(TAUROX_FACTION);
    if beast and emp:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record("faction:" .. TAUROX_FACTION, "faction:wh_main_emp_empire", "all", true, true, true);
    end;

    local brt = get_faction("wh_main_brt_bretonnia");
    if beast and brt:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record("faction:" .. TAUROX_FACTION, "faction:wh_main_brt_bretonnia", "all", true, true, true);
    end;

    local dwf = get_faction("wh_main_dwf_dwarfs");
    if beast and dwf:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record("faction:" .. TAUROX_FACTION, "faction:wh_main_dwf_dwarfs", "all", true, true, true);
    end;
  end
end;

-------------------------------------------------------
--  This gets called each time the script restarts,
--  this could be at the start of a new game or
--  loading from a save-game (including coming back
--  from a campaign battle). Don't tamper with it.
-------------------------------------------------------
function start_game_for_faction(should_show_cutscene)
  output("start_game_for_faction() called");

  -- starts the playable faction script
  fs_player:start(should_show_cutscene, true);
end;

-------------------------------------------------------
--  This gets called after the intro cutscene ends,
--  Kick off any missions or similar scripts here
-------------------------------------------------------
function start_faction()
  output("start_faction() called");

  -- show advisor progress button
  cm:modify_advice(true);

  start_beastmen_prelude();

  if cm:is_multiplayer() == false then
    show_how_to_play_event(local_faction);
  end;
end;

-------------------------------------------------------
--  This gets called only once - at the start of a
--  new game. Initialise new game stuff for this
--  faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
  output("faction_new_sp_game_startup() called");
end;

function faction_new_mp_game_startup()
  output("faction_new_mp_game_startup() called");
end;

-------------------------------------------------------
--  This gets called any time the game loads in,
--  singleplayer including from a save game and
--  from a campaign battle. Put stuff that needs
--  re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
  output("faction_each_sp_game_startup() called");

  -- put stuff here to be initialised each time a singleplayer game loads

  -- should we disable further advice
  if cm:get_saved_value("advice_is_disabled") then
    cm:set_advice_enabled(false);
  end;
end;

function faction_each_mp_game_startup()
  output("faction_each_mp_game_startup() called");
  -- put stuff here to be initialised each time a multiplayer game loads
end;

function scrollCameraToFactionLeader()
  output("008 - Focus_Starting_Cameras");
  if cm:is_new_game() then
    output("008 - Focus_Starting_Cameras new game");
    local faction = get_faction(local_faction);
    local faction_leader_cqi = faction:faction_leader():command_queue_index();
    cm:scroll_camera_with_cutscene_to_character(6, end_callback, faction_leader_cqi);
  end
end;

-- DLC03 Beastmen Features
output("==== Beastman Children of Chaos ====");
add_beastmen_final_battle_listener();
apply_beastmen_default_diplomacy();
apply_effect_bundles();


-------------------------------------------------------
--  Faction Start declaration/config
--  This object decides what to do when the faction
--  is initialised - do we play the cutscene, do we
--  position the camera at the start, or do we do
--  nothing, stuff like that.
--
--  Comment out the line adding the intro cutscene
--  to not play it (not ready for playtesting etc.)
-------------------------------------------------------
fs_player = faction_start:new(local_faction, cam_mp_start_x, cam_mp_start_y, cam_mp_start_d, cam_mp_start_b, cam_mp_start_h);
-- singleplayer initialisation
fs_player:register_new_sp_game_callback(function() faction_new_sp_game_startup() end);
fs_player:register_each_sp_game_callback(function() faction_each_sp_game_startup() end);

-- multiplayer initialisation
fs_player:register_new_mp_game_callback(function() faction_new_mp_game_startup() end);
fs_player:register_each_mp_game_callback(function() faction_each_mp_game_startup() end);

if core:is_tweaker_set("DISABLE_PRELUDE_CAMPAIGN_SCRIPTS") then
  output("Tweaker DISABLE_PRELUDE_CAMPAIGN_SCRIPTS is set so not running any prelude scripts");
else
  scrollCameraToFactionLeader();
end;
