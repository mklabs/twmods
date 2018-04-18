local_faction = 'mk_taurox_bst_beastmen';

-- Mock
function output(...)
  print(table.unpack({...}));
end


ll_unlock = {}
function ll_unlock:new() end

cm = {}
function cm:new() end
function cm:load_faction_script(filepath)
  print('load', filepath);
  require(filepath);
end
