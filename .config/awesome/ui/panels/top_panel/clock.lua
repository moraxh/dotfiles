return function(s)
	local widget = wibox.widget({
    	widget = wibox.widget.textclock,
		format = utilities.text.format("%I %M", beautiful.white, false, dpi(15)),
		font = beautiful.font_medium,
	})

	return widget
end
