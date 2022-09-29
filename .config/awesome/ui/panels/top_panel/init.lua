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
	
	local widget_dir = "ui.panels.top_panel"
	clock = require(widget_dir .. ".clock")()
	battery = require(widget_dir .. ".battery")() 
	network = require(widget_dir .. ".network")()
	taglist = require(widget_dir .. ".taglist")(s)
	menu = require(widget_dir .. ".menu")()
	window = require(widget_dir .. ".window")()

	---------
	-- Bar	
	s.bar = awful.wibar({ 
		bg = beautiful.transparent,
		position = "top", 
	})

	s.bar:setup {
		{
			-- Left
			{
				menu,
				window,
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
							widget = wibox.layout.fixed.horizontal,
							spacing = beautiful.wibar_spacing,
							},
							widget = wibox.container.margin,
							left = beautiful.wibar_gap * 2.5,
							right = beautiful.wibar_gap * 2.5,
						},
						widget = wibox.container.background,
						forced_height = beautiful.widget_height,
						bg = beautiful.bg_normal,
						border_color = beautiful.bg_alt,
						border_width = beautiful.wibar_border,
						shape = gears.shape.rounded_bar,
					},
					{
							clock,
							widget = wibox.layout.fixed.horizontal,
					},
					widget = wibox.layout.fixed.horizontal,
					spacing = beautiful.wibar_spacing,
				},
				widget = wibox.container.place,
			},
			layout = wibox.layout.align.horizontal,
			expand = "none",
		},
		widget = wibox.container.margin,
		left = beautiful.wibar_spacing,
		right = beautiful.wibar_spacing,
		top = beautiful.wibar_gap / 2,
		bottom = beautiful.wibar_gap / 2,
	}

end
