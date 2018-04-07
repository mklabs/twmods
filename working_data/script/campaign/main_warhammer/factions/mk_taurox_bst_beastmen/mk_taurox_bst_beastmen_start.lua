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
output('Loaded start script for faction mk_taurox_bst_beastmen');

local log = require('mk/log')('campaign:mk_taurox_bst_beastmen_start');

local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_NAME = constants.TAUROX_NAME;
local TAUROX_POS_X = constants.TAUROX_POS_X;
local TAUROX_POS_Y = constants.TAUROX_POS_Y;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
local GHORROS_POS_X = constants.GHORROS_POS_X;
local GHORROS_POS_Y = constants.GHORROS_POS_Y;

output('OMG does the constant stuff work ?' .. TAUROX_FACTION);

-- local legendary_lords = require('mk/legendary_lords');
output('OMG OMG does the beastmen legendary_lords work ?');

-- include the intro, prelude and quest chain scripts
cm:load_faction_script(local_faction .. '_prelude');
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
log('campaign script loaded for ' .. local_faction);

-------------------------------------------------------
--  work out who starting general is
-------------------------------------------------------

local starting_general_id = 0;    -- undefined

-- Archaon start position
local cam_mp_start_x = 777;
local cam_mp_start_y = 600;
local cam_mp_start_d = 10;
local cam_mp_start_b = 0;
local cam_mp_start_h = 10;

-- AI Beastmen armies can get stuck in encampment stance attempting to
-- replenish losses that they suffer from low army morale attrition
-- Mitch, 04/07/16
function apply_effect_bundles()
  log('Applying effect bundles to own faction for low morale immunity and animosity bonus');
  cm:apply_effect_bundle('wh_dlc03_low_morale_attrition_immunity', TAUROX_FACTION, -1);
  cm:apply_effect_bundle('wh2_main_bundle_greenskin_animosity_bonus', TAUROX_FACTION, -1);
end;

function add_taurox_quest_battle_listener()
  if not cm:get_saved_value('mk_taurox_bst_taurox_battle_quest') then
    core:add_listener(
      'Taurox_Quest_Battle',
      'FactionTurnStart',
      function(context)
        local faction = context:faction();
        return faction:is_human() and faction:name() == TAUROX_FACTION;
      end,
      function()
        log('Trigger mission mk_taurox_bst_taurox_dual_cleaver');
        cm:trigger_mission(TAUROX_FACTION, 'mk_taurox_bst_taurox_dual_cleaver', true);
        cm:set_saved_value('mk_taurox_bst_taurox_battle_quest', true);
      end,
      false
    );
  end;
end;

function add_beastmen_final_battle_listener()
  if not cm:get_saved_value('bst_final_battle_quest') then
    core:add_listener(
      'Beastmen_Final_Battle',
      'FactionTurnStart',
      function(context)
        local faction = context:faction();
        return faction:is_human() and faction:name() == TAUROX_FACTION and are_all_beastmen_final_battle_factions_dead();
      end,
      function()
        log('Trigger mission wh_dlc03_qb_bst_the_final_battle');
        cm:trigger_mission(TAUROX_FACTION, 'wh_dlc03_qb_bst_the_final_battle', true);
        cm:set_saved_value('bst_final_battle_quest', true);
      end,
      false
    );
  end;
end;

