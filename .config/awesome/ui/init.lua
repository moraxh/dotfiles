local top_panel = require(... .. ".panels.top_panel")
local menu_panel = require(... .. ".panels.menu_panel")
local lock_panel = require(... .. ".panels.lock_panel")

local powermenu_popup = require(... .. ".popups.powermenu")
local notifications = require(... .. ".notifications")

awful.screen.connect_for_each_screen(function(s)
	top_panel(s)
    menu_panel(s)
    lock_panel(s)
    powermenu_popup(s)
    --notifications(s)
end)
