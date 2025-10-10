-- app-toggle.lua
-- Module for toggling application visibility with hotkeys
--
-- This module provides functionality to show/hide/launch applications
-- with a single hotkey. If the app is not running, it launches it.
-- If the app is frontmost, it hides it. Otherwise, it brings it to front.

local M = {}

--- Creates a toggle function for a specific application
-- @param appName string The name of the application to toggle
-- @return function A function that toggles the specified application
function M.createToggle(appName)
    return function()
        local app = hs.application.get(appName)

        -- Launch the app if it's not running
        if not app then
            hs.application.launchOrFocus(appName)
            return
        end

        -- Hide the app if it's currently focused
        if app:isFrontmost() then
            app:hide()
        else
            -- Bring the app to front if it's running but not focused
            app:activate()
        end
    end
end

--- Binds a hotkey to toggle an application
-- @param modifiers table Array of modifier keys (e.g., {"cmd"}, {"cmd", "shift"})
-- @param key string The key to bind
-- @param appName string The name of the application to toggle
-- @return hotkey The created hotkey object
function M.bindToggle(modifiers, key, appName)
    local toggleFunc = M.createToggle(appName)
    return hs.hotkey.bind(modifiers, key, toggleFunc)
end

return M
