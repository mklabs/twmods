local log = require('mk/log')('mk_taurox.lua');
log('Requiring UI stuff');
local UI = require('mk/ui');
log('Required UI stuff');

function mk_taurox()
  log('[taurox] Loaded mk TAUROX script!');
  log('Init UI stuff');
  local ui = UI:new(cm, core);
end;
