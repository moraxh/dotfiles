local wibox = require("wibox")

---------------
-- Clock widget 

return function(s)
	clock = wibox.widget({
		format = '%I:%M %p',
		timezone = 'America/Mexico_City',
    	widget = wibox.widget.textclock,
		screen = s,
		align = "center",
	})
	return clock
end


