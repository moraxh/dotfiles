return function(s)
	local widget_dir    = "ui.panels.menu_panel"
    local controls      = require(widget_dir .. ".controls")()
    local session       = require(widget_dir .. ".session")()
    local player        = require(widget_dir .. ".player")()

    local session_widget = wibox.widget({
        session,
        widget  = wibox.container.margin,
        bottom  = beautiful.menu_vgap,
        right   = beautiful.menu_hgap,
        left    = beautiful.menu_hgap,
        top     = beautiful.menu_vgap,
    })

    local player_widget = wibox.widget({
        player,
        widget          = wibox.container.background,
        forced_height   = dpi(180),
        shape           = utilities.shapes.rrect(15),
        bg              = beautiful.bg_normal2,
    })

    local controls_widget = wibox.widget({
        controls,
        widget          = wibox.container.background,
        forced_height   = dpi(180),
        shape           = utilities.shapes.rrect(15),
        bg              = beautiful.bg_normal2,
    })

    local widgets = wibox.widget({
        {
            {
                player_widget,
                controls_widget,
                layout  = wibox.layout.fixed.vertical,
                spacing = beautiful.menu_vgap,
            },
            widget  = wibox.container.margin,
            bottom  = beautiful.menu_vgap,
            right   = beautiful.menu_hgap,
            left    = beautiful.menu_hgap,
            top     = beautiful.menu_vgap,
        },
        widget  = wibox.container.background,
        shape   = utilities.shapes.rrect(15),
        bg      = beautiful.bg_alt,
    })

    local menu_widget = wibox.widget({
        {
            {
                session_widget,
                widgets,
                layout      = wibox.layout.fixed.vertical,
                fill_space  = true,
            },
            widget  = wibox.container.background,
            shape   = utilities.shapes.rrect(15),
            bg      = beautiful.bg_normal2,
        },
        widget = wibox.container.margin,
    })

    local menu = awful.popup({
        widget = menu_widget,
        placement = function(s)
            awful.placement.top_left(s, { margins = { top = beautiful.wibar_height + beautiful.useless_gap * 4}})
        end,

        minimum_width   = dpi(435),
        maximum_width   = dpi(435),
        ontop           = true,
        bg              = beautiful.transparent,
    })

    menu.visible = false

    -- Exit with any key
    local menu_keygrabber = awful.keygrabber {
        allowed_keys    = { nil },
        stop_event      = "press",
        stop_callback = function()
            if menu.visible then
                awesome.emit_signal("signal:menu_toggle")
            end
        end
    }

    local menu_toggle_animation = animation.timed {
        awestore_compat = true,
        duration        = 0.4,
        easing          = animation.easing.quadratic,
        outro           = 0.3,
        intro           = 0.1,
        rate            = 100,
        pos             = menu.minimum_width,
        subscribed = function(pos)
            menu_widget.left    = pos * -1 + beautiful.useless_gap * 2
            menu_widget.right   = pos  + beautiful.useless_gap * 2
            menu:draw()
        end
    }

    local background_widget = wibox.widget({
        widget          = wibox.container.place,
        forced_height   = s.geometry.height,
        forced_width    = s.geometry.width,
    })

    local background = awful.popup({
        widget              = background_widget,
        minimum_height      = s.geometry.height,
        maximum_height      = s.geometry.height,
        minimum_width       = s.geometry.width,
        maximum_width       = s.geometry.width,
        ontop               = true,
        bg                  = beautiful.transparent,
    })

    background_widget:connect_signal("button::press", function()
        awesome.emit_signal("signal:menu_toggle")
    end)

    background.visible  = false


    local widgets_toggle_animation = animation.timed({
        awestore_compat = true,
        duration        = 0.35,
        easing          = animation.easing.quadratic,
        intro           = 0.15,
        outro           = 0.05,
        rate            = 100,
        pos             = dpi(1),
        subscribed = function(pos)
            widgets.forced_height = pos
        end
    })

    awesome.connect_signal("signal:menu_toggle", function(callback)
        callback = callback or nil
        if not(menu_toggle_animation.running) and not(widgets_toggle_animation.running) then
            if menu.visible then
                -- Widgets animation
                widgets_toggle_animation.target = dpi(1)

                widgets_toggle_animation.ended:subscribe(function()
                    widgets.visible = false

                    menu_toggle_animation.target = menu.minimum_width
                    menu_toggle_animation.ended:subscribe(function()
                        menu.visible = false
                        background.visible = false
                        menu_toggle_animation.ended:unsubscribe(self)
                        menu_keygrabber:stop()

                        if callback then
                            callback()
                        end
                    end)

                    widgets_toggle_animation.ended:unsubscribe(self)
                end)
            else
                background.visible = true
                menu.visible = true
                menu_toggle_animation.target = 0

                menu_toggle_animation.ended:subscribe(function()
                    menu_toggle_animation.ended:unsubscribe(self)

                    widgets.visible = true
                    awesome.emit_signal("player:reset_scroll")

                    widgets_toggle_animation.target = player_widget.forced_height + controls_widget.forced_height + (beautiful.menu_vgap * 3)
                end)
                widgets_toggle_animation.ended:subscribe(function()
                    widgets_toggle_animation.ended:unsubscribe(self)
                    menu_keygrabber:start()
                end)
            end
        end
    end)
end
