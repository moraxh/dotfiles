local ui = {}

function ui.add_hover(widget, cursor)
    cursor = cursor or "hand2"

    widget:connect_signal("mouse::enter", function()
        local w = mouse.current_wibox
        old_cursor, old_widget = w.cursor, w
        w.cursor = cursor
    end)

    widget:connect_signal("mouse::leave", function()
        if old_widget then
            old_widget.cursor = old_cursor
            old_widget = nil
        end
    end)
end

function ui.add_color_hover(widget, color)

    widget:connect_signal("mouse::enter", function()
        old_color = widget.bg
        widget.bg = color
    end)

    widget:connect_signal("mouse::leave", function()
        widget.bg = old_color
    end)
end

function ui.add_border_color_hover(widget, border_color)

    widget:connect_signal("mouse::enter", function()
        old_border_color = widget.border_color
        widget.border_color = border_color
    end)

    widget:connect_signal("mouse::leave", function()
        widget.border_color = old_border_color
    end)
end

function ui.add_size_hover(widget, multiplier)
    multiplier = multiplier or 1.05

    widget:connect_signal("mouse::enter", function()
        old_height, old_width = widget.forced_height, widget.forced_width
        widget.forced_height = widget.forced_height * multiplier
        widget.forced_width = widget.forced_width * multiplier
    end)

    widget:connect_signal("mouse::leave", function()
        widget.forced_height = old_height
        widget.forced_width = old_width
    end)
end

return ui
