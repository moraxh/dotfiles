awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    local l = awful.layout.suit
    local layout = l.fair
    awful.tag(names, s, layout)
end)
