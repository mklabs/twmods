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

function log(str)
  output('[taurox] ' .. str);
end;


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
log("campaign script loaded for " .. local_faction);

-------------------------------------------------------
--  work out who starting general is
-------------------------------------------------------

starting_general_id = 0;    -- undefined

-- Chaos start location
cam_mp_start_x = 777;
cam_mp_start_y = 600;
cam_mp_start_d = 10;
cam_mp_start_b = 0;
cam_mp_start_h = 10;

if (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, TAUROX_FORENAME))
  or (cm:get_saved_value("starting_general_1") == TAUROX_FORENAME or cm:get_saved_value("starting_general_2") == TAUROX_FORENAME) then

  starting_general_id = 1;
  log("\tstarting_general_id is 1 (Taurox)");

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
  log('Applying effect bundles to own faction for low morale immunity and animosity bonus');
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
        log('Trigger mission wh_dlc03_qb_bst_the_final_battle');
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
--  This gets called after the intro cutscene ends,
--  Kick off any missions or similar scripts here
-------------------------------------------------------
function start_faction()
  log("start_faction() called");
  scrollCameraToFactionLeader(function log('Scrolled camera to faction leader') end);

  -- show advisor progress button
  cm:modify_advice(true);

  start_beastmen_prelude();

  if cm:is_multiplayer() == false then
    show_how_to_play_event(local_faction);
  end;
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
--  This gets called only once - at the start of a
--  new game. Initialise new game stuff for this
--  faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
  log("faction_new_sp_game_startup() called");
end;

function faction_new_mp_game_startup()
  log("faction_new_mp_game_startup() called");
end;

-------------------------------------------------------
--  This gets called any time the game loads in,
--  singleplayer including from a save game and
--  from a campaign battle. Put stuff that needs
--  re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
  log("faction_each_sp_game_startup() called");

  -- put stuff here to be initialised each time a singleplayer game loads

  -- should we disable further advice
  if cm:get_saved_value("advice_is_disabled") then
    cm:set_advice_enabled(false);
  end;
end;

function faction_each_mp_game_startup()
  log("faction_each_mp_game_startup() called");
  -- put stuff here to be initialised each time a multiplayer game loads
end;

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

-- DLC03 Beastmen Features
log("==== Beastman Children of Chaos ====");
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
  log("Tweaker DISABLE_PRELUDE_CAMPAIGN_SCRIPTS is set so not running any prelude scripts");
else
  fs_player:register_intro_cutscene_callback(function()
      show_benchmark_camera_pan_if_required(cutscene_intro_play_khazrak);
  end);
end;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--  INTRO CUTSCENE
--
--  This function declares and configures the cutscene,
--  loads it with actions and plays it.
--  Customise it to suit.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

function cutscene_intro_play_khazrak()
  local cutscene_intro = campaign_cutscene:new(
    local_faction .. "_intro_khazrak",          -- string name for this cutscene
    94.5,                                        -- length of cutscene in seconds
    function() start_faction() end              -- end callback
  );

  local advice_to_play = {
    "dlc03.camp.prelude.bst.intro.001",
    "dlc03.camp.prelude.bst.intro.002",
    "dlc03.camp.prelude.bst.intro.003",
    "dlc03.camp.prelude.bst.intro.004",
    "dlc03.camp.prelude.bst.intro.005"
  };

  --cutscene_intro:set_debug();
  cutscene_intro:set_skippable(true, function() cutscene_intro_skipped(advice_to_play) end);
  cutscene_intro:set_skip_camera(cam_mp_start_x, cam_mp_start_y, cam_mp_start_d, cam_mp_start_b, cam_mp_start_h);
  cutscene_intro:set_disable_settlement_labels(false);

  cutscene_intro:action(
    function()
      cm:show_shroud(false);
      cm:set_camera_position(cam_mp_start_x, cam_mp_start_y, cam_mp_start_d, cam_mp_start_b, cam_mp_start_h);
      cutscene_intro:cindy_playback("script/campaign/main_warhammer/factions/"..local_faction.."/scenes/beastmen_main_flyover_s01.CindyScene", true, true);
    end,
    0
  );

  -- "Tduigu-Uis" - a greeting in your tongue, my bestial Lord. I know you feel a yearning to kill me, for I am but a man, but you have received the vision, you know who has sent me… my desire is as yours - to see the Cloven Ones tear down all civilisation! So let us begin...
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[1]);
    end,
    0.5
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    24.5
  );

  -- To the north, past the mystic forest of Athel Loren, is Bretonnia. Arrogant and aloof, its glittering spires a sure sign of self-righteousness. You should bring ruin to this "pretty" realm.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[2]);
    end,
    25.0
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    40.5
  );

  -- East of the Bretonnians lie the Empire, the very pinnacle of mankind's hubris. Its capital, Altdorf, is the centre of power and a symbol of its surety. Reduce it all to rubble - let pandemonium reign. The Empire is powerful, but divided. You must strike soon, for it may yet unify and seek to bring "civilisation" to the blood-grounds.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[3]);
    end,
    41
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    67.5
  );

  -- To the south, the Border Princes hold a tentative grip on all that they call theirs, yet are isolated by the mountains and the Blackfire Pass - soft targets for a hungry herd such as ours.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[4]);
    end,
    68.0
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    83
  );

  -- Destruction is in your blood, Nuis Ghurleth, and the world must know it. Sow as much as you can - the Cloven Ones shall destroy the world of man!
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[5]);
    end,
    83.5
  );

  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    94.5
  );

  cutscene_intro:action(
    function()
      cm:show_shroud(true);
    end,
    94.5
  );

  cutscene_intro:start();
end;

function cutscene_intro_skipped(advice_to_play)
  cm:override_ui("disable_advice_audio", true);

  effect.clear_advice_session_history();

  for i = 1, #advice_to_play do
    cm:show_advice(advice_to_play[i]);
  end;

  cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5);
end;
