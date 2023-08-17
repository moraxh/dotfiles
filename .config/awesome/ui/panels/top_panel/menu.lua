return function(s)
	local widget = wibox.widget({
		{
            widget = wibox.widget.textbox,
            markup = utilities.text.format(beautiful.icon_menu, beautiful.cyan, nil, 15),
            font = beautiful.icon_font,
		},
		widget = wibox.container.place,
	})

    utilities.ui.add_hover(widget)
    widget:connect_signal("button::press", function() awesome.emit_signal("signal:menu_toggle") end)

	return widget
end
