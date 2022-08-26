local wibox = require("wibox")
local beautiful = require("beautiful")

return function(s)
	local network = wibox.widget({ 
		widget = wibox.widget.textbox,
	})

	awesome.connect_signal("signal:network", function(status)
		if status then
			network.markup = "yes"
		else
			network.markup = "no"
		end
	 end)

	return network
end
