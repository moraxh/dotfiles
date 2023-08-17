return function()
    local user_image = wibox.widget({
        widget = wibox.widget.imagebox,
        clip_shape = gears.shape.circle,
        resize = true,
        forced_height = dpi(90),
        forced_width = dpi(90),
    })

    -- Set user image
    if gears.filesystem.file_readable(os.getenv("HOME") .. "/.face") then
        user_image.image = os.getenv("HOME") .. "/.face"
    else
        user_image.image = beautiful.profile_image
    end

    local user = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.font_medium,
        halign = "left",
    })

    -- Set username
    awful.spawn.easy_async_with_shell("whoami", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")
        user.markup = utilities.text.format(stdout, beautiful.white, false, dpi(14))
    end)

    local host = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.font_medium,
        halign = "left",
    })

    -- Set host
    awful.spawn.easy_async_with_shell("hostnamectl | awk 'NR==1{print $3}'", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")
        host.markup = utilities.text.format(stdout, beautiful.black_alt, false, dpi(12))
    end)

    local powermenu = utilities.button.hover({
        forced_width    = dpi(46),
        forced_height   = dpi(46),
        shape           = gears.shape.circle,

        bg_hover    = beautiful.black_alt,
        bg          = beautiful.bg_alt,

        markup  = utilities.text.format(beautiful.icon_poweroff, beautiful.blue, false, dpi(16)),
        font    = beautiful.icon_font1,

        action = function()
            awesome.emit_signal("signal:menu_toggle", function() awesome.emit_signal("signal:powermenu_toggle") end)
        end,
    })

    local widget = wibox.widget({
        {
            {
                user_image,
                widget = wibox.container.place,
            },
            widget = wibox.container.margin,
            right = dpi(15),
        },
        {
            {
                user,
                host,
                layout = wibox.layout.fixed.vertical,
            },
            widget = wibox.container.place,
        },
        {
            powermenu,
            widget = wibox.container.place,
            halign = "right"
        },
        layout = wibox.layout.fixed.horizontal,
        fill_space = true,
    })

    return widget
end
