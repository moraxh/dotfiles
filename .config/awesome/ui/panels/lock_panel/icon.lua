return function()

    local icon = wibox.widget({
        {
            widget = wibox.widget.textbox,
            markup  = utilities.text.format(beautiful.icon_lock, beautiful.white, false, 65),
            valign  = "center",
            halign  = "center",
            font    = beautiful.icon_font1,
        },
        widget = wibox.container.place,
    })

    local decoration_size = dpi(250)

    local decoration = wibox.widget({
        {
            {
                widget = wibox.container.background,
                forced_width    = decoration_size,
                forced_height   = decoration_size,
                shape           = utilities.shapes.arc(dpi(15), math.pi, math.pi * 1.5, true, true),
                bg              = beautiful.blue,
            },
            widget = wibox.container.place,
        },
        {
            {
                widget = wibox.container.background,
                forced_width    = decoration_size,
                forced_height   = decoration_size,
                shape           = utilities.shapes.arc(dpi(15), 0, math.pi/2, true, true),
                bg              = beautiful.blue,
            },
            widget = wibox.container.place,
        },
        layout = wibox.layout.stack,
    })

    local rotate_decoration = function(r)
        decoration.children[1].widget.shape = gears.shape.transform(utilities.shapes.arc(dpi(18), math.pi, math.pi * 1.5, true, true))
            :rotate_at(decoration_size / 2, decoration_size / 2, r)
        decoration.children[2].widget.shape = gears.shape.transform(utilities.shapes.arc(dpi(18), 0, math.pi * 0.5, true, true))
            :rotate_at(decoration_size / 2, decoration_size / 2, r)
    end

    local decorator_animator = animation.timed({
        awestore_compat = true,
        clamp_position  = true,
        duration        = 3600,
        easing          = animation.easing.linear,
        pos             = 0,
        subscribed = function(pos)
            rotate_decoration(pos)
        end
    })

    decorator_animator.target = math.pi * 3000
    decorator_animator.pause = true

    decorator_animator.ended:subscribe(function()
        decorator_animator.pos  = 0
        decorator_animator.target = math.pi * 3000
    end)

    awesome.connect_signal("lockscreen:toggle_decoration", function()
        if decorator_animator.running then
            decorator_animator.pause = true
        else
            decorator_animator.pause = false
        end
    end)

    local widget = wibox.widget({
        {
            decoration,
            icon,
            layout = wibox.layout.stack,
        },
        widget = wibox.container.place,
        valign = "bottom"
    })

    return widget
end
