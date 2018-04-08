local log = require('mk/log')('mk:legendary_lords');
log('loaded LegendaryLords');
local getFaction = require('mk/getFaction');

local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;
local TAUROX_FORENAME = require('mk/constants').TAUROX_FORENAME;
local GHORROS_FORENAME = require('mk/constants').GHORROS_FORENAME;
log('Loaded constants');

-- local ll_beastmen = require('mk/legendary_lords_definitions');
-- log('Loaded definitions');
local ll_beastmen = {};

local LegendaryLords = {
	cm = false,
  core = false
};

function LegendaryLords:new(cm, core)
	local ll = {};
	setmetatable(ll, self);
	self.__index = self;

	ll.cm = cm;
	ll.core = core;
	return ll;
end;

function LegendaryLords:start(chosen_lord)
  log('Setup legendary lord for', TAUROX_FACTION);
  log('Chosen lord is', chosen_lord);
  local bst = getFaction(self.cm, TAUROX_FACTION);

  if bst and bst:is_human() then
    for i = 1, #ll_beastmen do
      log('Start legendary lord for ' .. TAUROX_FACTION);
      ll_beastmen[i]:start();
    end;
  end;
end;

function LegendaryLords:lock(chosen_lord)
  local cm = self.cm;

  if not cm:is_new_game() then
    log('Not a new game, not locking anything');
    return;
  end;

  log('Locking LL lords at the start of the game');
  -- Khazrak
  cm:lock_starting_general_recruitment('1902772535', TAUROX_FACTION);
  -- Malagor
  cm:lock_starting_general_recruitment('2072135186', TAUROX_FACTION);
  -- Morghur
  cm:lock_starting_general_recruitment('203069748', TAUROX_FACTION);
  -- Taurox
  if not chosen_lord == TAUROX_FORENAME then
    cm:lock_starting_general_recruitment('1403603105', TAUROX_FACTION);
  end;
  -- Ghorros
  if not chosen_lord == GHORROS_FORENAME then
    cm:lock_starting_general_recruitment('681847135', TAUROX_FACTION);
  end;

  log('Locked LL lords');
end;

return LegendaryLords;
