local log = require('mk/log')('mk:scrollCameraToFactionLeader');

local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_NAME = constants.TAUROX_NAME;
local TAUROX_POS_X = constants.TAUROX_POS_X;
local TAUROX_POS_Y = constants.TAUROX_POS_Y;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;
local GHORROS_POS_X = constants.GHORROS_POS_X;
local GHORROS_POS_Y = constants.GHORROS_POS_Y;
local START_D = constants.START_D;
local START_B = constants.START_B;
local START_H = constants.START_H;

-- Credits to faction unlocker where this snippet comes from.
--
-- Takes a campaign manager instance, faction instance and a callback function.
local function scrollCameraToFactionLeader(cm, faction, done)
  log('mk_scrollCameraToFactionLeader() called ..');
  local faction_leader_cqi = faction:faction_leader():command_queue_index();
  local ok = cm:scroll_camera_with_cutscene(6, function()
    log('Scrolled camera to taurox hopefully');
    done();
  end, {
    TAUROX_POS_X - 190,
    TAUROX_POS_Y - 130,
    START_D,
    START_B,
    START_H
  });

  if not ok then return done('Err: scroll_camera_with_cutscene returned false') end;
end;

return scrollCameraToFactionLeader;
