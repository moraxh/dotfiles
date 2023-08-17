return function()

    local volume_icon = utilities.button.hover({
        forced_height   = dpi(40),
        forced_width    = dpi(40),
        margin          = dpi(0),
        shape           = gears.shape.circle,

        bg_hover        = beautiful.black_alt,
        bg              = beautiful.bg_alt,

        font            = beautiful.icon_font1,
        action          = function()
            awful.spawn.easy_async("amixer -q -D default set Master toggle")
        end
    })

    local volume_bar = wibox.widget({
        {
            widget              = wibox.widget.slider,
            bar_active_color    = beautiful.blue,
            forced_height       = dpi(19),
            handle_shape        = gears.shape.circle,
            handle_color        = beautiful.blue,
            handle_width        = dpi(19),
            bar_shape           = gears.shape.rounded_bar,
            bar_color           = beautiful.bg_alt,
        },
        widget = wibox.container.place,
    })


    local command_ended = true

    volume_bar.widget:connect_signal("property::value", function(s, value)
        naughty.notify({ tostring(volume_bar.widget.x) })
        -- Update volume
        -- only execute if prev command ended
        if command_ended then
            command_ended = false
            awful.spawn.easy_async("amixer -q -D default set Master " .. tostring(value) .. "% unmute", function()
                command_ended = true
            end)
            awesome.emit_signal("signal:update_audio")
        end

        -- Update icon
        if value < 30 then
            volume_icon.widget.widget.widget.markup = utilities.text.format(beautiful.icon_volume_low, beautiful.white, false, 12)
        elseif value < 60 then
            volume_icon.widget.widget.widget.markup = utilities.text.format(beautiful.icon_volume_mid, beautiful.white, false, 12)
        else
            volume_icon.widget.widget.widget.markup = utilities.text.format(beautiful.icon_volume_high, beautiful.white, false, 12)
        end
    end)

    local volume = wibox.widget({
        volume_icon,
        volume_bar,
        layout  = wibox.layout.fixed.horizontal,
        spacing = dpi(15),
    })

    local widget = wibox.widget({
        {
            volume,
            widget = wibox.layout.fixed.vertical,
        },
        widget  = wibox.container.margin,
        margins = dpi(25),
    })

    return widget
end
