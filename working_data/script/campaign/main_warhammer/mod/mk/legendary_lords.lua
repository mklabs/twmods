output('Loaded legendary_lords 1');

local log = require('mk/log')('mk:legendary_lords');

local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;
local TAUROX_FORENAME = require('mk/constants').TAUROX_FORENAME;
local GHORROS_FORENAME = require('mk/constants').GHORROS_FORENAME;

-- load the listeners for every human faction
local function ll_setup(chosen_lord)
  log('Setup legendary lord for ' .. TAUROX_FACTION);
  log('Chosen lord is ' .. chosen_lord);
	local bst = get_faction(TAUROX_FACTION);

	if bst and bst:is_human() then
		for i = 1, #ll_beastmen do
      log('Start legendary lord for ' .. TAUROX_FACTION);
			ll_beastmen[i]:start();
		end;
	end;
end;

return {
  ll_setup = ll_setup;
};
