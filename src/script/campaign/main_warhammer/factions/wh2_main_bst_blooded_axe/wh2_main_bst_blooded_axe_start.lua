-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
-- FACTION SCRIPT
--
-- Custom script for this faction starts here.
--
-- This script relies on a few global exposed by other CA libraries loaded
-- before this file.
--
-- - cm: campaign_manager
-- - core
-- - reposition_starting_lord_for_faction
-- - set_up_rank_up_listener
-- - chapter_mission
--
-- It also exposes some functions globally, these are expected by the game environment:
--
-- - start_faction
-- - faction_new_sp_game_startup
-- - faction_new_mp_game_startup
-- - faction_each_sp_game_startup
-- - faction_each_mp_game_startup
--
-- If required, this file may be used to get back a campaign object, holding
-- the different instances created during the process and each globally defined
-- functions expected by CA.
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
output('Faction script loaded for unlocker_taurox_bst_beastmen_start 1');

local unlocker = require('unlocker/index');
local inspect = require('vendor/inspect');
local log = unlocker.log('campaign:unlocker_taurox_bst_beastmen_start');
local utils = unlocker.utils;
local LegendaryLords = unlocker.LegendaryLords;
local apply_beastmen_default_diplomacy = utils.apply_beastmen_default_diplomacy;
local apply_effect_bundles = utils.apply_effect_bundles;
local startFaction = unlocker.startFaction;
local constants = unlocker.constants;
local TAUROX_FACTION = constants.TAUROX_FACTION;

log('Creating classes !!');
local ll = LegendaryLords:new(cm, core, ll_unlock);
log('Created most of our classes');

-- will be exported
local campaign = {};
campaign.cm = cm;
campaign.core = core;
campaign.output = output;

campaign.ll = ll;

-------------------------------------------------------
--  This gets called after the intro cutscene ends,
--  Kick off any missions or similar scripts here
-------------------------------------------------------
function start_faction()
  log('start_faction() called');
  apply_beastmen_default_diplomacy(cm);
  log('==== Beastman Children of Chaos apply_beastmen_default_diplomacy ====');
  apply_effect_bundles(cm);

  local chosen_lord = utils.startFaction(cm, reposition_starting_lord_for_faction);
  log('==== Beastman Children of Chaos start done ====');

  ll:start(chosen_lord);
  log('==== Beastman Children of Chaos ll start ====');

  ll:lock(chosen_lord);
  log('==== Beastman Children of Chaos lock done ====');

  -- show advisor progress button
  cm:modify_advice(true);

  log('cCalling prelude');
  utils.prelude(campaign, function(err)
    log('callbacked');
    if err then error(err) end;
    log('==== Beastman Children of Chaos start_beastmen_prelude done ====');
    log('==== Beastman Children of Chaos DONE! ====');
  end);
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

campaign.start_faction = start_faction;
campaign.start_game_for_faction = start_game_for_faction;
campaign.faction_new_sp_game_startup = faction_new_sp_game_startup;
campaign.faction_new_mp_game_startup = faction_new_mp_game_startup;
campaign.faction_each_sp_game_startup = faction_each_sp_game_startup;
campaign.faction_each_mp_game_startup = faction_each_mp_game_startup;

return campaign;
