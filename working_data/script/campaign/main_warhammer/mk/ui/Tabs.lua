local log = require('mk/log')('mk:ui:tabs');

local Tabs = '{}'

function Tabs:new()
  local tabs = {};
  setmetatable(tabs, self);
  self.__index = self;
  return tabs;
end;

return Tabs
