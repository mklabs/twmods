local log = require('mk/log')('mk:start');
log('Start module loaded');

local constants        = require('mk/constants');
local TAUROX_NAME      = constants.TAUROX_NAME;
local SRUI_FORENAME    = constants.SRUI_FORENAME;
local TAUROX_FACTION   = constants.TAUROX_FACTION;
local TAUROX_FORENAME  = constants.TAUROX_FORENAME;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
local TAUROX_POS_X     = constants.TAUROX_POS_X;
local TAUROX_POS_Y     = constants.TAUROX_POS_Y;
local GHORROS_POS_X    = constants.GHORROS_POS_X;
local GHORROS_POS_Y    = constants.GHORROS_POS_Y;

-- This teleports both the Starting lord and any second army (usually Ghorros Heart-render)
--
-- Returns a boolean whether the provided lord is the starting one.
local function teleport(forname, posx, posy, reposition_starting_lord_for_faction)
  log('Teleport ' .. forname .. 'to (' .. posx .. ', ' .. posy .. ')');
  -- faction, subject forname, target forname, posx, posy
  reposition_starting_lord_for_faction(TAUROX_FACTION, forname, forname, posx, posy);
  log('ok ?');
end;

-- TODO: setup starting diplomatic relation, war with hochland for the moment,
-- try to make it configurable
local function setupStartingDiplomaticRelations(lord)
  cm:force_declare_war('wh_main_emp_hochland', TAUROX_FACTION, false, false);
end;

local function start(cm, reposition_starting_lord_for_faction)
  log('Start function called');
  if not cm:is_new_game() then
    return;
  end;

  -- Teleport stuff
  log('Teleporting Beastmen starting Lords');

  -- Taurox... move towards talabecland
  -- log('Reposition taurox');
  -- local taurox_is_chosen_lord = teleport(TAUROX_FORENAME, TAUROX_POS_X, TAUROX_POS_Y);

  -- Ghorros... move towards Karond Kar (rictus)
  -- log('Reposition Ghorros');
  -- local ghorros_is_chosen_lord = teleport(GHORROS_FORENAME, GHORROS_POS_X, GHORROS_POS_Y);

   -- Taurox Unlocker... same, but using SRUI forename to locate starting general
  log('Reposition Taurox (srui mode)');
  local ok, err = pcall(function()
    log('==> now');
    teleport(SRUI_FORENAME, TAUROX_POS_X, TAUROX_POS_Y, reposition_starting_lord_for_faction);
    setupStartingDiplomaticRelations();
  end)

  if err then log('Err', err) end;

  return TAUROX_FORENAME;
end;

return start;
