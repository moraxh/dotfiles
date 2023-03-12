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

    separator = wibox.widget({
        font = beautiful.wibar_font,
        markup = utilities.ui.format("|", beautiful.bg_alt, nil, 13),
        halign = "center",
        valign = "middle",
        widget = wibox.widget.textbox,
    })

	---------
	-- Bar
	s.bar = awful.wibar({
		bg = beautiful.bg_normal,
		position = "top",
        margins = {
            left = beautiful.useless_gap * 2,
            right = beautiful.useless_gap * 2,
            top = beautiful.useless_gap * 2,
            bottom = dpi(0)
        },
        shape = gears.shape.rounded_bar,
	})

	s.bar:setup {
		{
			-- Left
			{
				menu,
                separator,
                taglist,
				layout = wibox.layout.fixed.horizontal,
				spacing = beautiful.wibar_spacing * 0.7,
			},
			-- Middle
			{
				window,
				widget = wibox.container.place,
				halign = "center",
			},
			-- Right
			{
				{
                    battery,
                    network,
                    separator,
                    clock,
					widget = wibox.layout.fixed.horizontal,
					spacing = beautiful.wibar_spacing * 0.7,
				},
				widget = wibox.container.place,
			},
			layout = wibox.layout.align.horizontal,
			expand = "none",
		},
		widget = wibox.container.margin,
		left = beautiful.wibar_spacing,
		right = beautiful.wibar_spacing,
	}

end
