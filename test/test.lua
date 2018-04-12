require('test/mock');

package.path = package.path .. ';./src/script/campaign/main_warhammer/mod/?.lua';
package.path = package.path .. ';./src/script/campaign/main_warhammer/factions/?.lua';
local unlocker = require('unlocker/index');
local log = unlocker.log('unlocker_bst_beastmen.test.lua');
local constants = unlocker.constants;
assert(constants.TAUROX_FACTION);

local campaign = require('wh2_main_bst_blooded_axe/wh2_main_bst_blooded_axe_start');
print(unlocker.inspect(campaign));
assert(campaign.quests, 'Quests ok');
assert(campaign.chapters, 'Chapters ok');
assert(campaign.ll, 'll ok');
assert(type(campaign.start_faction) == 'function', 'll ok');
