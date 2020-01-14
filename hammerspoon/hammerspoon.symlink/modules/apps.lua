-- Declare prefix key
prefix = {"⇧", "⌥", "⌃"}

local function toggleApplication(app, name)
  local currentApp = hs.application.frontmostApplication()
  if currentApp:name() ~= name then
    hs.application.launchOrFocus(app)
  else
    currentApp:hide()
  end
end

hs.hotkey.bind(prefix, "c", function() toggleApplication("Google Chrome", "Chrome") end)
hs.hotkey.bind(prefix, "f", function() toggleApplication("Finder", "Finder") end)
hs.hotkey.bind(prefix, "t", function() toggleApplication("iTerm 2", "iTerm2") end)
hs.hotkey.bind(prefix, "k", function() toggleApplication("KakaoTalk", "카카오톡") end)
hs.hotkey.bind(prefix, "n", function() toggleApplication("Notion", "Notion") end)
