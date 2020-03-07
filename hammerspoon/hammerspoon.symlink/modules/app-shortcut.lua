-- Declare prefix key
local prefix = {"shift", "option", "ctrl"}

-- Declare class
local App = {}
local appTables = { __index = App }
function App:new(name, displayName)
    return setmetatable({ name = name, displayName = displayName or name }, appTables)
end

local apps = {
  c = App:new("Google Chrome", "Chrome"),
  i = App:new("IntelliJ IDEA"),
  f = App:new("Finder"),
  t = App:new("iTerm 2", "iTerm2"),
  k = App:new("KakaoTalk", "카카오톡"),
  n = App:new("Notion")
}

local function toggleApplication(name, displayName)
  local currentApp = hs.application.frontmostApplication()
  if currentApp:name() ~= displayName then
    hs.application.launchOrFocus(name)
  else
    currentApp:hide()
  end
end

local function bindShortCut()
  for key, app in pairs(apps) do
    hs.hotkey.bind(prefix, key, function() toggleApplication(app.name, app.displayName) end)
  end
end

bindShortCut()
