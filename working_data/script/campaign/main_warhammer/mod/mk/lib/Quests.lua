local log = require('mk/log')('mk:quests');
local TAUROX_FACTION = require('mk/constants').TAUROX_FACTION;
local getFaction = require('mk/utils/getFaction');

local function areAllFinalBattleFactionsDead(cm)
  local factions = {
    "wh_main_emp_empire",
    "wh_main_brt_bretonnia",
    "wh_main_emp_averland",
    "wh_main_emp_hochland",
    "wh_main_emp_middenland",
    "wh_main_emp_nordland",
    "wh_main_emp_ostland",
    "wh_main_emp_ostermark",
    "wh_main_emp_stirland",
    "wh_main_emp_talabecland",
    "wh_main_emp_wissenland",
    "wh_dlc05_wef_wood_elves"
  };

  for i = 1, #factions do
    if not getFaction(cm, factions[i]):is_dead() then
      return false;
    end;
  end;

  return true;
end;

local Quests = {
  cm = false,
  core = false,
  set_up_rank_up_listener = false
};

function Quests:new(cm, core, set_up_rank_up_listener)
	local quest = {};
	setmetatable(quest, self);
	self.__index = self;

	quest.cm = cm;
  quest.core = core;
  quest.set_up_rank_up_listener = set_up_rank_up_listener;
	return quest;
end;

function Quests:addTauroxQuestBattleListener()
  local cm = self.cm;
  local core = self.core;
  log('Adding final quest battle listener');

  if not cm:get_saved_value('mk_taurox_bst_taurox_battle_quest') then
    core:add_listener(
      'Taurox_Quest_Battle',
      'FactionTurnStart',
      function(context)
        local faction = context:faction();
        return faction:is_human() and faction:name() == TAUROX_FACTION;
      end,
      function()
        log('Trigger mission mk_taurox_bst_taurox_dual_cleaver');
        cm:trigger_mission(TAUROX_FACTION, 'mk_taurox_bst_taurox_dual_cleaver', true);
        cm:set_saved_value('mk_taurox_bst_taurox_battle_quest', true);
      end,
      false
    );
  end;
end;

function Quests:addFinalQuestBattleListener()
  local cm = self.cm;
  local core = self.core;
  log('Adding final quest battle listener');

  if not cm:get_saved_value('bst_final_battle_quest') then
    core:add_listener(
      'Beastmen_Final_Battle',
      'FactionTurnStart',
      function(context)
        local faction = context:faction();
        return faction:is_human() and faction:name() == TAUROX_FACTION and areAllFinalBattleFactionsDead(cm);
      end,
      function()
        log('Trigger mission wh_dlc03_qb_bst_the_final_battle');
        cm:trigger_mission(TAUROX_FACTION, 'wh_dlc03_qb_bst_the_final_battle', true);
        cm:set_saved_value('bst_final_battle_quest', true);
      end,
      false
    );
  end;
end;


function Quests:setupRankupListerners()
	log('Quests setupRankupListerners()');
  local set_up_rank_up_listener = self.set_up_rank_up_listener;

	local taurox_subtype = 'mk_taurox_bst_taurox';
	local ghorros_subtype = 'mk_taurox_bst_ghorros';

	-- type, ancillary key, mission key, rank required, [optional] mission key if playing MPC
	local taurox_quests = {
		{ 'mission', 'mk_taurox_anc_weapon_rune_tortured_axe', 'mk_taurox_bst_taurox_dual_cleaver_stage1', 7 }
	};

  log('Setting up Taurox quest to unlock at rank', 7, 'with', 'mk_taurox_bst_taurox_dual_cleaver_stage1');
	set_up_rank_up_listener(taurox_quests, taurox_subtype);
end;

return Quests;
