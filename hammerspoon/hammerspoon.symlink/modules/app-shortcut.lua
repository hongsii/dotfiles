local defaultPrefix = {"shift", "option", "ctrl"}

local function toggleApplication(name)
    local app = hs.application.get(name)
    if app and app:isFrontmost() then
        app:hide()
    else
        hs.application.launchOrFocus(name)
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
    hs.hotkey.bind(prefix, entry.key, function()
        toggleApplication(entry.name)
    end)
end
