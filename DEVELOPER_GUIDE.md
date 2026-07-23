# Kale Plugin Development Guide — Path Isolation

## The Problem

When users download a Godot plugin ZIP from GitHub (not git clone), the folder gets renamed.
Example: repo `Kale_Chroma` → download ZIP → extract → folder `Kale_Chroma-main`

Any code using absolute `res://addons/Kale_Chroma/...` paths **breaks** because the actual folder
name differs. This happens because GitHub appends the branch name (`-main`, `-master`) to the ZIP root.

## The Solution (Two Parts)

### Part 1: Self-Discovery in `init.gd`

Every plugin's `init.gd` (EditorPlugin) must discover its own location at runtime:

```gdscript
@tool
extends EditorPlugin

var _plugin_root: String

func _enter_tree():
    _plugin_root = get_script().resource_path.get_base_dir()
    # _plugin_root is now:
    #   "res://addons/Kale_Chroma"        ← if cloned/folder named correctly
    #   "res://addons/Kale_Chroma-main"   ← if downloaded from GitHub ZIP
    #   "res://addons/WhateverName"       ← any name works
```

This returns the ACTUAL folder path regardless of how the user renamed it.

### Part 2: No Absolute `res://` Paths Anywhere

**Preload calls** — Use paths relative to the script file (Godot 4 resolves these
relative to the `.gd` file's directory):

```gdscript
# WRONG (breaks when folder renamed):
const Helper = preload("res://addons/Kale_Chroma/helper.gd")

# RIGHT (always works, resolves relative to this script's directory):
const Helper = preload("helper.gd")
```

**Runtime asset paths** — Build from `_plugin_root` at runtime:

```gdscript
# WRONG:
var dir = DirAccess.open("res://addons/Kale_Chroma/textures/")
var tex = "res://addons/Kale_Chroma/textures/asphalt.png"

# RIGHT:
var dir = DirAccess.open(_plugin_root + "/textures/")
var tex = _plugin_root + "/textures/asphalt.png"
```

**Preset/path dictionaries** — Store only filenames, resolve at access time:

```gdscript
# WRONG:
const PRESETS := {
    "Asphalt": { "texture": "res://addons/Kale_Chroma/textures/asphalt.png" }
}

# RIGHT — store filename only:
const PRESETS := {
    "Asphalt": { "texture": "asphalt.png" }
}

func _get_full_path(filename: String) -> String:
    return _plugin_root + "/textures/" + filename
```

**Cache/file paths** — Use `_plugin_root`, never a hardcoded const:

```gdscript
# WRONG:
const CACHE_DIR := "res://addons/Kale_Chroma/cache/"

# RIGHT:
var cache_dir = _plugin_root + "/cache/"
```

## Passing `_plugin_root` to Dependencies

When your plugin has multiple `.gd` files that need the root path:

```gdscript
# In init.gd:
var tool = preload("tool_foo.gd").new()
tool.plugin_root = _plugin_root

# In dependency scripts, store as static var:
static var plugin_root := ""

# In tool_foo.gd, propagate after receiving:
func set_plugin_root(path: String) -> void:
    plugin_root = path
    MyDep.plugin_root = path
```

Or simply pass the path through `create_material(plugin_root, ...)` etc.

## Checklist for New Plugins

- [ ] `init.gd` uses `get_script().resource_path.get_base_dir()`
- [ ] All `preload()` calls are relative paths (no `res://` prefix)
- [ ] All `DirAccess.open()` paths built from `_plugin_root`
- [ ] All texture/asset paths built from `_plugin_root` at runtime
- [ ] No hardcoded `res://addons/PluginName/...` anywhere
- [ ] Cache/save directories use `_plugin_root`
- [ ] Static preset data stores filenames only, full paths built on access
