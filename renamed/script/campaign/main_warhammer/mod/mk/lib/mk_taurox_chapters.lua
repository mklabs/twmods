local log = require('mk/log')('mk:chapters');
local getFaction = require('mk/utils/getFaction');

local constants = require('mk/constants');
local TAUROX_FACTION = constants.TAUROX_FACTION;
local TAUROX_FORENAME = constants.TAUROX_FORENAME;
local TAUROX_NAME = constants.TAUROX_NAME;
local GHORROS_FORENAME = constants.GHORROS_FORENAME;

local function char_is_general(char)
	return char:character_type("general");
end;

local function military_force_is_mobile(military_force)
	return not military_force:is_armed_citizenry();
end;

local function general_with_forename_exists_in_faction_with_force(cm, faction_name, char_forename)
	local faction = getFaction(cm, faction_name);

	if not faction then
		return false;
	end;

	local char_list = faction:character_list();

	for i = 0, char_list:num_items() - 1 do
		local current_char = char_list:item_at(i);

		if current_char:get_forename() == char_forename and char_is_general(current_char) and current_char:has_military_force() and military_force_is_mobile(current_char:military_force()) then
			return true;
		end;
	end;

	return false;
end;

local Chapters = {
  cm = false,
  core = false,
  chapter_mission = false,
  chapters = {}
};

function Chapters:new(cm, core, chapter_mission)
	local chapter = {};
	setmetatable(chapter, self);
	self.__index = self;

	chapter.cm = cm;
  chapter.core = core;
  chapter.chapter_mission = chapter_mission;
  chapter.chapters = {};
	return chapter;
end;

function Chapters:init(chosen_lord)
  local cm = self.cm;
  log('Call init()');

  -- if not cm:is_new_game() then
  --   log('Not a new game, do not init chapter missions');
  --   return;
  -- end;

  log('Starting chapter missions', chosen_lord);
  if general_with_forename_exists_in_faction_with_force(cm, TAUROX_FACTION, TAUROX_FORENAME)
    or (cm:get_saved_value('starting_general_1') == TAUROX_FORENAME or cm:get_saved_value('starting_general_2') == TAUROX_FORENAME) then
    log('Staring general is Taurox the Brass Bull');
    self:taurox();
  elseif general_with_forename_exists_in_faction_with_force(cm, local_faction, GHORROS_FORENAME)
    or (cm:get_saved_value('starting_general_1') == GHORROS_FORENAME or cm:get_saved_value('starting_general_2') == GHORROS_FORENAME) then
    log('Staring general is Ghorros Warhoof');
    self:ghorros();
  else
    log('Starting general is unknown, doing nothing');
  end;
end;

function Chapters:taurox()
  local cm = self.cm;
  local chapter_mission = self.chapter_mission;

  log('Start chapter missions for Taurox');
  local chapter_one_mission = chapter_mission:new(1, TAUROX_FACTION, 'wh_dlc03_objective_beastmen_main_khazrak_01', nil);
  local chapter_two_mission = chapter_mission:new(2, TAUROX_FACTION, 'wh_dlc03_objective_beastmen_main_khazrak_02', nil);
  local chapter_three_mission = chapter_mission:new(3, TAUROX_FACTION, 'wh_dlc03_objective_beastmen_main_khazrak_03', nil);
  local chapter_four_mission = chapter_mission:new(4, TAUROX_FACTION, 'wh_dlc03_objective_beastmen_main_khazrak_04', nil);
  local chapter_five_mission = chapter_mission:new(5, TAUROX_FACTION, 'wh_dlc03_objective_beastmen_main_khazrak_05', nil);

  self.chapters['one'] = chapter_one_mission;
  self.chapters['two'] = chapter_two_mission;
  self.chapters['three'] = chapter_three_mission;
  self.chapters['four'] = chapter_four_mission;
  self.chapters['five'] = chapter_five_mission;

  return chapter_one_mission, chapter_two_mission, chapter_three_mission, chapter_four_mission, chapter_five_mission;
end;

function Chapters:ghorros()
  local cm = self.cm;
  local chapter_mission = self.chapter_mission;

  log('Start chapter missions for Ghorros');
  local chapter_one_mission = chapter_mission:new(1, TAUROX_FACTION, 'wh_dlc05_objective_beastmen_main_morghur_01', nil);
  local chapter_two_mission = chapter_mission:new(2, TAUROX_FACTION, 'wh_dlc05_objective_beastmen_main_morghur_02', nil);
  local chapter_three_mission = chapter_mission:new(3, TAUROX_FACTION, 'wh_dlc05_objective_beastmen_main_morghur_03', nil);
  local chapter_four_mission = chapter_mission:new(4, TAUROX_FACTION, 'wh_dlc05_objective_beastmen_main_morghur_04', nil);
  local chapter_five_mission = chapter_mission:new(5, TAUROX_FACTION, 'wh_dlc05_objective_beastmen_main_morghur_05', nil);

  self.chapters['one'] = chapter_one_mission;
  self.chapters['two'] = chapter_two_mission;
  self.chapters['three'] = chapter_three_mission;
  self.chapters['four'] = chapter_four_mission;
  self.chapters['five'] = chapter_five_mission;

  return chapter_one_mission, chapter_two_mission, chapter_three_mission, chapter_four_mission, chapter_five_mission;
end;

function Chapters:start(key)
  key = key or 'one';
  log('Manually starting chapter mission', key);

  local chapter = self.chapters[key]
  chapter:manual_start();
  return chapter;
end;

return Chapters;
