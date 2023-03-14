local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local wibox = require("wibox")
local beautiful = require("beautiful")
local utilities = require("utilities")

return function(s)
	local network = wibox.widget({
		widget = wibox.widget.textbox,
		font = beautiful.network_font,
		valign = "center",
		align = "center",
	})

	awesome.connect_signal("signal:network", function(status)
		if status[1] == 0 then
			if status[2] ~= nil then
				if tonumber(status[2]) < 60 then
					network.markup = utilities.text.format(beautiful.icon_network_high, beautiful.white, nil, nil)
				elseif tonumber(status[2]) < 70 then
					network.markup = utilities.text.format(beautiful.icon_network_mid, beautiful.white, nil, nil)
				elseif tonumber(status[2]) < 80 then
					network.markup = utilities.text.format(beautiful.icon_network_low, beautiful.white, nil, nil)
				end
			else
				network.markup = utilities.text.format(beautiful.icon_network_high, beautiful.white, nil, nil)
			end
		else
			network.markup = utilities.text.format(beautiful.icon_no_network, beautiful.white, nil, nil)

		end
	end)

	return network
end
