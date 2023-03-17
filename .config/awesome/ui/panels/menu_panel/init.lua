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
    local powermenu = require(widget_dir .. ".powermenu")(s)

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
                shape = utilities.shapes.rrect(11),
            },
            widget = wibox.container.margin,
        },
        placement = function(s)
            awful.placement.top_left(s, { margins = { top = beautiful.wibar_height + (beautiful.useless_gap * 4)}})
        end,
        minimum_width = dpi(400),
        maximum_width = dpi(400),
        minimum_height = dpi(550),
        maximum_height = dpi(550),
        bg = beautiful.transparent,
        ontop = true,
    }

    panel.visible = false
    panel.widget.left = (panel.minimum_width * -1)
    panel.widget.right = panel.minimum_width

    -- Exit with any key
    menu_keygrabber = awful.keygrabber {
        allowed_keys = { nil },
        stop_event = "press",
        stop_callback = function()
            if panel.visible == true then
                awesome.emit_signal("signal:menu_toggle")
            end
        end
    }

    menu_toggle_animation = animation.timed {
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

    menu_animation_finished = true
    awesome.connect_signal("signal:menu_toggle", function()
        if panel.visible == true and menu_animation_finished then
            menu_keygrabber:stop()
            menu_animation_finished = false

            menu_toggle_animation.target = panel.minimum_width

            gears.timer { timeout = menu_toggle_animation.duration, autostart = true, single_shot = true, callback = function()
                panel.visible = false
                menu_animation_finished = true
            end }
        else
            if menu_animation_finished then
                menu_animation_finished = false

                panel.visible = true
                menu_toggle_animation.target = 0

                gears.timer { timeout = menu_toggle_animation.duration, autostart = true, single_shot = true, callback = function()
                    menu_animation_finished = true
                    menu_keygrabber:start()
                end }
            end
        end
    end)
end
