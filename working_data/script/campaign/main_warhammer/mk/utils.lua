local apply_beastmen_default_diplomacy = require('mk/utils/apply_beastmen_default_diplomacy');
local apply_effect_bundles = require('mk/utils/apply_effect_bundles');
local setupStartingDiplomaticRelations = require('mk/utils/setupStartingDiplomaticRelations');

return {
  apply_beastmen_default_diplomacy = apply_beastmen_default_diplomacy,
  apply_effect_bundles = apply_effect_bundles,
  setupStartingDiplomaticRelations = setupStartingDiplomaticRelations,
  createHorde = require('mk/utils/createHorde'),
  scrollCameraToFactionLeader = require('mk/utils/scrollCameraToFactionLeader'),
  getFaction = require('mk/utils/getFaction'),
  start = require('mk/utils/start')
};
