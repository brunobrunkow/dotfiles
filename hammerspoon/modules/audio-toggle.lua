-- audio-toggle.lua
-- Module for toggling between audio output devices

local M = {}

--- Toggles between two audio output devices
-- @param device1 string Name of first audio device
-- @param device2 string Name of second audio device
function M.toggle(device1, device2)
    local current = hs.audiodevice.defaultOutputDevice():name()
    local next = current == device1 and device2 or device1
    local device = hs.audiodevice.findOutputByName(next)

    if device then
        device:setDefaultOutputDevice()
        hs.notify.new({title="Audio Output", informativeText=next}):send()
    else
        hs.notify.new({title="Audio Output", informativeText="Device not found: " .. next}):send()
    end
end

--- Binds a hotkey to toggle between two audio devices
-- @param modifiers table Array of modifier keys
-- @param key string The key to bind
-- @param device1 string Name of first audio device
-- @param device2 string Name of second audio device
function M.bindHotkey(modifiers, key, device1, device2)
    hs.hotkey.bind(modifiers, key, function()
        M.toggle(device1, device2)
    end)
end

return M
