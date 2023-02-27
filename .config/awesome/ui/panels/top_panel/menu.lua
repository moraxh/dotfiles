local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")

local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

return function(s)
	local menu = wibox.widget({
		{
			{
				widget = wibox.widget.textbox,
				markup = utilities.ui.format("", beautiful.cyan, nil, 21),
				font = beautiful.icon_font,
				valign = "center",
				align = "center",
			},
			widget = wibox.container.margin,
			left = beautiful.wibar_gap * 2,
			right = beautiful.wibar_gap * 2,
		},
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
	})

	return menu
end
