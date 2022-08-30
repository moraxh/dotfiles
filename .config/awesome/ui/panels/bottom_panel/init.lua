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
	clock = require("ui.panels.bottom_panel.clock")()
	battery = require("ui.panels.bottom_panel.battery")() 
	network = require("ui.panels.bottom_panel.network")()
	taglist = require("ui.panels.bottom_panel.taglist")(s)
	menu = require("ui.panels.bottom_panel.menu")()

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
				menu,
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
						forced_height = beautiful.widget_height,
						bg = beautiful.bg_alt,
						shape = utilities.ui.rrect(5),
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
