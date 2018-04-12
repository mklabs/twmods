# Modding Log Panel

Adds a developper console to the campaign UI when hitting F12.

- Shows tabs for each log type generatyed by the main game (out, design, interventions etc.). Usually logged to script_log_*.txt
- Shows logs for each registered mods that adhere to the debug API.

---

<!-- [!img](img) -->

---


## Debug API

Inspired by https://github.com/visionmedia/debug, modules can load this library
or the standalone logging one to generate logs with namespaces associated with them.

This can be the file name, the type of module or anything you like. You can follow your own convention.

I usually end up with something like:

    DEBUG="modname:*"

With each logger created using the following snippet:

```lua
local debug = require('logpanel/log')('modname:filename');
```

## Options

```lua
-- Change the path to the generated file
LOG_FILENAME = 'path/to/logfile.txt';

-- Turn on/off filesystem file write (default: false)
LOG_WRITE_TO_FILE = true;
local log = require('logpanel/log')('modname');
```
