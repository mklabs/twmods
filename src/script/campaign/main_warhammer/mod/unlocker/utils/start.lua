local log = require('unlocker/log')('unlocker:start');
log('Start module loaded');

local constants = require('unlocker/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_NAME = constants.TAUROX_NAME;
local TAUROX_POS_X = constants.TAUROX_POS_X;
local TAUROX_POS_Y = constants.TAUROX_POS_Y;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
local GHORROS_POS_X = constants.GHORROS_POS_X;
local GHORROS_POS_Y = constants.GHORROS_POS_Y;

function campaign_manager:teleport_to(char_str, x, y, use_command_queue)
	if not is_string(char_str) then
		script_error("ERROR: teleport_to() called but supplied character lookup [" .. tostring(char_str) .. "] is not a string");
		return false;
	end;

	if not is_number(x) or x <= 0 then
		script_error("ERROR: teleport_to() called but supplied x co-ordinate [" .. tostring(x) .. "] is not a positive number");
		return false;
	end;

	if not is_number(y) or y <= 0 then
		script_error("ERROR: teleport_to() called but supplied y co-ordinate [" .. tostring(y) .. "] is not a positive number");
		return false;
	end;

	use_command_queue = not not use_command_queue;

	return self.game_interface:teleport_to(char_str, x, y, use_command_queue);
end;

-- Character selected, forename names_name_2147358411, surname names_name_2147358686, position [428, 115], faction wh2_main_bst_blooded_axe, cqi 117
local function start(cm, reposition_starting_lord_for_faction)
  log('Start function called');
  if not cm:is_new_game() then
    return;
  end;

  log('Teleporting Beastmen starting Lords');

  local sruiForename = 'names_name_2147358411';
  local sruiSurname = 'names_name_2147358686';

  -- Taurox... move to Chaos wastelands area, Chaos start position
  log('Reposition taurox');
  -- function reposition_starting_lord_for_faction(faction_name, subject_lord_forename, target_lord_forename, new_pos_x, new_pos_y)
  reposition_starting_lord_for_faction(TAUROX_FACTION, sruiForename, sruiForename, TAUROX_POS_X, TAUROX_POS_Y);



  -- Ghorros... move to Morghur start position
  -- log('Reposition Ghorros');
  -- reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, GHORROS_FORENAME, GHORROS_POS_X, GHORROS_POS_Y);
  -- local ghorros_is_chosen_lord = reposition_starting_lord_for_faction(TAUROX_FACTION, GHORROS_FORENAME, 'names_name_2147357951', GHORROS_POS_X + 3, GHORROS_POS_Y - 2); -- second army

  -- local chosen_lord = '';
  -- if taurox_is_chosen_lord then
  --   chosen_lord = TAUROX_FORENAME;
  --   cm:force_declare_war('wh_main_grn_top_knotz', TAUROX_FACTION, false, false);
  -- elseif ghorros_is_chosen_lord then
  --   chosen_lord = GHORROS_FORENAME;
  --   cm:force_declare_war('wh2_main_def_naggarond', TAUROX_FACTION, false, false);
  -- else
  --   cm:force_declare_war('wh_main_teb_estalia', TAUROX_FACTION, false, false);
  -- end;

  return chosen_lord;
end;

return start;
