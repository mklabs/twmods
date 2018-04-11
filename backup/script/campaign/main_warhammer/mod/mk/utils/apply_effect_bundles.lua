local log = require('mk/log')('mk:apply_effect_bundles');
local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;

local function apply_effect_bundles(cm)
  log('Applying effect bundles to own faction for low morale immunity and animosity bonus');
  cm:apply_effect_bundle('wh_dlc03_low_morale_attrition_immunity', TAUROX_FACTION, -1);
  cm:apply_effect_bundle('wh2_main_bundle_greenskin_animosity_bonus', TAUROX_FACTION, -1);
end;

return apply_effect_bundles;
