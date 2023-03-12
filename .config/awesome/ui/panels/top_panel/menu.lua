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
				markup = utilities.ui.format(beautiful.menu_icon, beautiful.cyan, nil, 25),
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

    menu:connect_signal("mouse::enter", function()
        local wibox = mouse.current_wibox
        old_cursor, old_wibox = wibox.cursor, wibox
        wibox.cursor = "hand2"
    end)

    menu:connect_signal("mouse::leave", function()
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    menu:connect_signal("button::press", function() awesome.emit_signal("signal:menu_toggle") end)

	return menu
end
