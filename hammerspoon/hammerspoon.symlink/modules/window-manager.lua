-- Declare prefix key
-- local prefix = {"⇧", "⌥", "⌃"}
local prefix = {"shift", "option", "ctrl"}

hs.hotkey.bind(prefix, "left", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    local halfScreenWidth = max.w / 2
    if (halfScreenWidth <= f.x) then
        f.x = halfScreenWidth - (f.w / 2)
    elseif (halfScreenWidth > f.x) then
        f.x = 0
    end
    window:setFrameInScreenBounds(f, 0)
end)

hs.hotkey.bind(prefix, "right", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:frame()

    local halfScreenWidth = max.w / 2
    if (f.x == 0) then
        f.x = halfScreenWidth - (f.w / 2)
    else
        f.x = max.w - f.w
    end
    window:setFrameInScreenBounds(f, 0)
end)

hs.hotkey.bind(prefix, "up", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:fullFrame() -- except for menubar

    local halfScreenHeight = max.h / 2
    if (halfScreenHeight <= f.y) then
        f.y = halfScreenHeight - (f.h / 2)
    elseif (halfScreenHeight > f.y) then
        f.y = 0
    end
    window:setFrameInScreenBounds(f, 0)
end)

hs.hotkey.bind(prefix, "down", function()
    local window = hs.window.focusedWindow()
    local f = window:frame()
    local screen = window:screen()
    local max = screen:fullFrame() -- except for menubar

    local halfScreenHeight = max.h / 2
    if (f.y == screen:frame().y) then -- include menubar
        f.y = halfScreenHeight - (f.h / 2)
    else
        f.y = max.h
    end
    window:setFrameInScreenBounds(f, 0)
end)
