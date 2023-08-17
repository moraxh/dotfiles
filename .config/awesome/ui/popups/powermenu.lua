return function(s)
    local text_1 = wibox.widget({
        widget = wibox.widget.textbox,
        markup  = utilities.text.format("Don't forget to be", beautiful.white, false, dpi(45)),
        halign  = "center",
        valign  = "top",
        font    = beautiful.font_medium,
    })

    local text_2 = wibox.widget({
        widget = wibox.widget.textbox,
        markup  = utilities.text.format("awesome", beautiful.blue, false, dpi(45)),
        halign  = "center",
        valign  = "top",
        font    = beautiful.font_semibold,
    })

    local text = wibox.widget({
        {
            text_1,
            text_2,
            layout = wibox.layout.fixed.vertical,
            spacing = dpi(-10),
        },
        widget = wibox.container.place,
        valign = "top",
    })

    local poweroff = utilities.button.hover({
        border_color_hover  = beautiful.blue,
        forced_height       = dpi(140),
        forced_width        = dpi(140),
        border_width        = dpi(5),
        border_color        = beautiful.transparent,
        bg_hover            = beautiful.white_alt2,
        markup              = utilities.text.format(beautiful.icon_poweroff, beautiful.white, false, 55),
        action              = function() awful.spawn("poweroff") end,
        shape               = utilities.shapes.rrect(20),
        font                = beautiful.icon_font1,
        bg                  = beautiful.bg_alt,
    })

    local reboot = utilities.button.hover({
        border_color_hover  = beautiful.blue,
        forced_height       = dpi(140),
        forced_width        = dpi(140),
        border_width        = dpi(5),
        border_color        = beautiful.transparent,
        bg_hover            = beautiful.white_alt2,
        markup              = utilities.text.format(beautiful.icon_reboot, beautiful.white, false, 55),
        action              = function() awful.spawn("reboot") end,
        shape               = utilities.shapes.rrect(20),
        font                = beautiful.icon_font1,
        bg                  = beautiful.bg_alt,
    })

    local suspend = utilities.button.hover({
        border_color_hover  = beautiful.blue,
        forced_height       = dpi(140),
        forced_width        = dpi(140),
        border_width        = dpi(5),
        border_color        = beautiful.transparent,
        bg_hover            = beautiful.white_alt2,
        markup              = utilities.text.format(beautiful.icon_suspend, beautiful.white, false, 60),
        action              = function() awful.spawn("systemctl suspend") end,
        shape               = utilities.shapes.rrect(20),
        font                = beautiful.icon_font2,
        bg                  = beautiful.bg_alt,
    })

    local lock = utilities.button.hover({
        border_color_hover  = beautiful.blue,
        forced_height       = dpi(140),
        forced_width        = dpi(140),
        border_width        = dpi(5),
        border_color        = beautiful.transparent,
        bg_hover            = beautiful.white_alt2,
        markup              = utilities.text.format(beautiful.icon_lock, beautiful.white, false, 52),
        action              = function() end,
        shape               = utilities.shapes.rrect(20),
        font                = beautiful.icon_font1,
        bg                  = beautiful.bg_alt,
    })

    local logout = utilities.button.hover({
        border_color_hover  = beautiful.blue,
        forced_height       = dpi(140),
        forced_width        = dpi(140),
        border_width        = dpi(5),
        border_color        = beautiful.transparent,
        bg_hover            = beautiful.white_alt2,
        markup              = utilities.text.format(beautiful.icon_logout, beautiful.white, false, 52),
        action              = function() awesome.quit() end,
        shape               = utilities.shapes.rrect(20),
        font                = beautiful.icon_font1,
        bg                  = beautiful.bg_alt,
    })

    local buttons = wibox.widget({
        poweroff,
        reboot,
        suspend,
        lock,
        logout,
        layout = wibox.layout.fixed.horizontal,
        spacing = dpi(25),
    })

    local widget = wibox.widget({
        {
            {
                {
                    text,
                    {
                        buttons,
                        widget = wibox.container.place,
                        valign = "bottom",
                    },
                    layout = wibox.layout.fixed.vertical,
                    fill_space = true,
                },
                widget = wibox.container.margin,
                bottom  = dpi(40),
                right   = dpi(50),
                left    = dpi(50),
                top     = dpi(40),
            },
            widget = wibox.container.background,
            forced_height   = dpi(400),
            forced_width    = dpi(900),
            shape           = utilities.shapes.rrect(30),
            bg              = beautiful.bg_normal2,
        },
        widget = wibox.container.place,
    })

    local background_widget = wibox.widget({
        widget = wibox.container.background,
        forced_height   = s.geometry.height,
        forced_width    = s.geometry.width,
        bg              = "#000000",
    })

    local background = awful.popup({
        widget = background_widget,
        minimum_height      = s.geometry.height,
        maximum_height      = s.geometry.height,
        minimum_width       = s.geometry.width,
        maximum_width       = s.geometry.width,
        ontop               = true,
        bg                  = beautiful.transparent,
    })

    background_widget:connect_signal("button::press", function()
        awesome.emit_signal("signal:powermenu_toggle")
    end)

    local powermenu = awful.popup({
        widget = widget,
        minimum_height  = dpi(400),
        maximum_height  = dpi(400),
        minimum_width   = dpi(900),
        maximum_width   = dpi(900),
        placement       = awful.placement.bottom,
        ontop           = true,
        bg              = beautiful.transparent,
    })

    -- Navigate with buttons
    local selected_widget = 1
    local number_of_widgets = #buttons.children

    local select_widget = function(widget, index, increment)
        -- Cycle
        local next_widget = 0
        if index + increment > number_of_widgets then
            next_widget = 1
        elseif index + increment < 1 then
            next_widget = number_of_widgets
        else
            next_widget = index + increment
        end

        widget.children[index]:emit_signal("mouse::leave")
        widget.children[next_widget]:emit_signal("mouse::enter")
        selected_widget = next_widget
    end

    poweroff:connect_signal("mouse::enter", function()
        if selected_widget ~= 1 then
            buttons.children[selected_widget]:emit_signal("mouse::leave")
        end
        selected_widget = 1
    end)
    reboot:connect_signal("mouse::enter", function()
        if selected_widget ~= 2 then
            buttons.children[selected_widget]:emit_signal("mouse::leave")
        end
        selected_widget = 2
    end)
    suspend:connect_signal("mouse::enter", function()
        if selected_widget ~= 3 then
            buttons.children[selected_widget]:emit_signal("mouse::leave")
        end
        selected_widget = 3
    end)
    lock:connect_signal("mouse::enter", function()
        if selected_widget ~= 4 then
            buttons.children[selected_widget]:emit_signal("mouse::leave")
        end
        selected_widget = 4
    end)
    logout:connect_signal("mouse::enter", function()
        if selected_widget ~= 5 then
            buttons.children[selected_widget]:emit_signal("mouse::leave")
        end
        selected_widget = 5
    end)

    local powermenu_keygrabber = awful.keygrabber({
        --stop_key    = "Esc",
        allowed_keys = {"Right", "Left", "Return"},
        keybindings = {
            awful.key({}, "Right", function()
                select_widget(buttons, selected_widget, 1)
            end),
            awful.key({}, "Left", function()
                select_widget(buttons, selected_widget, -1)
            end),
            awful.key({}, "Return", function()
                if     selected_widget == 1 then awful.spawn("poweroff")
                elseif selected_widget == 2 then awful.spawn("reboot")
                elseif selected_widget == 3 then awful.spawn("systemctl suspend")
                elseif selected_widget == 4 then awesome.emit_signal("signal:lockscreen")
                elseif selected_widget == 5 then awesome.quit()
                end
            end),
        },
        stop_event  = "press",
        stop_callback = function()
            if powermenu.visible then
                awesome.emit_signal("signal:powermenu_toggle")
            end
        end
    })

    background.visible = false
    powermenu.visible = false

    background_toggle_animation = animation.timed {
        awestore_compat = true,
        clamp_position  = true,
        duration        = 0.5,
        easing          = animation.easing.quadratic,
        rate            = 100,
        pos             = 0,
        subscribed = function(pos)
            background.opacity = pos
        end
    }

    local powermenu_toggle_animation = animation.timed {
        awestore_compat = true,
        clamp_position  = true,
        outro           = 0.25,
        duration        = 0.5,
        easing          = animation.easing.quadratic,
        rate            = 1000,
        pos             = powermenu:geometry().height + s.geometry.height,
        subscribed = function(pos)
            powermenu.y = pos
            powermenu:draw()
        end
    }

    awesome.connect_signal("signal:powermenu_toggle", function()
        if not(powermenu_toggle_animation.running) then
            if powermenu.visible then
                background_toggle_animation.target = 0
                powermenu_toggle_animation.target = powermenu:geometry().height + s.geometry.height

                powermenu_toggle_animation.ended:subscribe(function()
                    buttons.children[selected_widget]:emit_signal("mouse::leave")
                    selected_widget = 1

                    powermenu.visible = false
                    powermenu_keygrabber:stop()
                    powermenu_toggle_animation.ended:unsubscribe(self)
                end)
                background_toggle_animation.ended:subscribe(function()
                    background.visible = false
                    background_toggle_animation.ended:unsubscribe(self)
                end)
            else
                background.visible = true
                background_toggle_animation.target = 0.8
                powermenu.visible = true
                powermenu_toggle_animation.target = s.geometry.height / 2 - (powermenu:geometry().height / 2)

                buttons.children[selected_widget]:emit_signal("mouse::enter")
                powermenu_toggle_animation.ended:subscribe(function()
                    powermenu_keygrabber:start()
                    powermenu_toggle_animation.ended:unsubscribe(self)
                end)
            end
        end
    end)
end
