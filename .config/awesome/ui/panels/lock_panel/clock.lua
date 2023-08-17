return function()

    local hour = wibox.widget({
        {
            widget = wibox.widget.textclock,
            format  = utilities.text.format("%l:%M", beautiful.white, false, dpi(150)),
            halign  = "center",
            font    = beautiful.font_semibold,
        },
        widget = wibox.container.margin,
        top     = dpi(-60),
    })

    local date = wibox.widget({
        widget = wibox.widget.textclock,
        format  = utilities.text.format("%A, %B %e", beautiful.white, false, dpi(60)),
        halign  = "center",
        font    = beautiful.font_semibold,
    })

    local widget = wibox.widget({
        {
            hour,
            date,
            layout = wibox.layout.fixed.vertical,
        },
        widget = wibox.container.place,
    })

    return widget
end
