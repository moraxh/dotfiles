local ui = require("utilities.ui")

local _button = {}

function _button.hover(args)
    args.border_color_hover     = args.border_color_hover       or nil
    args.forced_height          = args.forced_height            or nil
    args.forced_width           = args.forced_width             or nil
    args.border_width           = args.border_width             or 0
    args.border_color           = args.border_color             or nil
    args.bg_hover               = args.bg_hover                 or nil
    args.shape                  = args.shape                    or nil
    args.bg                     = args.bg                       or nil

    args.margin                 = args.margin                   or dpi(10)

    args.text_valign            = args.text_valign              or "center"
    args.text_halign            = args.text_halign              or "center"
    args.markup                 = args.markup                   or nil
    args.text                   = args.text                     or nil
    args.font                   = args.font                     or nil

    args.size_hover_multiplier  = args.size_hover_multiplier    or 1.1
    args.size_hover             = args.size_hover               or false
    args.action                 = args.action                   or function() end

    local widget = wibox.widget({
        {
            {
                {
                    widget  = wibox.widget.textbox,
                    valign  = args.text_valign,
                    halign  = args.text_halign,
                    markup  = args.markup,
                    text    = args.text,
                    font    = args.font,
                },
                widget = wibox.container.place,
            },
            widget  = wibox.container.margin,
            margins = args.margin,
        },
        widget          = wibox.container.background,
        forced_height   = args.forced_height,
        forced_width    = args.forced_width,
        border_width    = args.border_width,
        border_color    = args.border_color,
        shape           = args.shape,
        bg              = args.bg,
    })

    ui.add_hover(widget)

    if args.bg_hover then
        ui.add_color_hover(widget, args.bg_hover)
    end

    if args.border_color_hover then
        ui.add_border_color_hover(widget, args.border_color_hover)
    end

    if args.size_hover == true then
        ui.add_size_hover(widget, args.size_hover_multiplier)
    end

    widget:connect_signal("button::press", args.action)

    return widget
end

return _button
