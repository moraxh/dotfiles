return function()
    local widget = wibox.widget({
        widget        = wibox.container.background,
        forced_width  = dpi(370),
        forced_height = dpi(50),
        shape         = gears.shape.rounded_bar,
        bg            = beautiful.bg_normal2,
    })

    return widget
end
