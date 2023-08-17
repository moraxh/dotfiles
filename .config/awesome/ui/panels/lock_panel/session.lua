return function()

    local user_image = wibox.widget({
        widget        = wibox.container.background,
        forced_height = dpi(220),
        forced_width  = dpi(220),
        bgimage     = beautiful.profile_image,
        shape         = gears.shape.circle,
    })

    -- Set user image
    -- user_image.bgimage = utilities.mcairo.resize_png(beautiful.profile_image, user_image.forced_width, user_image.forced_height)
    user_image.bgimage = utilities.mcairo.resize_png(beautiful.profile_image, 100, 100)

    local user = wibox.widget({
        widget = wibox.widget.textbox,
        font   = beautiful.font_medium,
        halign = "center",
    })

    -- Set username
    awful.spawn.easy_async_with_shell("whoami", function(stdout)
        stdout = string.gsub(stdout,"\n","") -- Delete line break
        user.markup = utilities.text.format(stdout, beautiful.white, false, dpi(30))
    end)

    local widget = wibox.widget({
        {
            user_image,
            user,
            widget = wibox.layout.fixed.vertical,
            spacing = dpi(12),
        },
        widget = wibox.container.place,
    })

    return widget
end
