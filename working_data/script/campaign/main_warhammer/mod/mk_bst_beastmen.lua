local utils = require('mk/utils');
local log = require('mk/log')('mk_bst_beastmen.lua');
local constants = require('mk/constants');

function mk_bst_beastmen()
  log('Start mk_bst_beastmen()');
  -- Setup listeners for the Moon phase mecanics
  log('Setting up Moon Phase Listeners');
  Add_Moon_Phase_Listeners(constants.TAUROX_FACTION);
end;
