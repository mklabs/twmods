load_script_libraries();

bm = battle_manager:new(empire_battle:new());
gc = generated_cutscene:new(true);

gb = generated_battle:new(
	false,                                      -- screen starts black
	false,                                      -- prevent deployment for player
	false,                                      	-- prevent deployment for ai
	function() gb:start_generated_cutscene(gc) end, 	-- intro cutscene function
	false                                      	-- debug mode
);

local subtitles = {
  { orbit = 'gc_orbit_90_medium_commander_front_close_low_01', duration = 4000 },

  { sub = 'wh_dlc03_qb_bst_Morghur_battle_spirit_chaos_pt_01', duration = 7000 },
  { orbit = 'gc_orbit_ccw_360_slow_ground_offset_south_east_extreme_high_02', duration = 3000 },

  { sub = 'wh_dlc03_qb_bst_Morghur_battle_spirit_chaos_pt_02', orbit = 'gc_medium_enemy_army_pan_back_left_to_back_right_close_medium_01', duration = 6000 },
  { orbit = 'gc_orbit_90_medium_commander_back_left_extreme_high_01', duration = 3000 },

  { sub = 'wh_dlc03_qb_bst_Morghur_battle_spirit_chaos_pt_03', duration = 7000 },
  { orbit = 'gc_medium_enemy_army_pan_back_left_to_back_right_close_medium_01', duration = 3000 },

  { sub = 'wh_dlc03_qb_bst_Morghur_battle_spirit_chaos_pt_04',  duration = 7000 },
  { orbit = 'gc_orbit_90_medium_commander_front_close_low_01', duration = 7000 }
};

for i, sub in ipairs(subtitles) do
  output('Adding subtitle');

  local key = sub.sub;
  local duration = sub.duration;
  local orbit = sub.orbit;

  if orbit and not key then
    gc:add_element(nil, nil, orbit, duration, false, false, false);
  else
    gc:add_element(key, key, orbit, duration, false, false, false);
  end;
end

gb:set_cutscene_during_deployment(true);
gb:set_objective_on_message('deployment_started', 'wh_main_qb_objective_attack_defeat_army');
ga_ai = gb:get_army(gb:get_non_player_alliance_num(), 1);
gb:queue_help_on_message('battle_started', 'wh_dlc03_qb_bst_malagor_the_dark_omen_icon_of_vilification_stage_3_hint_objective');
