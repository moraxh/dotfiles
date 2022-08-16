local awful = require("awful")

local top_panel = require(... .. ".panels.top_panel")

awful.screen.connect_for_each_screen(function(s) 
	top_panel (s)
end) 

