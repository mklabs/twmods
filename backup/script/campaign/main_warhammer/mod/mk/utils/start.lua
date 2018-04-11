local log = require('mk/log')('mk:start');
log('Start module loaded');

local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_NAME = constants.TAUROX_NAME;
local TAUROX_POS_X = constants.TAUROX_POS_X;
local TAUROX_POS_Y = constants.TAUROX_POS_Y;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
local GHORROS_POS_X = constants.GHORROS_POS_X;
local GHORROS_POS_Y = constants.GHORROS_POS_Y;

local function start(cm, reposition_starting_lord_for_faction)
  log('Start function called');
  if not cm:is_new_game() then
    return;
  end;

  log('Teleporting Beastmen starting Lords');

  -- Taurox... move to Chaos wastelands area, Chaos start position
  log('Reposition taurox');
  reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, TAUROX_FORENAME, TAUROX_POS_X, TAUROX_POS_Y);
  local taurox_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, TAUROX_FORENAME, 'names_name_2147357951', TAUROX_POS_X - 2, TAUROX_POS_Y + 2); -- second army

  -- Ghorros... move to Morghur start position
  log('Reposition Ghorros');
  reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, GHORROS_FORENAME, GHORROS_POS_X, GHORROS_POS_Y);
  local ghorros_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, 'names_name_2147357951', GHORROS_POS_X + 3, GHORROS_POS_Y - 2); -- second army

  local chosen_lord = '';
  if taurox_is_chosen_lord then
    chosen_lord = TAUROX_FORENAME;
    cm:force_declare_war('wh_main_grn_top_knotz', TAUROX_FACTION, false, false);
  elseif ghorros_is_chosen_lord then
    chosen_lord = GHORROS_FORENAME;
    cm:force_declare_war('wh2_main_def_naggarond', TAUROX_FACTION, false, false);
  else
    cm:force_declare_war('wh_main_teb_estalia', TAUROX_FACTION, false, false);
  end;

  return chosen_lord;
end;

return start;
