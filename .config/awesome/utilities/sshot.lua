local sshot = {}

function sshot.full()
    local a = awful.screenshot({
        directory       = gears.filesystem.get_cache_dir(),
        prefix          = "ss",
        file_name       = "ss.png",
        file_path       = gears.filesystem.get_cache_dir() .. "ss.png",
        screen          = awful.screen.focused(),
        auto_save_delay = 0,
    })
    awful.spawn("xclip -selection clipboard -t image/png -i ~/.cache/awesome/ss.png")
    naughty.notify({ text = "taked" })
end

return sshot
