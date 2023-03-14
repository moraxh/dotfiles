local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")

local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

return function(s)
	menu = wibox.widget({
		{
			{
				widget = wibox.widget.textbox,
				markup = utilities.text.format(beautiful.menu_icon, beautiful.cyan, nil, 25),
				font = beautiful.icon_font,
				valign = "center",
				align = "center",
			},
			widget = wibox.container.margin,
			left = beautiful.wibar_gap * 2,
		},
		widget = wibox.container.place,
		valign = "center",
		halign = "center",
	})

    utilities.ui.add_hover(menu, "hand2")

    menu:connect_signal("button::press", function() awesome.emit_signal("signal:menu_toggle") end)

	return menu
end
