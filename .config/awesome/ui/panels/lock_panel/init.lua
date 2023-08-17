return function(s)

    -- Set lockscreen wallpaper
    local wp = utilities.mcairo.resize_png(beautiful.lockscreen_wallpaper, s.geometry.width, s.geometry.height)
    -- Dark it
    wp = utilities.mcairo.dark_surface(wp, 0.8)

    -- First Screen
	local widget_dir = "ui.panels.lock_panel"
    local time       = require(widget_dir .. ".clock")()
    local lock_icon  = require(widget_dir .. ".icon")()

    -- Second Screen
    local session    = require(widget_dir .. ".session")()
    local textfield  = require(widget_dir .. ".textfield")()

    local first_screen = wibox.widget({
        {
            {
                time,
                lock_icon,
                layout = wibox.layout.fixed.vertical,
                fill_space = true,
            },
            widget = wibox.container.margin,
            forced_height   = s.geometry.height,
            forced_width    = s.geometry.width,
            bottom          = dpi(100),
            top             = dpi(100),
        },
        widget = wibox.container.place,
    })


    local second_screen = wibox.widget({
        {
            session,
            textfield,
            widget = wibox.layout.fixed.vertical,
            spacing = dpi(50),
        },
        widget = wibox.container.place,
        forced_height   = s.geometry.height,
        forced_width    = s.geometry.width,
    })

    first_screen:connect_signal("button::press", function()
        awesome.emit_signal("lockscreen:open")
    end)

    second_screen:connect_signal("button::press", function()
        awesome.emit_signal("lockscreen:close")
    end)

    local lockscreen_widget = wibox.widget({
        {
            {
                first_screen,
                second_screen,
                layout = wibox.layout.fixed.vertical,
            },
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
        forced_height   = s.geometry.height * 2,
        forced_width    = s.geometry.width * 2,
        bgimage         = wp,
    })

    local lockscreen_toggle = animation.timed({
        awestore_compat = true,
        duration        = 0.35,
        intro           = 0.15,
        outro           = 0.05,
        easing          = animation.easing.quadratic,
        rate            = 100,
        pos             = 0,
        subscribed = function(pos)
            lockscreen_widget.widget.top = pos
        end
    })

    awesome.connect_signal("lockscreen:open", function()
        lockscreen_toggle.target = -s.geometry.height
    end)

    awesome.connect_signal("lockscreen:close", function()
        lockscreen_toggle.target = 0
    end)

    local lockscreen = awful.popup({
        widget          = lockscreen_widget,
        minimum_height  = s.geometry.height,
        maximum_height  = s.geometry.height,
        minimum_width   = s.geometry.width,
        maximum_width   = s.geometry.width,
        ontop           = true,
        bg              = beautiful.transparent
    })

    lockscreen.visible = false

    local lockscreen_animation = animation.timed({
        awestore_compat = true,
        clamp_position  = true,
        duration        = 0.4,
        override_dt     = true,
        easing          = animation.easing.quadratic,
        rate            = 120,
        pos             = s.geometry.height * -1,
        subscribed = function(pos)
            lockscreen.y = pos
            lockscreen:draw()
        end
    })

    awesome.connect_signal("signal:lockscreen_lock", function()
        if not(lockscreen.visible) then
            lockscreen.visible = true
            lockscreen_animation.target = 0
            awesome.emit_signal("lockscreen:toggle_decoration")


            lockscreen_animation.ended:subscribe(function()
                gears.timer { call_now = false, timeout = 5, autostart = true, single_shot = true, callback = function()
                    awesome.emit_signal("signal:lockscreen_unlock")
                end }
                lockscreen_animation.ended:unsubscribe(self)
            end)
        end
    end)

    awesome.connect_signal("signal:lockscreen_unlock", function()
        if lockscreen.visible then
            lockscreen_animation.target = s.geometry.height

            lockscreen_animation.ended:subscribe(function()
                awesome.emit_signal("lockscreen:toggle_decoration")
                lockscreen.visible = false
                lockscreen_animation.pos = s.geometry.height * -1
                lockscreen.y = s.geometry.height * -1
                lockscreen_widget.widget.top = 0

                lockscreen_animation.ended:unsubscribe(self)
            end)
        end
    end)
end
