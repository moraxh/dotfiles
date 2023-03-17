local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")
local animation = require("lib.rubato")

local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

return function(s)
    local popup_width = s.geometry.width * 0.25
    local popup_height = s.geometry.height * 0.15

    local button_width = popup_width / 5.5
    local button_height = popup_width / 5.5

    local reboot = utilities.button.hover({
        forced_height = button_height,
        forced_width = button_width,
        shape = gears.shape.circle,

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,
        font = beautiful.powermenu_font,
        markup = utilities.text.format(beautiful.powermenu_reboot, beautiful.white, false, dpi(30)),
        valign = "center",
        halign = "center",
        action = function() awful.spawn("reboot") end,
    })

    local poweroff = utilities.button.hover({
        forced_height = button_height,
        forced_width = button_width,
        shape = gears.shape.circle,

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,
        font = beautiful.powermenu_font,
        markup = utilities.text.format(beautiful.powermenu_poweroff, beautiful.white, false, dpi(30)),
        valign = "center",
        halign = "center",
        action = function() awful.spawn("poweroff") end,
    })

    local logout = utilities.button.hover({
        forced_height = button_height,
        forced_width = button_width,
        shape = gears.shape.circle,

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,
        font = beautiful.powermenu_font,
        markup = utilities.text.format(beautiful.powermenu_logout, beautiful.white, false, dpi(30)),
        valign = "center",
        halign = "center",
        action = function() awesome.quit() end,
    })

    local suspend = utilities.button.hover({
        forced_height = button_height,
        forced_width = button_width,
        shape = gears.shape.circle,

        bg = beautiful.bg_alt,
        bg_hover = beautiful.black_alt,
        font = beautiful.powermenu_font,
        markup = utilities.text.format(beautiful.powermenu_suspend, beautiful.white, false, dpi(30)),
        valign = "center",
        halign = "center",
        action = function() awful.spawn("systemctl hibernate") end,
    })

    powermenu = awful.popup({
        widget =
        {
            {
                {
                    {
                        {
                            reboot,
                            poweroff,
                            logout,
                            suspend,
                            widget = wibox.layout.fixed.horizontal,
                            spacing = dpi(25)
                        },
                        widget = wibox.container.margin,
                        left = dpi(5),
                    },
                    widget = wibox.container.place,
                    valign = "center",
                    halign = "center",
                },
                widget = wibox.container.background,
                bg = beautiful.bg_normal2,
                shape = utilities.shapes.rrect(9),
            },
            widget = wibox.container.margin,
        },
        placement = function(s)
            awful.placement.bottom_right(s, { margins = {right = beautiful.useless_gap * 2}})
        end,
        minimum_width = popup_width,
        maximum_width = popup_width,
        minimum_height = popup_height,
        maximum_height = popup_height,

        bg = beautiful.transparent,
        ontop = true,
    })

    powermenu.visible = false
    powermenu.widget.top = popup_height + beautiful.useless_gap * 2
    powermenu.widget.bottom = popup_height * -1 + beautiful.useless_gap * 2


-- Exit with any key
    powermenu_keygrabber = awful.keygrabber {
        allowed_keys = { nil },
        stop_event = "press",
        stop_callback = function()
            if powermenu.visible == true then
                awesome.emit_signal("signal:powermenu_toggle")
            end
        end
    }

    powermenu_animation = animation.timed {
        intro = 0.15,
        rate = 1000,
        duration = 0.3,
        easing = animation.quadratic,
        pos = popup_height,
        subscribed = function(pos)
            powermenu.widget.top = pos + beautiful.useless_gap * 2
            powermenu.widget.bottom = pos * -1 + beautiful.useless_gap * 2
        end
    }

    -- Connect signal
    powermenu_animation_finished = true
    awesome.connect_signal("signal:powermenu_toggle", function()
        if powermenu.visible and powermenu_animation_finished then
            powermenu_keygrabber:stop()
            powermenu_animation_finished = false

            powermenu_animation.target = popup_height

            gears.timer { timeout = powermenu_animation.duration, autostart = true, single_shot = true, callback = function()
                powermenu.visible = false
                powermenu_animation_finished = true
            end }
        else
            if powermenu_animation_finished then
                powermenu_animation_finished = false

                powermenu.visible = true
                powermenu_animation.target = 0

                gears.timer { timeout = powermenu_animation.duration, autostart = true, single_shot = true, callback = function()
                    powermenu_animation_finished = true
                    powermenu_keygrabber:start()
                end }
            end
        end
    end)

end
