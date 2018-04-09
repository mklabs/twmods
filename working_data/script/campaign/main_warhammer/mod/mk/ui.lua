-- local e = require('mk/ui/createElement');
-- local render = require('mk/ui/render');
-- log('Loaded mk/ui files');

local log = require('mk/log')('mk:ui');
local Text = require('uic/text');
local Image = require('uic/image');
local Button = require('uic/button');
local TextButton = require('uic/text_button');
local TextBox = require('uic/text_box');
local Util = require ('uic/util');
local Components = require('uic/components');
local FlowLayout = require('uic/layout/flowlayout');
local UIContainer = require('uic/layout/container');
local Frame = require('uic/frame');
local Dummy = require('uic/dummy');
local ListView = require('uic/list_view');
local Gap = require('uic/layout/gap');
log('Loaded uic file');
local Container = require('mk/ui/container');
log('loaded container');

local UI = {
  cm = false,
  core = false,
  panel = false,
  uuid = 0
};

function UI:new(cm, core)
  local ui = {};
  setmetatable(ui, self);
  self.__index = self;
  ui.cm = cm;
  ui.core = core;
  ui.uuid = 0;
  return ui;
end;

function UI:setupListeners()
  local core = self.core;
  log('Setting up listeners');
  self:createPositionListener();
  self:createFlowLayoutListener();
end;

function UI:on(event, listener)
  self.uuid = self.uuid + 1;
  return self:addListener('mk_ui_' .. tostring(self.uuid), event, true, listener, true);
end;

function UI:once(event, listener)
  self.uuid = self.uuid + 1;
  return self:addListener('mk_ui_' .. tostring(self.uuid), event, true, listener, false);
end;

function UI:emit(event, ...)
  return self.core:trigger_event(event, unpack(arg));
end;

function UI:addListener(name, event, condition, callback, persistent)
  log('UI:add_listener(' .. name .. ')', name, event);
  self.core:add_listener(name, event, condition, callback, persistent);
  log('listener added');
end;

-- F12
function UI:createPositionListener()
  return self:addListener(
    'createPositionListener',
    'ShortcutTriggered',
    function(context) return context.string == 'camera_bookmark_view3'; end,
    function(context) self:renderPositionPanel(context) end,
    true
  )
end;

-- F9
function UI:createFlowLayoutListener()
  return self:addListener(
    'createPositionListener',
    'ShortcutTriggered',
    function(context) return context.string == 'camera_bookmark_view0'; end,
    function(context) self:flowLayout(self:defaultPanel(context)) end,
    true
  )
end;

function UI:defaultPanel(context)
  context = context or {};
  if self.panel then
    return self.panel;
  end;

  log('Creating default panel');
  local panel = Frame.new('defaultPanel');
  panel:Scale(1.5);
  panel:SetTitle('Default Panel');
  Util.centreComponentOnScreen(panel);
  panel:AddCloseButton(function()
    log('Close button clicked for default panel');
    log('Emit evt', 'ui.close');
    self:emit('ui.close', panel);
    self.panel = false;
    log('Evt emitted');
  end);

  self.panel = panel;
  return panel;
end;

function UI:renderPositionPanel()
  log('Rendering position panel');
  self:createPositionPanel();
  log('Position panel rendered');
end;

function UI:createPositionPanel()
  log('Creating position panel');
  local existingFrame = Util.getComponentWithName('positionPanel');
  if existingFrame then
    log('Frame is already existing, assume existing frame: BUTTON');
    existingFrame:SetVisible(true);
    return;
  end;

  log('Creating panel');
  local panel = Frame.new('positionPanel');
  local parent = panel:GetContentPanel();
  panel:Scale(1.5);
  panel:SetTitle('Starting position');
  Util.centreComponentOnScreen(panel);
  log('Panel created');

  log('Creating elements');
  local title = Text.new('position_title', parent, 'NORMAL', 'Define your starting position:');
  title:PositionRelativeTo(parent, 20, 20);

  local label_x = Text.new('label_x', parent, 'NORMAL', 'x');
  label_x:PositionRelativeTo(title, 0, 40);
  local input_pos_x = TextBox.new('position_x', parent);
  input_pos_x:Resize(100, 30);
  input_pos_x:PositionRelativeTo(label_x, 20, 0);

  local label_y = Text.new('label_y', parent, 'NORMAL', 'y');
  label_y:PositionRelativeTo(input_pos_x, 120, 0);
  local input_pos_y = TextBox.new('position_y', parent);
  input_pos_y:Resize(100, 30);
  input_pos_y:PositionRelativeTo(label_y, 120, 0);
  log('elements created');

  log('add close button');
  panel:AddCloseButton(function()
    log('Close button clicked' .. input_pos_x:GetText());
    local x = tonumber(input_pos_x:GetText());
    local y = tonumber(input_pos_y:GetText());
    log('x, y values:', x, y);
    log('Emit evt', x, y);
    self:emit('position', x, y);
  end);

  return panel;
end;

function UI:createFlowLayout(panel)
  log('Setting up flow layout demo');
  local mainContainer = UIContainer.new(FlowLayout.VERTICAL);
  local firstButton = TextButton.new("firstButton", panel, "TEXT", "Button One");
  local secondButton = TextButton.new("secondButton", panel, "TEXT", "Button Two");
  local thirdButton = TextButton.new("thirdButton", panel, "TEXT", "Button Three");
  mainContainer:AddComponent(firstButton);
  mainContainer:AddComponent(secondButton);
  mainContainer:AddGap(100);
  mainContainer:AddComponent(thirdButton);

  local horozontalContainer = UIContainer.new(FlowLayout.HORIZONTAL);
  local firstHoroButton = TextButton.new("firstHoroButton", panel, "TEXT", "Button Four");
  local containedVerticalContainer = UIContainer.new(FlowLayout.VERTICAL);
  local firstContainedButton = TextButton.new("firstContainedButton", panel, "TEXT", "Button Five");
  local secondContainedButton = TextButton.new("secondContainedButton", panel, "TEXT", "Button Six");
  containedVerticalContainer:AddComponent(firstContainedButton);
  containedVerticalContainer:AddComponent(secondContainedButton);
  horozontalContainer:AddComponent(firstHoroButton);
  horozontalContainer:AddGap(100);
  horozontalContainer:AddComponent(containedVerticalContainer);
  mainContainer:AddComponent(horozontalContainer);
  Util.centreComponentOnComponent(mainContainer, panel);
  log('Flow layout demo init done');
end;

return UI;
