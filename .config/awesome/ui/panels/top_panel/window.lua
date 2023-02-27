local utilities = require("utilities")

local awful = require("awful")
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

    client.connect_signal("request::unmanage", function()
        if #(awful.screen.focused().selected_tag:clients()) == 0 then
		    widget.markup = utilities.ui.format("", beautiful.white, false, nil)
        end
    end)

    tag.connect_signal("property::selected", function()
        if #(awful.screen.focused().selected_tag:clients()) == 0 then
		    widget.markup = utilities.ui.format("", beautiful.white, false, nil)
        end
    end)

	return widget
end
