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
		bg = beautiful.transparent,
		position = "top", 
		margins = { top = beautiful.useless_gap, bottom = 0 },
	})

	s.bar:setup {
		{
			-- Left
			{
				{
					{
						clock,
						layout = wibox.layout.fixed.horizontal,
						spacing = beautiful.wibar_spacing,
					},
					widget = wibox.container.margin,
					margins = { left = beautiful.wibar_spacing, right = beautiful.wibar_spacing }
				},
				widget = wibox.container.background,
				forced_height = beautiful.wibar_height,
				bg = beautiful.bg_normal,
				border_width = beautiful.wibar_border,
				border_color = beautiful.bg_alt,
				shape = gears.shape.rounded_bar,
			},
			-- Middle
			{
				taglist,
				widget = wibox.container.place,
				valign = "center",
			},
			-- Right
			{
				{
					{
						network,
						battery,
						layout = wibox.layout.fixed.horizontal,
						spacing = beautiful.wibar_spacing,
					},
					widget = wibox.container.margin,
					margins = { left = beautiful.wibar_spacing, right = beautiful.wibar_spacing }
				},
				widget = wibox.container.background,
				forced_height = beautiful.wibar_height,
				bg = beautiful.bg_normal,
				border_width = beautiful.wibar_border,
				border_color = beautiful.bg_alt,
				shape = gears.shape.rounded_bar,
			},
			layout = wibox.layout.align.horizontal,
		},
		widget = wibox.container.margin,
		left = beautiful.wibar_gap,
		right = beautiful.wibar_gap,
	}

end
