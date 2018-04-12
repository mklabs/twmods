local function appendToFile(text)
  local logInterface = io.open('mk_lua_mod_log.txt', 'a');
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

      output = output .. separator .. tostring(v);
    end;

    appendToFile(output);
  end;
end;

return log;
