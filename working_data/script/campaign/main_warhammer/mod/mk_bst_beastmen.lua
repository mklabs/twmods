local log = require('mk/log')('mk_bst_beastmen.lua');
local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;

log('Loaded mk_bst_beastmen');

function mk_bst_beastmen()
  log('Start mk_bst_beastmen()');
  log('Local faction: ' .. local_faction);
  log(cm, core);

  -- Setup listeners for the Moon phase mecanics
  log('Setting up Moon Phase Listeners');
  Add_Moon_Phase_Listeners(TAUROX_FACTION);
end;
