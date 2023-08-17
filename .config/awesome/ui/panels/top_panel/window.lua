return function(s)
    local font_size = dpi(15)

	local widget = wibox.widget({
        {
            widget = wibox.widget.textbox,
            font = beautiful.font_medium,
        },
        widget = wibox.container.place,
	})

	widget.widget.markup = utilities.text.format("Nothing here :)", beautiful.white, false, font_size)

	client.connect_signal("focus", function()
		widget.widget.markup = utilities.text.format(tostring(client.focus.class):gsub("^%l", string.upper), beautiful.white, false, font_size)
	end)

    client.connect_signal("request::unmanage", function()
        if #(awful.screen.focused().selected_tag:clients()) == 0 then
		    widget.widget.markup = utilities.text.format("Nothing here :)", beautiful.white, false, font_size)
        end
    end)

    tag.connect_signal("property::selected", function()
        if #(awful.screen.focused().selected_tag:clients()) == 0 then
		    widget.widget.markup = utilities.text.format("Nothing here :)", beautiful.white, false, font_size)
        end
    end)

	return widget
end
