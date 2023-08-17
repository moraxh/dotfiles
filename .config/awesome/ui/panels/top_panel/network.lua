return function(s)
	local widget = wibox.widget({
		widget = wibox.widget.textbox,
		font = beautiful.icon_font3,
	})

	awesome.connect_signal("signal:network", function(status)
		if status[1] == 0 then
			if status[2] ~= nil then
				if tonumber(status[2]) < 60 then
					widget.markup = utilities.text.format(beautiful.icon_network_high, beautiful.white, nil, 24)
				elseif tonumber(status[2]) < 70 then
					widget.markup = utilities.text.format(beautiful.icon_network_mid, beautiful.white, nil, 24)
				elseif tonumber(status[2]) < 80 then
					widget.markup = utilities.text.format(beautiful.icon_network_low, beautiful.white, nil, 24)
				end
			else
				widget.markup = utilities.text.format(beautiful.icon_network_high, beautiful.white, nil, 24)
			end
		else
			widget.markup = utilities.text.format(beautiful.icon_no_network, beautiful.white, nil, 24)

		end
	end)

	return widget
end
