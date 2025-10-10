-- media-controls.lua
-- Module for media control with mouse buttons
--
-- This module provides functionality to control system volume and media
-- playback using mouse buttons and keyboard shortcuts.

local M = {}

-- Volume adjustment step (percentage)
local VOLUME_STEP = 5

--- Increases system volume by the defined step
function M.volumeUp()
    local device = hs.audiodevice.defaultOutputDevice()
    if device then
        local currentVolume = device:outputVolume()
        local newVolume = math.min(currentVolume + VOLUME_STEP, 100)
        device:setOutputVolume(newVolume)
    end
end

--- Decreases system volume by the defined step
function M.volumeDown()
    local device = hs.audiodevice.defaultOutputDevice()
    if device then
        local currentVolume = device:outputVolume()
        local newVolume = math.max(currentVolume - VOLUME_STEP, 0)
        device:setOutputVolume(newVolume)
    end
end

--- Binds mouse button 4 and 5 to volume controls
-- Mouse button 4: Volume up
-- Mouse button 5: Volume down
function M.bindMouseButtons()
    -- Create an eventtap to watch for mouse button events
    local mouseButtonTap = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(event)
        local buttonNumber = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)

        -- Mouse button 4 (typically back/left side button) = volume up
        if buttonNumber == 3 then  -- Button 4 is index 3 (0-indexed)
            M.volumeUp()
            return true  -- Consume the event
        end

        -- Mouse button 5 (typically forward/right side button) = volume down
        if buttonNumber == 4 then  -- Button 5 is index 4 (0-indexed)
            M.volumeDown()
            return true  -- Consume the event
        end

        return false  -- Pass through other mouse buttons
    end)

    mouseButtonTap:start()
    return mouseButtonTap
end

return M
