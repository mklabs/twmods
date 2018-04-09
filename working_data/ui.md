## UI

Spent a night digging into UI modding framework.

---

Basically, there's a CA_uic thing that lives in data/$type $ui/component.

These are precompiled raw component we can use in our scripts. Unfortunately, we're unable to edit them.

---

The idea is to develop a higher level API to build and compose those uic components.

Types:

- common: ui/common ui
- battle: ui/battle ui
- campaign: ui/campaign ui
- frontend: ui/frontend ui
- loading: ui/loading ui


API:

```lua
-- Top lvl element factory

uic = element(type, component, props, children...);

-- wrappers
common(component, props, children...) => uic
battle(component, props, children...) => uic
campaign(component, props, children...) => uic
frontend(component, props, children...) => uic
loading(component, props, children...) => uic
```

Example:

```lua
local panel = uic:campaign('objectives_screen');
```
