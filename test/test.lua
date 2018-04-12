require('test/mock');

package.path = package.path .. ';./src/script/campaign/main_warhammer/mod/?.lua';
local unlocker = require('unlocker/index');
local log = unlocker.log('unlocker_bst_beastmen.test.lua');
local constants = unlocker.constants;

print('ok, lets test');
assert(constants.TAUROX_FACTION);

local campaign = require('mk_bst_beastmen_start');
print(unlocker.inspect(campaign));
assert(campaign.quests, 'Quests ok');
assert(campaign.chapters, 'Chapters ok');
assert(campaign.ll, 'll ok');
assert(type(campaign.start_faction) == 'function', 'll ok');
