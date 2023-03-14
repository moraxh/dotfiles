local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local _button = {}

function _button.hover(args)
    args.bg = args.bg or nil
    args.forced_width = args.forced_width or nil
    args.forced_height = args.forced_height or nil
    args.shape = args.shape or gears.shape.circle

    args.margin = args.margin or dpi(10)

    args.text = args.text or nil
    args.text_valign = args.text_valign or "center"
    args.text_halign = args.text_halign or "center"
    args.markup = args.markup or nil

    local widget = wibox.widget({
        {
            {
                {
                    markup = args.markup,
                    text = args.text,
                    valign = args.text_valign,
                    halign = args.text_halign,
                    widget = wibox.widget.textbox,
                },
                widget = wibox.container.background,
            },
            margins = args.margin,
            widget = wibox.container.margin,
        },
        bg = args.bg,
        shape = args.shape,
        forced_width = args.forced_width,
        forced_height = args.forced_height,
        widget = wibox.container.background,
    })

    return widget
end

return _button
