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

local LegendaryLords = require('mk/legendary_lords');
log('legendary_lords loaded');

log('Loading quests');
local Quests = require('mk/quests');
log('quests loaded');

local Chapters = require('mk/chapters');
log('Chapters loaded');

local apply_beastmen_default_diplomacy = require('mk/apply_beastmen_default_diplomacy');
log('apply_beastmen_default_diplomacy loaded');

local apply_effect_bundles = require('mk/apply_effect_bundles');
log('apply_effect_bundles loaded');

local startFaction = require('mk/start');

-- include the intro, prelude and quest chain scripts
cm:load_faction_script(local_faction .. '_prelude');

-- DLC03 Beastmen Features
log('==== Beastman Children of Chaos start ====');
local ll = LegendaryLords:new(cm, core);
local quests = Quests:new(cm, core, set_up_rank_up_listener);
local chapters = Chapters:new(cm, core, chapter_mission);
log('Created most of our classes');

-------------------------------------------------------
--  This gets called after the intro cutscene ends,
--  Kick off any missions or similar scripts here
-------------------------------------------------------
function start_faction()
  log('start_faction() called');

  apply_beastmen_default_diplomacy(cm);
  log('==== Beastman Children of Chaos apply_beastmen_default_diplomacy ====');

  apply_effect_bundles(cm);
  log('==== Beastman Children of Chaos apply_effect_bundles done ====');

  quests:addFinalQuestBattleListener();
  log('==== Beastman Children of Chaos addFinalQuestBattleListener ====');
  log(reposition_starting_lord_for_faction);

  quests:setupRankupListerners();
  log('==== Beastman Children of Chaos setupRankupListerners ====');
  log(reposition_starting_lord_for_faction);

  local chosen_lord = startFaction(cm, reposition_starting_lord_for_faction);
  log('==== Beastman Children of Chaos start done ====');

  log('Initing chapters');
  chapters:init(chosen_lord);
  log('==== Beastman Children of Chaos chapter init ====');

  ll:start(chosen_lord);
  log('==== Beastman Children of Chaos ll start ====');

  ll:lock(chosen_lord);
  log('==== Beastman Children of Chaos lock done ====');

  -- show advisor progress button
  cm:modify_advice(true);

  log('Calling prelude');
  start_beastmen_prelude(chapters);
  log('==== Beastman Children of Chaos start_beastmen_prelude done ====');

  log('==== Beastman Children of Chaos DONE! ====');
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
