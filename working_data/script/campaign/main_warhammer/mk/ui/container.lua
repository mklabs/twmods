local log = require('mk/log')('mk:ui:container');
log('Loaded container.lua');

-- log('Setup containers');
-- local main = Container:new('vertical', parent);
-- local form = Container:new('horizontal', parent);
-- log('Containers created');
-- log('Setup elements in containers');
-- main:add(title);
-- form:add(label_x);
-- form:add(input_pos_x);
-- form:add(label_y);
-- form:add(input_pos_y);
-- main:add(form);
-- Util.centreComponentOnComponent(main, parent);
-- Util.centreComponentOnComponent(form, main);


local FlowLayout = require('uic/layout/flowlayout');
local UIContainer = require('uic/layout/container');
local Gap = require('uic/layout/gap');
log('uimf components loaded for container');

local Container = {
  uuid = 0,
  parent = false,
  direction = 'horizontal',
  container = false,
  parent = false
};

function Container:new(direction, parent)
  local container = {};
  setmetatable(container, self);
  self.__index = self;
  container.uuid = 0;
  container.direction = direction or 'horizontal';
  container.container = UIContainer.new(container.direction == 'horizontal' and FlowLayout.HORIZONTAL or FlowLayout.VERTICAL);
  container.parent = parent;

  log('Created container with direction', direction, container.parent.name);
  return container;
end;

function Container:add(component)
  log('container.add', component.name, 'in', self.parent);
  self.container:AddComponent(component);
  log('component added');
end;

function Container:appendTo(component)
  log('container.appendTo', component.name, 'in', self.parent);
  component:AddComponent(self.container);
end;

function Container:gap(num)
  num = num or 10;
  log('Create gap', num);
  self.container:AddGap(num);
  log('Gap created', num);
end;

return Container;
