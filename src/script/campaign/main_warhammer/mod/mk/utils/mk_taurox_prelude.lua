
local function prelude(campaign, done)
  local cm = campaign.cm;
  local chapters = campaign.chapters;

  cm:modify_advice(true);
  chapters:start();

  if type(done) == 'function' then return done() end;
end;

return prelude;
