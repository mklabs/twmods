local function getFaction(cm, key)
	local world = cm:model():world();

	if world:faction_exists(key) then
		return world:faction_by_key(key);
	end;

	return false;
end;

return getFaction;
