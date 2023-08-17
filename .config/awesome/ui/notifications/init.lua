return function(s)

    noti_template = function(non)
        return wibox.widget({
            {
                {
                    {
                        {
                            widget = naughty.widget.title,
                            notification = non,
                        },
                        widget = wibox.container.background,
                        forced_height   = dpi(40),
                        bg              = beautiful.bg_normal2,
                    },
                    layout = wibox.layout.fixed.vertical,
                },
                widget = wibox.container.background,
                forced_height   = dpi(160),
                forced_width    = dpi(370),
                shape           = utilities.shapes.rrect(12),
                bg              = beautiful.bg_normal,
            },
            widget = wibox.container.margin,
        })

    end

    naughty.connect_signal("request::display", function(n)
        n.timeout = 0

        local layout_box = naughty.layout.box{
            notification    = n,
            screen          = s,
            type            = "notification",
            x               = 205,
            bg              = beautiful.transparent,
            widget_template = noti_template(n),
        }

        local animator = animation.timed({
            awestore_compat = true,
            duration        = 0.4,
            easing          = animation.easing.quadratic,
            outro           = 0.3,
            intro           = 0.1,
            rate            = 100,
            pos             = 100,
            subscribed = function(pos)
                layout_box.x = pos
                layout_box:draw()
            end
        })

        animator.target = 2000

    end)

    naughty.notify({ title = "1" })
    naughty.notify({ title = "2" })

end
