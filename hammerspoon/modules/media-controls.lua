-- media-controls.lua
-- Module for media control with mouse buttons
--
-- This module provides functionality to control system volume and media
-- playback using mouse buttons and keyboard shortcuts.

local M = {}

--- Increases system volume using native macOS volume control
function M.volumeUp()
    hs.eventtap.event.newSystemKeyEvent("SOUND_UP", true):post()
    hs.eventtap.event.newSystemKeyEvent("SOUND_UP", false):post()
end

--- Decreases system volume using native macOS volume control
function M.volumeDown()
    hs.eventtap.event.newSystemKeyEvent("SOUND_DOWN", true):post()
    hs.eventtap.event.newSystemKeyEvent("SOUND_DOWN", false):post()
end

--- Binds mouse button 4 and 5 to volume controls
-- Mouse button 4: Volume up
-- Mouse button 5: Volume down
function M.bindMouseButtons()
    -- Create an eventtap to watch for mouse button events
    M.mouseButtonTap = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(event)
        local buttonNumber = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)

        -- Mouse button 4 (typically back/left side button) = volume down
        if buttonNumber == 3 then  -- Button 4 is index 3 (0-indexed)
            M.volumeDown()
            return true  -- Consume the event
        end

        -- Mouse button 5 (typically forward/right side button) = volume up
        if buttonNumber == 4 then  -- Button 5 is index 4 (0-indexed)
            M.volumeUp()
            return true  -- Consume the event
        end

        return false  -- Pass through other mouse buttons
    end)

    M.mouseButtonTap:start()
    return M.mouseButtonTap
end

return M
