-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--  PRELUDE SCRIPT
--
--  This script controls the prelude, issuing missions and the like.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
local log = require('mk/log')('campaign:mk_taurox_bst_beastmen_prelude');
local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
log("Prelude loaded for " .. local_faction);

log('Requiring UI stuff');
local UI = require('mk/ui');
log('Required UI stuff');

local function initUI()
  log('UI init new()');
  local ui = UI:new(cm, core);
  log('UI init setupListeners()');
  ui:setupListeners();
  log('UI init done');

  ui:demoUI();

  log('Setting listener to reposition');
  ui:on('position', function (context)
    local x, y = context;

    log('Position event triggered, reposition starting lords to', context);
    log('Reposition taurox');
    reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, TAUROX_FORENAME, x, y);
    log('Reposition Ghorros');
    reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, GHORROS_FORENAME, x, y);
    log('Reposition second army');
    reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, 'names_name_2147357951', x - 2, y + 2);
    reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, 'names_name_2147357951', x + 3, y - 2);
    log('Repositioned everything, how does it look ?');
  end);
end;

function start_beastmen_prelude(chapters)
  log('start_beastmen_prelude() called');
  cm:modify_advice(true);

  log('Starting chapter');
  chapters:start();
  log('Chapter started');

  log('Call initUI()');
  initUI();
  log('initUI() done');
end;

