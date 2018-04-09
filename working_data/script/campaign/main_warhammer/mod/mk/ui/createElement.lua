local log = require('mk/log')('mk:ui:createElement');
local uuid = 0;

local function ReactElement(type, key, props)
  local element = {
    typeof = 'UI_ELEMENT_TYPE',
    -- Built-in properties that belong on the element
    type = type,
    key = key,
    props = props
  };

  return element;
end;

-- Modeled after React.createElement
--
-- React.createElement(
--   type,
--   [props],
--   [...children]
-- )
local function createElement(type, props, children)
  log('createElement()', type);
  props = props or {}
  children = props or {}

  uuid = uuid + 1;
  local key = 'key_' .. uuid;

  -- Children can be more than one argument, and those are transferred onto
  -- the newly allocated props object.
  local childrenLength = table.getn(children);
  if childrenLength == 1 then
    props.children = children;
  elseif childrenLength > 1 then
    local childs = {}
    for i, child in ipairs(children) do
      childs[i] = child;
    end;
    props.children = childs;
  end;

  return ReactElement(
    type,
    key,
    props
  );
end;

return createElement;
