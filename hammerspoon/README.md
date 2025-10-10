# Hammerspoon Configuration

This is a modular Hammerspoon configuration for macOS automation and window management.

## Structure

```
~/.hammerspoon/
├── init.lua                    # Main configuration file
├── modules/                    # Modular functionality
│   ├── app-toggle.lua         # Application toggle module
│   ├── media-controls.lua     # Media control module
│   └── window-management.lua  # Window positioning module
└── README.md                  # This file
```

## Features

### Application Toggle

Toggle applications with a single hotkey. If the app isn't running, it launches. If it's focused, it hides. If it's running but not focused, it brings it to front.

**Current bindings:**
- `Cmd+Space` - Toggle Ghostty terminal

### Window Management

Quickly position and resize windows using arrow keys.

**Window positioning hotkeys:**
- `Cmd+Option+Left Arrow` - Move window to left half of screen
- `Cmd+Option+Right Arrow` - Move window to right half of screen
- `Cmd+Option+Up Arrow` - Maximize window to full screen
- `Cmd+Option+Down Arrow` - Center window on screen (70% of screen size)

**Multi-display hotkeys:**
- `Cmd+Option+Ctrl+Left Arrow` - Move window to left display
- `Cmd+Option+Ctrl+Right Arrow` - Move window to right display

### Media Controls

Control system volume using mouse buttons.

**Volume control:**
- `Mouse Button 4` (side button) - Increase volume by 5%
- `Mouse Button 5` (side button) - Decrease volume by 5%

### Configuration Reload

- `Cmd+Option+Shift+R` - Reload Hammerspoon configuration

## Usage

### Adding Application Hotkeys

To add a new application hotkey, edit `init.lua` and add a line under the "Application Hotkeys" section:

```lua
appToggle.bindToggle({"cmd", "shift"}, "b", "Safari")
```

This binds `Cmd+Shift+B` to toggle Safari.

### Adding Custom Modules

1. Create a new `.lua` file in the `modules/` directory
2. Define your module as a table with functions
3. Return the module table at the end of the file
4. Load it in `init.lua` with `require("modules.your-module")`

Example module structure:

```lua
-- modules/example.lua
local M = {}

function M.someFunction()
    -- Your code here
end

return M
```

Then in `init.lua`:

```lua
local example = require("modules.example")
example.someFunction()
```

## Modules

### app-toggle.lua

Provides functionality to toggle application visibility.

**Functions:**
- `createToggle(appName)` - Creates a toggle function for an application
- `bindToggle(modifiers, key, appName)` - Binds a hotkey to toggle an application

**Example:**

```lua
local appToggle = require("modules.app-toggle")

-- Create a toggle function
local toggleSafari = appToggle.createToggle("Safari")

-- Or bind directly to a hotkey
appToggle.bindToggle({"cmd", "shift"}, "b", "Safari")
```

### window-management.lua

Provides window positioning and resizing functionality.

**Functions:**
- `moveToLeft()` - Moves focused window to left half of screen
- `moveToRight()` - Moves focused window to right half of screen
- `maximize()` - Maximizes focused window to full screen
- `center()` - Centers focused window at 70% screen size
- `moveToLeftDisplay()` - Moves focused window to the display on the left (west)
- `moveToRightDisplay()` - Moves focused window to the display on the right (east)
- `bindHotkeys(modifiers)` - Binds all window management functions to arrow keys
- `bindMultiDisplayHotkeys(modifiers)` - Binds multi-display functions to arrow keys

**Example:**

```lua
local windowMgmt = require("modules.window-management")

-- Bind all hotkeys with Cmd+Option
windowMgmt.bindHotkeys({"cmd", "alt"})

-- Bind multi-display hotkeys with Cmd+Option+Ctrl
windowMgmt.bindMultiDisplayHotkeys({"cmd", "alt", "ctrl"})

-- Or call individual functions
windowMgmt.moveToLeft()
windowMgmt.maximize()
windowMgmt.moveToLeftDisplay()
```

### media-controls.lua

Provides media control functionality including volume control.

**Functions:**
- `volumeUp()` - Increases system volume by 5%
- `volumeDown()` - Decreases system volume by 5%
- `bindMouseButtons()` - Binds mouse buttons 4 and 5 to volume controls

**Example:**

```lua
local mediaControls = require("modules.media-controls")

-- Bind mouse buttons to volume controls
mediaControls.bindMouseButtons()

-- Or call volume functions directly
mediaControls.volumeUp()
mediaControls.volumeDown()
```

## Resources

- [Hammerspoon Documentation](https://www.hammerspoon.org/docs/)
- [Hammerspoon API Reference](https://www.hammerspoon.org/docs/index.html)
- [Hammerspoon Getting Started](https://www.hammerspoon.org/go/)

## Notes

- Configuration changes require a reload to take effect (use `Cmd+Option+Shift+R`)
- Window animations are enabled with a 0.2 second duration (default)
- A notification is shown when the configuration loads successfully
