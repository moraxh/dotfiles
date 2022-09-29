local utilities = require("utilities")

local wibox = require("wibox")
local beautiful = require("beautiful")

return function(s) 

	widget = wibox.widget({	
		widget = wibox.widget.textbox,
		font = beautiful.wibar_font,
	})

	client.connect_signal("focus", function() 
		widget.markup = utilities.ui.format(tostring(client.focus.class):gsub("^%l", string.upper), beautiful.white, false, nil)
	end)

	return widget
end
