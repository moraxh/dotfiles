local gears = require("gears")

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

return ui
