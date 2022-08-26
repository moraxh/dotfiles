local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")

local wibox = require("wibox")
local beautiful = require("beautiful")

---------------
-- Clock widget 

return function(s)
	local clock = wibox.widget({
		format = utilities.ui.format("%I %M", beautiful.white, false, nil),
		timezone = 'America/Mexico_City',
    	widget = wibox.widget.textclock,
		valign = "center",
		screen = s,
		font = beautiful.wibar_font,
	})

	local widget = wibox.container.margin(clock, dpi(10))

	return widget
end


