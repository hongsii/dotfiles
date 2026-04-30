local defaultPrefix = {"shift", "option", "ctrl"}

local function toggleApplication(name, displayName)
    local currentApp = hs.application.frontmostApplication()
    if currentApp:name() ~= displayName then
        hs.application.launchOrFocus(name)
    else
        currentApp:hide()
    end
end

local localKeysPath = hs.configdir .. "/modules/app-shortcut/keys.local.lua"
local keys
if hs.fs.attributes(localKeysPath) then
    keys = dofile(localKeysPath)
else
    keys = require("modules.app-shortcut.keys")
end

for _, entry in ipairs(keys) do
    local prefix = entry.prefix or defaultPrefix
    local displayName = entry.displayName or entry.name
    hs.hotkey.bind(prefix, entry.key, function()
        toggleApplication(entry.name, displayName)
    end)
end
