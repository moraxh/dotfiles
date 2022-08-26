local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

return function(s)

	screen_width = s.geometry.width

	----------
	-- Widgets
	clock = require("ui.panels.bottom_panel.clock")()
	battery = require("ui.panels.bottom_panel.battery")() 
	network = require("ui.panels.bottom_panel.network")()
	taglist = require("ui.panels.bottom_panel.taglist")(s)

	---------
	-- Bar
	
	s.bar = awful.wibar({ 
		position = "bottom", 
		width = screen_width * 1,
	})

	s.bar:setup {
		{
			clock,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			taglist,
			widget = wibox.container.place,
		},
		{
			network,
			battery,
			layout = wibox.layout.fixed.horizontal,
		},
			layout = wibox.layout.align.horizontal,
	}

end
