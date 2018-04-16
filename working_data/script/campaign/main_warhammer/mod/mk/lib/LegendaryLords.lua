local log = require('mk/log')('mk:legendary_lords');
local getFaction = require('mk/utils/getFaction');
local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;

local lords = require('mk/lib/lords');

local LegendaryLords = {
	cm = false,
  core = false,
  ll_unlock = false
};

function LegendaryLords:new(cm, core, ll_unlock)
	local ll = {};
	setmetatable(ll, self);
	self.__index = self;

	ll.cm = cm;
	ll.core = core;
  ll.ll_unlock = ll_unlock;
	return ll;
end;

function LegendaryLords:start(chosen_lord)
  log('Setup legendary lord for', TAUROX_FACTION);
  log('Chosen lord is', chosen_lord);
  local bst = getFaction(self.cm, TAUROX_FACTION);
  log('faction', self.ll_unlock);
  local ll_beastmen = lords(self.ll_unlock);
  log('ll_beastmen ok ', #ll_beastmen);
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

  -- -- Taurox
  -- if not chosen_lord == TAUROX_FORENAME then
  --   cm:lock_starting_general_recruitment('1403603105', TAUROX_FACTION);
  -- end;
  -- -- Ghorros
  -- if not chosen_lord == GHORROS_FORENAME then
  --   cm:lock_starting_general_recruitment('681847135', TAUROX_FACTION);
  -- end;

  log('Locked LL lords');
end;

return LegendaryLords;
