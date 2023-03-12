local xresources = require("beautiful.xresources")
local utilities = require("utilities")
local dpi = xresources.apply_dpi

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

return function()
    profile_pic = wibox.widget({
        widget = wibox.widget.imagebox,
        clip_shape = gears.shape.circle,
        resize = true,
        forced_height = dpi(75),
        forced_width = dpi(75),
    })

    if os.getenv("HOME") .. "/.face" then
        profile_pic.image = os.getenv("HOME") .. "/.face"
    else
        profile_pic.image = gears.filesystem.get_configuration_dir() .. "/theme/assets/profile.png"
    end

    user = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.menu_session_font,
        halgin = "left",
        valign = "bottom",
    })

    awful.spawn.easy_async_with_shell("whoami", function(stdout)
        -- Capitalize text
        stdout = stdout:gsub("^%l", string.upper)
        user.markup = utilities.ui.format(stdout, beautiful.white, false, nil)
    end)

    host = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.menu_session_font,
        halgin = "left",
        valign = "top",
    })

    awful.spawn.easy_async_with_shell("hostnamectl | awk 'NR==1{print $3}'", function(stdout)
        host.markup = utilities.ui.format(stdout, beautiful.altblack, false, nil)
    end)

    power = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.menu_session_power_font,
        text = beautiful.menu_session_power,
    })

    session = wibox.widget({
        {
            {
                {
                    profile_pic,
                    widget = wibox.container.place,
                    halign = "middle",
                    valign = "center",
                },
                widget = wibox.container.margin,
                right = dpi(10),
            },
            {
                user,
                host,
                layout = wibox.layout.flex.vertical,
            },
            {
                power,
                widget = wibox.container.place,
                halign = "right",
            },
            layout = wibox.layout.fixed.horizontal,
            fill_space = true,
        },
        widget = wibox.container.margin,
        left = dpi(25),
        right = dpi(25),
    })


    return session
end
