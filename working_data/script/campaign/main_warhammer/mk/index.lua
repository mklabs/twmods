-- main entry point
local mk = {};

mk.utils = require('mk/utils');
mk.constants = require('mk/constants');

mk.Quests = require('mk/lib/Quests');
mk.Chapters = require('mk/lib/Chapters');
mk.LegendaryLords = require('mk/lib/LegendaryLords');

mk.log = require('mk/log');
mk.inspect = require('vendor/inspect');

return mk;
