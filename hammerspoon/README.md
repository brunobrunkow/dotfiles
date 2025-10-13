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

Quickly position and resize windows using keyboard shortcuts.

**Window positioning hotkeys:**
- `Cmd+Option+Left Arrow` - Move window to left half of screen
- `Cmd+Option+Right Arrow` - Move window to right half of screen
- `Cmd+Option+Up Arrow` - Maximize window to full screen
- `Cmd+Option+Down Arrow` - Center window on screen (70% of screen size)

**Quarter-screen positioning hotkeys:**
- `Cmd+Option+U` - Move window to top-left quarter
- `Cmd+Option+I` - Move window to top-right quarter
- `Cmd+Option+N` - Move window to bottom-left quarter
- `Cmd+Option+M` - Move window to bottom-right quarter

**Vim-style window focus navigation:**
- `Cmd+Option+K` - Focus window to the left
- `Cmd+Option+O` - Focus window above
- `Cmd+Option+L` - Focus window below
- `Cmd+Option+Ö` - Focus window to the right

**Window swapping:**
- `Cmd+Option+Shift+K` - Swap focused window with left neighbor
- `Cmd+Option+Shift+O` - Swap focused window with above neighbor
- `Cmd+Option+Shift+L` - Swap focused window with below neighbor
- `Cmd+Option+Shift+Ö` - Swap focused window with right neighbor

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

Provides window positioning, resizing, and focus navigation functionality.

**Functions:**
- `moveToLeft()` - Moves focused window to left half of screen
- `moveToRight()` - Moves focused window to right half of screen
- `maximize()` - Maximizes focused window to full screen
- `center()` - Centers focused window at 70% screen size
- `moveToTopLeft()` - Moves focused window to top-left quarter of screen
- `moveToTopRight()` - Moves focused window to top-right quarter of screen
- `moveToBottomLeft()` - Moves focused window to bottom-left quarter of screen
- `moveToBottomRight()` - Moves focused window to bottom-right quarter of screen
- `focusWindowLeft()` - Focuses the window to the left
- `focusWindowDown()` - Focuses the window below
- `focusWindowUp()` - Focuses the window above
- `focusWindowRight()` - Focuses the window to the right
- `swapWindowLeft()` - Swaps focused window with left neighbor
- `swapWindowDown()` - Swaps focused window with below neighbor
- `swapWindowUp()` - Swaps focused window with above neighbor
- `swapWindowRight()` - Swaps focused window with right neighbor
- `moveToLeftDisplay()` - Moves focused window to the display on the left (west)
- `moveToRightDisplay()` - Moves focused window to the display on the right (east)
- `bindHotkeys(modifiers)` - Binds all window management functions to arrow keys
- `bindQuarterScreenHotkeys(modifiers)` - Binds quarter-screen positioning to U/I/N/M keys
- `bindVimFocusHotkeys(modifiers)` - Binds Vim-style focus navigation to K/O/L/Ö keys
- `bindWindowSwapHotkeys(modifiers)` - Binds window swapping to K/O/L/Ö keys
- `bindMultiDisplayHotkeys(modifiers)` - Binds multi-display functions to arrow keys

**Example:**

```lua
local windowMgmt = require("modules.window-management")

-- Bind all hotkeys with Cmd+Option
windowMgmt.bindHotkeys({"cmd", "alt"})

-- Bind quarter-screen hotkeys with Cmd+Option
windowMgmt.bindQuarterScreenHotkeys({"cmd", "alt"})

-- Bind Vim-style focus navigation with Cmd+Option (K/O/L/Ö)
windowMgmt.bindVimFocusHotkeys({"cmd", "alt"})

-- Bind window swapping with Cmd+Option+Shift (K/O/L/Ö)
windowMgmt.bindWindowSwapHotkeys({"cmd", "alt", "shift"})

-- Bind multi-display hotkeys with Cmd+Option+Ctrl
windowMgmt.bindMultiDisplayHotkeys({"cmd", "alt", "ctrl"})

-- Or call individual functions
windowMgmt.moveToLeft()
windowMgmt.maximize()
windowMgmt.moveToTopLeft()
windowMgmt.focusWindowRight()
windowMgmt.swapWindowLeft()
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
