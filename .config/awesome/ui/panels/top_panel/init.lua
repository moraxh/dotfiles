local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
 

return function(s)
	clock = require("ui.panels.top_panel.clock")()
	battery = require("ui.panels.top_panel.battery")() 

	taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,

	}
	
	s.bar = awful.wibar({ position = "top", shape = gears.shape.rounded_rect, expand = "outside" })

	s.bar:setup {
		{
			layout = wibox.layout.fixed.horizontal,
			clock,
		},    
		{
			layout = wibox.container.place,
			taglist,
    	},
		{
			layout = wibox.layout.fixed.horizontal,
			clock,
		},
			layout = wibox.layout.align.horizontal,
	}

end
