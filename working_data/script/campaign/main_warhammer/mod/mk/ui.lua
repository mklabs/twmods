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
local uuid = 0;

--v function(name: string, parent: CA_UIC, filepath: string) --> CA_UIC
local function createUIC(parent, props)
  props = props or {}
  if not parent then
    log('Not creating component, parent is required');
    return;
  end;

  uuid = uuid + 1;

  local name, filepath, component, offsetX, offsetY = props;
  if not name then
    log('createUIC() failed, name is required');
    return;
  end;

  log('Creating component', name, 'in', parent.name);
  log('Component filepath', filepath);
  log('Component name', component);

  offsetX = offsetX or 0;
  offsetY = offsetY or 0;

  parent:CreateComponent(name, filepath);
  local uic = UIComponent(parent:Find(name));
  if not uic then
    log('Unable to create component', name);
    print_all_uicomponent_children(parent);
    return;
  end;

  if uic then
    parent:Adopt(uic:Address());
    uic:PropagatePriority(parent:Priority());
    Components.positionRelativeTo(uic, parent, offsetX, offsetY);
    return uic;
  end;
end;

local UI = {
  cm = false,
  core = false,
  panel = false,
  root = false,
  uuid = 0
};

function UI:new(cm, core)
  local ui = {};
  setmetatable(ui, self);
  self.__index = self;
  ui.cm = cm;
  ui.core = core;
  ui.uuid = 0;

  log('UI:new, trying to get_ui_root');
  ui.root = core:get_ui_root();
  log('ui.root created');
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

function UI:input(name, parent, offsetX, offsetY)
  log('Creating input', name);
  log('Parent:', parent.name);
  offsetX = offsetX or 20;
  offsetY = offsetY or 40;

  log('Offsets:', offsetX, offsetY);
  local uic = createUIC(parent, {
    name = name,
    filepath = 'ui/common',
    component = 'ui/text_box',
    offsetX = offsetX,
    offsetY = offsetY
  });

  Components.resize(uic, 100, 30);
  return uic;
end;

function UI:createPositionPanel()
  log('Creating new position panel');
  local existingFrame = Util.getComponentWithName('positionPanel');
  if existingFrame then
    log('Frame is already existing, assume existing frame: BUTTON');
    existingFrame:SetVisible(true);
    return;
  end;

  local panel = Frame.new('positionPanel');
  local parent = panel:GetContentPanel();
  panel:Scale(1.5);
  panel:Resize(600, 350);
  panel:SetTitle('Starting position');
  Util.centreComponentOnScreen(panel);
  log('Panel created');

  log('Creating elements');
  local title = Text.new('position_title', parent, 'NORMAL', 'Define your starting position:');
  local labelX = Text.new('label_x', parent, 'NORMAL', 'x');
  local labelY = Text.new('label_y', parent, 'NORMAL', 'y');
  local errorText = Text.new('errorText', parent, 'NORMAL', 'Errors:');
  errorText.SetText('Test ...');
  local inputX = self:input('position_x', parent, 20, 60);
  local inputY = self:input('position_y', parent, 140, 60);
  log('elements created');

  log('position relative to');
  title:PositionRelativeTo(parent, 20, 20);
  labelX:PositionRelativeTo(parent, 20, 60);
  labelY:PositionRelativeTo(parent, 140, 60);
  errorText:PositionRelativeTo(parent, 20, 100);

  log('add close button');
  panel:AddCloseButton(function()
    local valueX = inputX:GetStateText();
    local valueY = inputY:GetStateText();
    local x = tonumber(valueX);
    local y = tonumber(valueY);

    log('Closed button, x:', x, valueX);
    log('Closed button, y:', y, valueY);

    if not x then
      errorText.SetText('Invalid input value for x: ' .. x .. ' (must be a number)');
      log('Invalid input for x must be a number', x);
      return;
    end;

    if not y then
      errorText.SetText('Invalid input value for y: ' .. y .. ' (must be a number)');
      log('Invalid input for y must be a number', y);
      return;
    end;

    log('values:', x, y);
    log('Emit values for position event', x, y);
    self:emit('position', x, y);
    log('Delete panel');
    panel:Delete();
    log('Deleted panel');
  end);

  return panel;
end;
