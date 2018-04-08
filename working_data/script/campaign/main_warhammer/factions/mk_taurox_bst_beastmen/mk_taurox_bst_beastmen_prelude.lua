
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
log("Prelude loaded for " .. local_faction);

function start_beastmen_prelude(chapters)
  log('TAUROX start_beastmen_prelude() called');
  cm:modify_advice(true);

  log('Starting chapter');
  chapters:start();
  log('Chapter started');
end;

