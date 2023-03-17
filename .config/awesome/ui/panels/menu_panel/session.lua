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
        forced_height = dpi(70),
        forced_width = dpi(70),
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
        user.markup = utilities.text.format(stdout, beautiful.white, false, nil)
    end)

    host = wibox.widget({
        widget = wibox.widget.textbox,
        font = beautiful.menu_session_font,
        halgin = "left",
        valign = "top",
    })

    awful.spawn.easy_async_with_shell("hostnamectl | awk 'NR==1{print $3}'", function(stdout)
        host.markup = utilities.text.format(stdout, beautiful.black_alt, false, nil)
    end)

    power = utilities.button.hover {
        forced_width = dpi(42),
        forced_height = dpi(42),
        shape = gears.shape.circle,
        margin = dpi(0),

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,

        font = beautiful.menu_session_icon_font,
        markup = utilities.text.format(beautiful.menu_session_power, beautiful.white, false, 29),

        action = function()
            awesome.emit_signal("signal:menu_toggle")
            awesome.emit_signal("signal:powermenu_toggle")
        end,
    }

    lock = utilities.button.hover {
        forced_width = dpi(42),
        forced_height = dpi(42),
        shape = gears.shape.circle,
        margin = dpi(0),

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,

        font = beautiful.menu_session_icon_font,
        markup = utilities.text.format(beautiful.menu_session_lock, beautiful.white, false, 23),

        action = function() end,
    }

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
                {
                    lock,
                    power,
                    widget = wibox.layout.fixed.horizontal,
                    spacing = dpi(7),
                },
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
