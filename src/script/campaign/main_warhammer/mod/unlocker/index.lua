-- main entry point
local unlocker = {};

unlocker.utils = require('unlocker/utils');
unlocker.constants = require('unlocker/constants');

unlocker.Quests = require('unlocker/lib/Quests');
unlocker.Chapters = require('unlocker/lib/Chapters');
unlocker.LegendaryLords = require('unlocker/lib/LegendaryLords');

unlocker.log = require('unlocker/log');
unlocker.inspect = require('vendor/inspect');

return unlocker;
