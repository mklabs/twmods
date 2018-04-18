local log = require('mk/log')('mk:apply_beastmen_default_diplomacy');
local getFaction = require('mk/utils/getFaction');
local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;

local function apply_beastmen_default_diplomacy(cm)
  log('Applying beastmen default diplomacy');

  if not cm:is_multiplayer() then
    log('Not a multiplayer game, doing nothing');
    return;
  end;

  -- if Empire/Bretonnia/Dwarfs are human controlled (i.e. MPC) then all options are available to Beastmen (except trade)
  local emp = getFaction(cm, 'wh_main_emp_empire');
  local beast = getFaction(cm, TAUROX_FACTION);
  if beast and emp:is_human() and beast:is_human() then
    cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_emp_empire', 'all', true, true, true);
  end;

  local brt = getFaction(cm ,'wh_main_brt_bretonnia');
  if beast and brt:is_human() and beast:is_human() then
    cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_brt_bretonnia', 'all', true, true, true);
  end;

  local dwf = getFaction(cm, 'wh_main_dwf_dwarfs');
  if beast and dwf:is_human() and beast:is_human() then
    cm:add_default_diplomacy_record('faction:' .. TAUROX_FACTION, 'faction:wh_main_dwf_dwarfs', 'all', true, true, true);
  end;

  log('Applied beastmen default diplomacy');
end;

return apply_beastmen_default_diplomacy;
