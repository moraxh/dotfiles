client.connect_signal("manage", function(c)
	-- Rounded corners
    c.shape = utilities.shapes.rrect(15)

    -- If client get fullscreen change its shape
    c:connect_signal("property::fullscreen", function(self)
        if self.fullscreen then
            c.shape = gears.shape.rectangle
        else
            c.shape = utilities.shapes.rrect(20)
        end
    end)
end)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
--client.connect_signal("request::titlebars", function(c)
--    -- buttons for the titlebar
--    local buttons = gears.table.join(
--        awful.button({ }, 1, function()
--            c:emit_signal("request::activate", "titlebar", {raise = true})
--            awful.mouse.client.move(c)
--        end),
--        awful.button({ }, 3, function()
--            c:emit_signal("request::activate", "titlebar", {raise = true})
--            awful.mouse.client.resize(c)
--        end)
--    )
--end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
-- }}}
