return function(s)

	local charging_icon = wibox.widget({
        widget = wibox.widget.imagebox,
        scaling_quality = "best",
        forced_width    = dpi(13),
        stylesheet      = "* { fill: " .. beautiful.yellow .. "; stroke: " .. beautiful.bg_normal .. "; stroke-width: 2px;}",
        valign          = "center",
        halign          = "center",
        image           = gears.filesystem.get_configuration_dir() .. "/theme/assets/charging.svg",
	})

	-- Show bar with rounded shape
	local battery_bar = wibox.widget({
		widget = wibox.widget.progressbar,
		background_color    = beautiful.transparent,
		forced_height       = dpi(13),
		forced_width        = dpi(23),
		border_width        = dpi(1),
		border_color        = beautiful.white,
		bar_shape           = utilities.shapes.rrect(2),
		max_value           = 100,
		paddings            = dpi(1),
		value               = 100,
		color               = beautiful.blue,
		shape               = utilities.shapes.rrect(3),
	})

	-- Bar decoration to appear to be a battery
	local battery_decoration = wibox.widget({
        widget = wibox.container.background,
        forced_width    = dpi(2),
        forced_height   = dpi(4),
        shape           = utilities.shapes.rrect(3),
        bg              = beautiful.white,
	})

	local widget = wibox.widget({
		{ -- Battery decoration
			-- Battery bar
			{
				battery_bar,
				widget = wibox.container.place,
			},
			{
				charging_icon,
				widget = wibox.container.place,
			},
			layout = wibox.layout.stack,
		},
		{
			battery_decoration,
            halign = "left",
			widget = wibox.container.place,
		},
		layout  = wibox.layout.fixed.horizontal,
        spacing = 0,
	})

	local battery_tooltip = awful.tooltip({
		preferred_alignments    = "middle",
		shape                   = utilities.shapes.rrect(2),
		mode                    = "outside",
		bg                      = beautiful.bg_alt,
	})

	battery_tooltip:add_to_object(widget)

	-- status = { percentage(int), time_left(string), is_pluged(bool) }
	awesome.connect_signal("signal:battery", function(status)
		if status[1] > 30 then
			battery_bar.color = beautiful.blue
		elseif status[1] > 10 and status[1] <= 30 then
			battery_bar.color = beautiful.yellow
		elseif status[1] <= 10 then
			battery_bar.color = beautiful.red
		end

		if status[3] then
			charging_icon.visible = true
		else
			charging_icon.visible = false
		end

		local percentage = utilities.text.format(tostring(status[1]) .. "%", beautiful.white, false, nil) .. "\n"

		-- Baterry tooltip
		if status[3] then
			if status[1] == 100 then
				battery_tooltip.markup = percentage .. utilities.text.format("Fully Charged", beautiful.white, nil, nil)
			else
				battery_tooltip.markup = percentage .. utilities.text.format(status[2] .. " to full charge", beautiful.white, nil, nil)
			end
		else
			battery_tooltip.markup = percentage .. utilities.text.format(status[2] .. " left", beautiful.white, nil, nil)
		end

		-- Battery bar
		battery_bar.value = status[1]
	end)

	return widget
end
