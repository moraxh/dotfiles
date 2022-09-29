local xresources = require("beautiful.xresources")
local utilities = require("utilities")

local wibox = require("wibox")
local beautiful = require("beautiful")

---------------
-- Clock widget 

return function(s)
	clock = wibox.widget({
		format = utilities.ui.format("%I %M", beautiful.white, false, nil),
		timezone = 'America/Mexico_City',
    	widget = wibox.widget.textclock,
		valign = "center",
		screen = s,
		font = beautiful.wibar_font,
	})
	
	return clock
end


