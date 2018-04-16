local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;
local TAUROX_FORENAME = require('mk/constants').TAUROX_FORENAME;
local GHORROS_FORENAME = require('mk/constants').GHORROS_FORENAME;

local function ll_beastmen(ll_unlock)
  return {
     -- Khazrak
     ll_unlock:new(
      TAUROX_FACTION,
      '1902772535',
      'names_name_1369338020',
      'CharacterPostBattleRelease',
      function(context)
        if context:character():faction():name() == TAUROX_FACTION then
          local release_count = cm:get_saved_value('ll_beastmen_khazrak_release_count');
          if release_count == nil then release_count = 0 end;

          release_count = release_count + 1;

          cm:set_saved_value('ll_beastmen_khazrak_release_count', release_count);

          return release_count > 9;
        end
      end
    ),

    -- Malagor
    ll_unlock:new(
      TAUROX_FACTION,
      '2072135186',
      'names_name_435392760',
      'MilitaryForceBuildingCompleteEvent',
      function(context)
        return context:building() == 'wh_dlc03_horde_beastmen_gors_2' and context:character():faction():name() == TAUROX_FACTION;
      end
    ),

    -- Morghur
    ll_unlock:new(
      TAUROX_FACTION,
      '203069748',
      'names_name_1871285548',
      'UnitCreated',
      function(context)
        return context:unit():unit_key() == 'wh_dlc03_bst_mon_chaos_spawn_0' and context:unit():faction():name() == TAUROX_FACTION;
      end
    ),

    -- Taurox
    ll_unlock:new(
      TAUROX_FACTION,
      '1403603105',
      'names_name_709296598',
      'MilitaryForceBuildingCompleteEvent',
      function(context)
        return context:building() == 'wh_dlc03_horde_beastmen_minotaurs_1' and context:character():faction():name() == TAUROX_FACTION;
      end
    )
  };
end;

return ll_beastmen;
