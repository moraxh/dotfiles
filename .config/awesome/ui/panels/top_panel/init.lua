return function(s)

	local widget_dir = "ui.panels.top_panel"
	clock   = require(widget_dir .. ".clock")()
	battery = require(widget_dir .. ".battery")()
	network = require(widget_dir .. ".network")()
    volume  = require(widget_dir .. ".volume")(s)
	taglist = require(widget_dir .. ".taglist")(s)
	menu    = require(widget_dir .. ".menu")()
	window  = require(widget_dir .. ".window")()

    local separator = wibox.widget({
        {
            widget          = wibox.container.background,
            shape           = gears.shape.rounded_bar,
            forced_height   = dpi(26),
            forced_width    = dpi(5),
            bg              = beautiful.bg_alt,
        },
        widget = wibox.container.place,
    })

    function template_bar(_widget)
        return wibox.widget({
            {
                _widget,
                widget = wibox.container.margin,
                left   = beautiful.wibar_gap,
                right  = beautiful.wibar_gap,
            },
            widget          = wibox.container.background,
            forced_height   = beautiful.wibar_height,
            shape           = gears.shape.rounded_bar,
            bg              = beautiful.bg_normal,
        })
    end

	s.bar = awful.wibar({
		bg          = beautiful.transparent,
		position    = "top",
        margins = {
            left    = beautiful.wibar_margin,
            right   = beautiful.wibar_margin,
            top     = beautiful.wibar_margin,
        },
        shape = utilities.shapes.rrect(20),
	})

	s.bar:setup {
        -- Left
        {
            -- Menu
            template_bar(menu),
            template_bar(taglist),
            layout  = wibox.layout.fixed.horizontal,
            spacing = beautiful.wibar_spacing,
        },
        -- Middle
        template_bar(window),
        -- Right
        template_bar(
            wibox.widget({
                {
                    network,
                    volume,
                    battery,
                    layout = wibox.layout.fixed.horizontal,
                    spacing = beautiful.wibar_icons_spacing2,
                },
                separator,
                clock,
                layout  = wibox.layout.fixed.horizontal,
                spacing = beautiful.wibar_icons_spacing1,
            })
        ),
        layout = wibox.layout.align.horizontal,
        expand = "none"
	}

end
