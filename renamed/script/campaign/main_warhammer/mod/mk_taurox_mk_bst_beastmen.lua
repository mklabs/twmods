local log = require('mk/log')('mk_bst_beastmen.lua');
local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;

function mk_bst_beastmen()
  log('Start mk_bst_beastmen()');
  -- Setup listeners for the Moon phase mecanics
  log('Setting up Moon Phase Listeners');
  Add_Moon_Phase_Listeners(TAUROX_FACTION);
end;
