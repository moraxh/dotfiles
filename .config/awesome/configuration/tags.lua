local awful = require("awful")

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    local names = { " ", " ", " ", " ", " ", " ", " " }
    local l = awful.layout.suit
    local layout = l.fair
    awful.tag(names, s, layout)
end)
