package.path = package.path .. ';../factions/mk_taurox_bst_beastmen/?.lua';
require('test/mock');

local mk = require('mk/index');
local log = mk.log('mk_bst_beastmen.test.lua');
local constants = mk.constants;

print('ok, lets test');
assert(constants.TAUROX_FACTION);
local campaign = require('mk_taurox_bst_beastmen_start');
print(mk.inspect(campaign));
assert(campaign.quests, 'Quests ok');
assert(campaign.chapters, 'Chapters ok');
assert(campaign.ll, 'll ok');
assert(type(campaign.start_faction) == 'function', 'll ok');
