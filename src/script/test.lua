local filename = "campaign/main_warhammer/mod/mk_mod.lua";

function load_mod_script(script_file)
  print('current_file', current_file);
	local current_file = script_file;
  print('current_file', current_file);
	local pointer = 1;

  print('current_file', current_file);
	while true do
		local next_separator = string.find(current_file, "\\", pointer) or string.find(current_file, "/", pointer);

		if next_separator then
			pointer = next_separator + 1;
		else
			if pointer > 1 then
				current_file = string.sub(current_file, pointer);
			end
			break;
		end
	end

  print('current_file', current_file);
	local suffix = string.sub(current_file, string.len(current_file) - 3);

	if string.lower(suffix) == ".lua" then
		current_file = string.sub(current_file, 1, string.len(current_file) - 4);
	end

	-- Loads a Lua chunk from the file
  print('current_file', current_file);
	local loaded_file = loadfile(current_file);

  print('maoow' .. tostring(loaded_file));
	-- Make sure something was loaded from the file
	if loaded_file then
    log('loaded_file 1');
		-- Get the local environment
		local local_env = getfenv(1);
    log('loaded_file 2');
		-- Set the environment of the Lua chunk to the same one as this file
		setfenv(loaded_file, local_env);
    log('loaded_file 3');
		-- Make sure the file is set as loaded
		package.loaded[current_file] = true;
		-- Execute the loaded Lua chunk so the functions within are registered
    log('loaded_file 4');
		loaded_file();
    log('loaded_file 5');
		-- Add this to list of loaded mod scripts
		table.insert(mod_script_files, current_file);
	end
end

local ok, err = pcall(load_mod_script, filename);
if not ok then
  print('ERR:');
  print(err)
end
print('ok', ok);
