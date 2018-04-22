local log = require('mk/log')('mk:start');
local constants       = require('mk/constants');
local SRUI_FORENAME   = constants.SRUI_FORENAME;
local TAUROX_FACTION  = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_POS_X    = constants.TAUROX_POS_X;
local TAUROX_POS_Y    = constants.TAUROX_POS_Y;

local setupStartingDiplomaticRelations = require('mk/utils/setupStartingDiplomaticRelations');

-- This teleports both the Starting lord and any second army (usually Ghorros Heart-render)
--
-- Returns a boolean whether the provided lord is the starting one.
--
-- reposition_starting_lord_for_faction => faction, subject forname, target forname, posx, posy
local function teleport(forname, posx, posy, reposition_starting_lord_for_faction)
  log('Teleport ' .. forname .. 'to (' .. posx .. ', ' .. posy .. ')');
  reposition_starting_lord_for_faction(TAUROX_FACTION, forname, forname, posx, posy);
end;

local function start(cm, reposition_starting_lord_for_faction)
  if not cm:is_new_game() then
    return;
  end;

  -- Teleport stuff
  log('Teleporting Beastmen starting Lords');
  local ok, err = pcall(function()
    teleport(SRUI_FORENAME, TAUROX_POS_X, TAUROX_POS_Y, reposition_starting_lord_for_faction);
    setupStartingDiplomaticRelations(cm);
  end)

  if err then log('Err', err) end;

  return TAUROX_FORENAME;
end;

return start;
