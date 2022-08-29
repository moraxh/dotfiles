local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

return function(s)

	----------
	-- Widgets
	clock = require("ui.panels.top_panel.clock")()
	battery = require("ui.panels.top_panel.battery")() 
	network = require("ui.panels.top_panel.network")()
	taglist = require("ui.panels.top_panel.taglist")(s)

	---------
	-- Bar	
	s.bar = awful.wibar({ 
		bg = beautiful.bg_normal,
		position = "bottom", 
	})

	s.bar:setup {
		{
			-- Left
			{
				nil,
				layout = wibox.layout.fixed.horizontal,
				spacing = beautiful.wibar_spacing,
			},
			-- Middle
			{
				taglist,
				widget = wibox.container.place,
				halign = "center",
			},
			-- Right
			{
				{
					{
						{
							{
							network,
							battery,
							layout = wibox.layout.fixed.horizontal,
							spacing = beautiful.wibar_spacing,
							},
							widget = wibox.container.margin,
							left = beautiful.wibar_spacing,
							right = beautiful.wibar_spacing,
						},
						widget = wibox.container.background,
						forced_height = beautiful.wibar_height * 0.75,
						bg = beautiful.bg_alt,
						shape = gears.shape.rounded_bar,
						},
					widget = wibox.container.place,
				},
				clock,
				layout = wibox.layout.fixed.horizontal,
				spacing = beautiful.wibar_spacing,
			},
			layout = wibox.layout.align.horizontal,
			expand = "none",
		},
		widget = wibox.container.margin,
		left = beautiful.wibar_spacing,
		right = beautiful.wibar_spacing,
	}

end
