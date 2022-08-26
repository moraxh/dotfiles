local awful = require("awful")

local bottom_panel = require(... .. ".panels.bottom_panel")

awful.screen.connect_for_each_screen(function(s) 
	bottom_panel(s)
end) 

