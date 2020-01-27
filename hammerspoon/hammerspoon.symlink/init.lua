-- Include modules
local ROOT_PATH= ".hammerspoon"
local MODULE_PATH = "modules"
local MODULE_SUFFIX = ".lua"

local function loadModuleByName(name)
    require(MODULE_PATH .. "." .. name)
    hs.alert.show('Loaded module : ' .. name)
end

local function loadModulesByPath()
    local files, dir = hs.fs.dir(os.getenv("HOME") .. "/" .. ROOT_PATH .. "/" .. MODULE_PATH)
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

loadModulesByPath()
