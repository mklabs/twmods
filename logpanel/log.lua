local inspect = require('vendor/inspect');

LOG_FILENAME = LOG_FILENAME or 'logpanel.log';
LOG_WRITE_TO_FILE = type(LOG_WRITE_TO_FILE) == 'boolean' and LOG_WRITE_TO_FILE or false;
LOG_PRINT = type(LOG_PRINT) == 'boolean' and LOG_PRINT or false;

local function appendToFile(text)
  local filename = LOG_FILENAME or  ' '

  -- noop when write to filesystem disabled
  if not LOG_WRITE_TO_FILE then return end;

  local logInterface = io.open(filename, 'a');
  logInterface:write(text..'\n');
  logInterface:flush();
  logInterface:close();
end

local function log(str)
  local prefix = str or '';
  appendToFile('[log.lua] Initializing a new logger (' .. prefix .. ')');

  return function (...)
    local output = '[' .. prefix .. '] ';
    for i,v in ipairs(arg) do
      local separator = ' ';
      if i == 0 then
        separator = '';
      end;

      if type(v) ~= 'string' then v = inspect(v)  end;
      output = output .. separator .. tostring(v);
    end;

    appendToFile(output);
  end;
end;

return log;
