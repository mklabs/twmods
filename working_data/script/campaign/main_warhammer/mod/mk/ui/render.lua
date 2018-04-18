local log = require('mk/log')('mk:ui:render');
local e = require('mk/ui/createElement');
local Text = require('uic/text');
local Image = require('uic/image');
local Button = require('uic/button');
local TextButton = require('uic/text_button');
local TextBox = require('uic/text_box');
local Util = require ('uic/util');
local Components = require('uic/components');
local FlowLayout = require('uic/layout/flowlayout');
local Container = require('uic/layout/container');
local Frame = require('uic/frame');
local Dummy = require('uic/dummy');
local ListView = require('uic/list_view');
local Gap = require('uic/layout/gap');

--
--[[
<Frame>
  <Text>Define your starting position</Text>
  <Input name="position_x" />
  <Input name="position_y" />
  <Button onClick="onClickEvent">Apply</Button>
</Frame>
--]]
-- local panel = e('Frame', null,
--   e('Text', { text = 'Define your starting position' }),
--   e('Input', { name = 'position_x' text = 'x' }),
--   e('Input', { name = 'position_y' teyt = 'y' }),
--   e('Button', { onClick = 'onClickEvent' }, 'Apply')
-- );



local function uimf(root)
  log('uimf()', root.key);

  local type, key, props = root;
  local children = props.children;

  local elements = {}
  for i, child in ipairs(children) do
    local element = typeToElement(child, root);
    if not element then
      log('Unable to create element with type', type);
    end;

    elements[i] = element;
  end;

  return elements;
end;

local function typeToElement(child, parent)
  parent = parent or {};
  local type, key, props = child;

  local panel = e('Frame', null,
    e('Text', { text = 'Define your starting position' }),
    e('Input', { name = 'position_x' text = 'x' }),
    e('Input', { name = 'position_y' teyt = 'y' }),
    e('Button', { onClick = 'onClickEvent' }, 'Apply')
  );

  if type == 'Frame' then
    return Frame.new(key or 'Frame');
  elseif type == 'Input' then
    return TextBox.new(key or 'Input', parent);
  elseif type == 'TextBox' then
    return TextBox.new(key or 'TextBox', parent);
  elseif type == 'Text' then
    return Text.new(key or 'Text', parent, 'NORMAL', props.text or 'Default text');
  elseif type == 'Button' then
    return Button.new(key or 'Button', parent, '', props.type or 'SQUARE', props.img or 'ui/skins/default/icon_end_turn.png');
  end;

  log('Unable to create element with type', type);
end;

local function render(element)
  local type, key, props = element;
  log('Rendering element', key);
  log('Type', type);
  log('Props', props);

  local children = {}
  for i, child in ipairs(props.children) do
    log('Creating child element', child.type, child.key);
    children[i] = e(child.type, child.props, child.children);
    log('Created child element');
  end;

  log('Created children tree', table.getn(childs));
  local root = e(type, props, children);
  log('Created root element');
  return uimf(root);
end;

return render;
