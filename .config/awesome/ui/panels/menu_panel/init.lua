local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")
local animation = require("lib.rubato")

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")

return function(s)

    -- Widgets
    ----------

	local widget_dir = "ui.panels.menu_panel"
    local session = require(widget_dir .. ".session")()

    panel = awful.popup {
        widget =
        {
            {
                {
                    {
                        {
                            session,
                            widget = wibox.container.place,
                            content_fill_horizontal = true,
                            content_fill_vertical = true,
                            forced_height = dpi(94),
                        },
                        widget = wibox.container.background,
                        bg = beautiful.bg_alt2
                    },
                    {
                        {
                            widget = wibox.container.place,
                        },
                        widget = wibox.container.background,
                    },
                    layout = wibox.layout.fixed.vertical,
                    fill_space = true,
                },
                widget = wibox.container.background,
                bg = beautiful.bg_normal,
                shape = utilities.ui.rrect(11),
            },
            widget = wibox.container.margin,
        },
        placement = function(s)
            awful.placement.top_left(s, { margins = { top = beautiful.wibar_height + (beautiful.useless_gap * 4)}})
        end,
        minimum_width = dpi(450),
        maximum_width = dpi(450),
        minimum_height = dpi(550),
        maximum_height = dpi(550),
        bg = beautiful.transparent,
        input_passthrough = true,
        ontop = true,
    }

    panel.visible = false
    panel.widget.left = (panel.minimum_width * -1)
    panel.widget.right = panel.minimum_width

    -- Exit with any key
    keygrabber = awful.keygrabber {
        allowed_keys = { nil },
        stop_event = "press",
        stop_callback = function()
            if panel.visible == true then
                awesome.emit_signal("signal:menu_toggle")
            end
        end
    }

    toggle_animation = animation.timed {
        intro = 0.15,
        rate = 1000,
        duration = 0.3,
        pos = panel.minimum_width,
        easing = animation.quadratic,
        subscribed = function(pos)
            panel.widget.left = pos * -1 + beautiful.useless_gap * 2
            panel.widget.right = pos  + beautiful.useless_gap * 2
        end
    }

    animation_finished = true
    awesome.connect_signal("signal:menu_toggle", function()
        if panel.visible == true and animation_finished then
            keygrabber:stop()
            animation_finished = false

            toggle_animation.target = panel.minimum_width

            gears.timer { timeout = toggle_animation.duration, autostart = true, single_shot = true, callback = function()
                panel.visible = false
                animation_finished = true
            end }
        else
            if animation_finished then
                animation_finished = false

                panel.visible = true
                toggle_animation.target = 0

                gears.timer { timeout = toggle_animation.duration, autostart = true, single_shot = true, callback = function()
                    animation_finished = true
                    keygrabber:start()
                end }
            end
        end
    end)
end
