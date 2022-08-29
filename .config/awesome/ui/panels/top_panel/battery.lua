local utilities = require("utilities")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

return function(s) 
	
	local charging_icon = wibox.widget({
		{
			widget = wibox.widget.imagebox,
			image = gears.filesystem.get_configuration_dir() .. "/theme/assets/bolt.svg",
			stylesheet = "* { fill: " .. beautiful.yellow .. "; stroke: " .. beautiful.bg_normal .. "; stroke-width: 300px; }",
			forced_width = dpi(15),
			halign = "center",
			valign = "center",
		},
		left = dpi(0.5),
		visible = false,
		widget = wibox.container.margin,
	})	

	-- Show bar with rounded shape
	local battery_bar = wibox.widget({
		widget = wibox.widget.progressbar,
		max_value = 100, 
		value = 50,
		forced_width = dpi(20),
		forced_height = dpi(11),
		border_width = dpi(1),
		background_color = beautiful.transparent,
		color = beautiful.blue, 
		border_color = beautiful.white,
		shape = utilities.ui.rrect(2),
		bar_shape = utilities.ui.rrect(1),
		paddings = dpi(1),
	})
	
	-- Bar decoration to appear to be a battery
	local battery_decoration = wibox.widget({
			widget = wibox.container.background,	
			forced_width = dpi(2),
			forced_height = dpi(4),
			shape = utilities.ui.rrect(2),
			bg = beautiful.white,
	})

	local battery = wibox.widget({
		{ -- Battery decoration
			-- Battery bar
			{
				battery_bar,
				valign = "center",
				widget = wibox.container.place,
			},	
			{
				charging_icon,
				valign = "center",
				widget = wibox.container.place,
			},
			layout = wibox.layout.stack,
		},
		{
			battery_decoration,
			valign = "center",
			widget = wibox.container.place,
		},
		layout = wibox.layout.fixed.horizontal,
	})	
	
	local battery_tooltip = awful.tooltip({
		bg = beautiful.bg_alt,
		shape = utilities.ui.rrect(2),
	})

	battery_tooltip:add_to_object(battery)

	-- status = { percentage(int), time_left(string), is_pluged(bool) }
	awesome.connect_signal("signal:battery", function(status)

		-- Battery bg color
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

		local percentage = utilities.ui.format(tostring(status[1]) .. "%", beautiful.white, false, nil) .. "\n"

		-- Baterry tooltip 
		if status[3] then 
			if status[1] == 100 then 
				battery_tooltip.markup = percentage .. utilities.ui.format("Fully Charged", beautiful.white, nil, nil)
			else 
				battery_tooltip.markup = percentage .. utilities.ui.format(status[2] .. " to full charge", beautiful.white, nil, nil)
			end
		else 
			battery_tooltip.markup = percentage .. utilities.ui.format(status[2] .. " left", beautiful.white, nil, nil)
		end

		-- Battery bar and percentage
		battery_bar.value = status[1]
	end)

	return battery
end
