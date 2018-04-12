package.path = package.path .. ';src/script/?.lua';

local logpanel = require('logpanel');
local log = logpanel.log('test')

log('log');
assert(logpanel);