function are_all_beastmen_final_battle_factions_dead()
  local factions = {
  --  'wh_main_teb_estalia'
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
    local emp = get_faction('wh_main_emp_empire');
    local beast = get_faction(TAUROX_FACTION);
    if beast and emp:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_emp_empire', 'all', true, true, true);
    end;

    local brt = get_faction('wh_main_brt_bretonnia');
    if beast and brt:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_brt_bretonnia', 'all', true, true, true);
    end;

    local dwf = get_faction('wh_main_dwf_dwarfs');
    if beast and dwf:is_human() and beast:is_human() then
      cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_dwf_dwarfs', 'all', true, true, true);
    end;
  end
end;

-------------------------------------------------------
--  This gets called after the intro cutscene ends,
--  Kick off any missions or similar scripts here
-------------------------------------------------------
function start_faction()
  log('start_faction() called');

  -- show advisor progress button
  cm:modify_advice(true);

  start_beastmen_prelude();

  if cm:is_multiplayer() == false then
    show_how_to_play_event(BEASTMEN_FACTION);
  end;
end;

-------------------------------------------------------
--  This gets called each time the script restarts,
--  this could be at the start of a new game or
--  loading from a save-game (including coming back
--  from a campaign battle). Don't tamper with it.
-------------------------------------------------------
function start_game_for_faction(should_show_cutscene)
  log('start_game_for_faction() called');
  log('Calling start_faction');
  start_faction();
end;

-------------------------------------------------------
--  This gets called only once - at the start of a
--  new game. Initialise new game stuff for this
--  faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
  log('faction_new_sp_game_startup() called');
end;

function faction_new_mp_game_startup()
  log('faction_new_mp_game_startup() called');
end;

-------------------------------------------------------
--  This gets called any time the game loads in,
--  singleplayer including from a save game and
--  from a campaign battle. Put stuff that needs
--  re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
  log('faction_each_sp_game_startup() called');

  -- put stuff here to be initialised each time a singleplayer game loads

  -- should we disable further advice
  if cm:get_saved_value('advice_is_disabled') then
    cm:set_advice_enabled(false);
  end;
end;

function faction_each_mp_game_startup()
  log('faction_each_mp_game_startup() called');
  -- put stuff here to be initialised each time a multiplayer game loads
end;

-- DLC03 Beastmen Features
log('==== Beastman Children of Chaos ====');
add_beastmen_final_battle_listener();
apply_beastmen_default_diplomacy();
apply_effect_bundles();

if (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, TAUROX_FORENAME))
  or (cm:get_saved_value('starting_general_1') == TAUROX_FORENAME or cm:get_saved_value('starting_general_2') == TAUROX_FORENAME) then

  starting_general_id = 1;
  log('starting_general_id is 1 (Taurox the Brass Bull)');

  -- Khazrak chapter missions, for now
  -- TODO: Tailor chapter obj for Taurox
  if not cm:is_multiplayer() then
    log('Start beastmen chapter missions');
    chapter_one_mission = chapter_mission:new(1, local_faction, 'wh_dlc03_objective_beastmen_main_khazrak_01', nil);
    chapter_two_mission = chapter_mission:new(2, local_faction, 'wh_dlc03_objective_beastmen_main_khazrak_02', nil);
    chapter_three_mission = chapter_mission:new(3, local_faction, 'wh_dlc03_objective_beastmen_main_khazrak_03', nil);
    chapter_four_mission = chapter_mission:new(4, local_faction, 'wh_dlc03_objective_beastmen_main_khazrak_04', nil);
    chapter_five_mission = chapter_mission:new(5, local_faction, 'wh_dlc03_objective_beastmen_main_khazrak_05', nil);
  end;
elseif (cm:is_new_game() and general_with_forename_exists_in_faction_with_force(local_faction, GHORROS_FORENAME))
  or (cm:get_saved_value('starting_general_1') == GHORROS_FORENAME or cm:get_saved_value('starting_general_2') == GHORROS_FORENAME) then
  starting_general_id = 2;
  log('starting_general_id is 1 (Ghorros Warhoof)');

  -- Morghur chapter missions, for now
  -- TODO: Tailor chapter obj for Ghorros
	if not cm:is_multiplayer() then
    log('Start children of chaos chapter missions');
		chapter_one_mission = chapter_mission:new(1, local_faction, 'wh_dlc05_objective_beastmen_main_morghur_01', nil);
		chapter_two_mission = chapter_mission:new(2, local_faction, 'wh_dlc05_objective_beastmen_main_morghur_02', nil);
		chapter_three_mission = chapter_mission:new(3, local_faction, 'wh_dlc05_objective_beastmen_main_morghur_03', nil);
		chapter_four_mission = chapter_mission:new(4, local_faction, 'wh_dlc05_objective_beastmen_main_morghur_04', nil);
		chapter_five_mission = chapter_mission:new(5, local_faction, 'wh_dlc05_objective_beastmen_main_morghur_05', nil);
	end;
else
  script_error('ERROR: couldnt determine who starting lord is in Beastmen campaign, starting_general_1 in savegame is ' .. tostring(cm:get_saved_value('starting_general_1')) .. ' and starting_general_2 is ' .. tostring(cm:get_saved_value('starting_general_2')));
end;

log('... mk_taurox_bst_beastmen_start done ...');
