local gears = require("gears")

local ui = {}

function ui.add_hover(widget, cursor)

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

return ui
