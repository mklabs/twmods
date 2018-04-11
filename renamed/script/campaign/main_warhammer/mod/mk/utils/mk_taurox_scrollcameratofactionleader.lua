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

-- Credits to faction unlocker where this snippet comes from
local function scrollCameraToFactionLeader(chosen_lord)
  log('mk_scrollCameraToFactionLeader() called ..');
  log('Chosen lord is ' .. chosen_lord);

  if chosen_lord == TAUROX_FORENAME then
    log('Scrolling to taurox', TAUROX_POS_X, TAUROX_POS_Y);
    -- cm:scroll_camera_with_cutscene(6, function() log('Scrolled camera to taurox hopefully') end, {TAUROX_POS_X, TAUROX_POS_Y, START_D, START_B, START_H});
  elseif chosen_lord == GHORROS_FORENAME then
    log('Scrolling to ghorros', GHORROS_POS_X, GHORROS_POS_Y);
    -- cm:scroll_camera_with_cutscene(6, function() log('Scrolled camera to ghorros hopefully') end, {GHORROS_POS_X, GHORROS_POS_Y, START_D, START_B, START_H});
  end;
end;
