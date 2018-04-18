
output('Cutscene intro loaded');

function mk_cutscene_intro_play_khazrak()
  local cutscene_intro = campaign_cutscene:new(
    local_faction .. "_intro_khazrak",          -- string name for this cutscene
    94.5,                                        -- length of cutscene in seconds
    function() start_faction() end              -- end callback
  );

  local advice_to_play = {
    "dlc03.camp.prelude.bst.intro.001",
    "dlc03.camp.prelude.bst.intro.002",
    "dlc03.camp.prelude.bst.intro.003",
    "dlc03.camp.prelude.bst.intro.004",
    "dlc03.camp.prelude.bst.intro.005"
  };

  --cutscene_intro:set_debug();
  cutscene_intro:set_skippable(true, function() cutscene_intro_skipped(advice_to_play) end);
  cutscene_intro:set_skip_camera(cam_mp_start_x, cam_mp_start_y, cam_mp_start_d, cam_mp_start_b, cam_mp_start_h);
  cutscene_intro:set_disable_settlement_labels(false);

  cutscene_intro:action(
    function()
      cm:show_shroud(false);
      cm:set_camera_position(cam_mp_start_x, cam_mp_start_y, cam_mp_start_d, cam_mp_start_b, cam_mp_start_h);
      cutscene_intro:cindy_playback("script/campaign/main_warhammer/factions/"..local_faction.."/scenes/beastmen_main_flyover_s01.CindyScene", true, true);
    end,
    0
  );

  -- "Tduigu-Uis" - a greeting in your tongue, my bestial Lord. I know you feel a yearning to kill me, for I am but a man, but you have received the vision, you know who has sent me… my desire is as yours - to see the Cloven Ones tear down all civilisation! So let us begin...
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[1]);
    end,
    0.5
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    24.5
  );

  -- To the north, past the mystic forest of Athel Loren, is Bretonnia. Arrogant and aloof, its glittering spires a sure sign of self-righteousness. You should bring ruin to this "pretty" realm.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[2]);
    end,
    25.0
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    40.5
  );

  -- East of the Bretonnians lie the Empire, the very pinnacle of mankind's hubris. Its capital, Altdorf, is the centre of power and a symbol of its surety. Reduce it all to rubble - let pandemonium reign. The Empire is powerful, but divided. You must strike soon, for it may yet unify and seek to bring "civilisation" to the blood-grounds.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[3]);
    end,
    41
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    67.5
  );

  -- To the south, the Border Princes hold a tentative grip on all that they call theirs, yet are isolated by the mountains and the Blackfire Pass - soft targets for a hungry herd such as ours.
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[4]);
    end,
    68.0
  );
  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    83
  );

  -- Destruction is in your blood, Nuis Ghurleth, and the world must know it. Sow as much as you can - the Cloven Ones shall destroy the world of man!
  cutscene_intro:action(
    function()
      cm:show_advice(advice_to_play[5]);
    end,
    83.5
  );

  cutscene_intro:action(
    function()
      cutscene_intro:wait_for_advisor()
    end,
    94.5
  );

  cutscene_intro:action(
    function()
      cm:show_shroud(true);
    end,
    94.5
  );

  cutscene_intro:start();
end;

function cutscene_intro_skipped(advice_to_play)
  cm:override_ui("disable_advice_audio", true);

  effect.clear_advice_session_history();

  for i = 1, #advice_to_play do
    cm:show_advice(advice_to_play[i]);
  end;

  cm:callback(function() cm:override_ui("disable_advice_audio", false) end, 0.5);
end;
