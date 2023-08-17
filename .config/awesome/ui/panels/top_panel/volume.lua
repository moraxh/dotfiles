local apps = require("configuration.apps")

return function(s)
    local widget = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.icon_font1,
    })

    widget.markup = utilities.text.format(beautiful.icon_volume_mid, beautiful.white, nil, nil)

    utilities.ui.add_hover(widget)

    widget:add_button(gears.table.join(
        awful.button({}, 1, function()
            awful.spawn("amixer sset Master toggle > /dev/null")
            awesome.emit_signal("signal:update_audio")
        end),
        awful.button({}, 3, function()
            awful.spawn(apps.audio, {
                placement   = awful.placement.top_right,
                floating    = true,
                sticky      = true,
                height      = s.geometry.height * 0.8,
                width       = s.geometry.width * 0.4,
                tag         = mouse.screen.selected_tag,
            })
        end)
    ))

	awesome.connect_signal("signal:volume_info", function(status)
        if status[1] == false then
            widget.markup = utilities.text.format(beautiful.icon_no_volume, beautiful.white, nil, nil)
        elseif tonumber(status[2]) <= 30 then
            widget.markup = utilities.text.format(beautiful.icon_volume_low, beautiful.white, nil, nil)
        elseif tonumber(status[2]) <= 60 then
            widget.markup = utilities.text.format(beautiful.icon_volume_mid, beautiful.white, nil, nil)
        else
            widget.markup = utilities.text.format(beautiful.icon_volume_high, beautiful.white, nil, nil)
        end
    end)

    return widget
end
