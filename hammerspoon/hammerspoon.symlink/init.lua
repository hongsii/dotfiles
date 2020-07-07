-- Include modules
local ROOT_PATH = os.getenv("HOME") .. "/" .. ".hammerspoon"
local MODULE_DIR = "modules"
local MODULE_SUFFIX = ".lua"

local function loadModuleByName(name)
    require(MODULE_DIR .. "." .. name)
    hs.alert.show('Loaded module : ' .. name)
end

local function loadModulesByPath()
    local files, dir = hs.fs.dir(ROOT_PATH  .. "/" .. MODULE_DIR)
        if files == nil then
        do return end
    end

    for file in files, dir do
        if file:find(MODULE_SUFFIX .. "$") then
            local moduleName = string.sub(file, 1, string.len(file) - string.len(MODULE_SUFFIX))
            loadModuleByName(moduleName)
        end
    end
end

local autoReloader = hs.pathwatcher.new(ROOT_PATH, function (files)
    for _, file in pairs(files) do
        if file:sub(-4) == MODULE_SUFFIX then
            hs.reload()
            break
        end
    end
end)

autoReloader:start()
loadModulesByPath()

