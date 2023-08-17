local apps = require("configuration.apps")

return function()
    local title_font_size       = dpi(11)
    local artist_font_size      = dpi(10)
    local progress_font_size    = dpi(8)

    local cover_image = gears.filesystem.get_cache_dir() .. "cover.png"

    --------------
    -- Information
    --------------

    local cover = wibox.widget({
        widget          = wibox.container.background,
        forced_height   = dpi(130),
        forced_width    = dpi(130),
        shape           = utilities.shapes.rrect(13),
    })

    local title = wibox.widget({
        {
            widget          = wibox.widget.textbox,
            forced_height   = dpi(20),
            font            = beautiful.font_medium,
        },
        layout      = wibox.container.scroll.horizontal,
        extra_space = 30,
        speed       = 20,
        fps         = 30,
    })


    local artist = wibox.widget({
        {
            widget          = wibox.widget.textbox,
            forced_height   = dpi(15),
            font            = beautiful.player_artist_font,
        },
        layout      = wibox.container.scroll.horizontal,
        extra_space = 30,
        speed       = 20,
        fps         = 20,
    })

    awesome.connect_signal("player:reset_scroll", function()
        title:reset_scrolling()
        title:pause()

        artist:reset_scrolling()
        artist:pause()

        gears.timer({ timeout = 1.5, single_shot = true, autostart = true, call_now = false, callback = function() title:continue() artist:continue() end})
    end)

    -----------
    -- Controls
    -----------

    local prev = utilities.button.hover({
        bg_hover    = beautiful.transparent,
        markup      = utilities.text.format(beautiful.icon_prev, beautiful.white, false, dpi(20)),
        action      = function() awful.spawn("playerctl -p " .. apps.player .. " -s previous ") end,
        shape       = gears.shape.circle,
        font        = beautiful.icon_font1,
        bg          = beautiful.transparent,
    })

    local play = utilities.button.hover({
        forced_height   = dpi(37),
        forced_width    = dpi(37),
        bg_hover        = beautiful.white_alt,
        action          = function() awful.spawn("playerctl -p " .. apps.player .. " -s play-pause") end,
        shape           = gears.shape.circle,
        font            = beautiful.icon_font1,
        bg              = beautiful.white,
    })

    local next = utilities.button.hover({
        bg_hover    = beautiful.transparent,
        markup      = utilities.text.format(beautiful.icon_next, beautiful.white, false, dpi(20)),
        action      = function() awful.spawn("playerctl -p " .. apps.player .. " -s next") end,
        shape       = gears.shape.circle,
        font        = beautiful.icon_font1,
        bg          = beautiful.transparent,
    })

    local control_buttons = wibox.widget({
        {
            prev,
            widget = wibox.container.place,
        },
        {
            play,
            widget = wibox.container.place,
        },
        {
            next,
            widget = wibox.container.place,
        },
        layout = wibox.layout.align.horizontal,
    })

    -------------
    -- ProgresBar
    -------------

    local progress_bar = wibox.widget({
        widget              = wibox.widget.progressbar,
        background_color    = beautiful.bg_alt,
        forced_height       = dpi(3),
        bar_shape           = gears.shape.rounded_bar,
        color               = beautiful.white,
        shape               = gears.shape.rounded_bar,
    })

    local current_progress = wibox.widget({
        widget  = wibox.widget.textbox,
        font    = beautiful.font_medium,
    })

    local duration = wibox.widget({
        widget  = wibox.widget.textbox,
        font    = beautiful.font_medium,
    })

    local progress_widget = wibox.widget({
        progress_bar,
        {
            {
                {
                    current_progress,
                    widget = wibox.container.place,
                    halign = "left",
                },
                {
                    duration,
                    widget = wibox.container.place,
                    halign = "right",
                },
                layout      = wibox.layout.align.horizontal,
                fill_space  = true,
            },
            widget  = wibox.container.margin,
            top     = dpi(3),
        },
        layout = wibox.layout.fixed.vertical,
    })

    local widget = wibox.widget({
        {
            {
                {
                    cover,
                    widget  = wibox.container.margin,
                    right   = dpi(25),
                },
                {
                        {
                            title,
                            artist,
                            layout = wibox.layout.fixed.vertical,
                        },
                        {
                            control_buttons,
                            widget  = wibox.container.margin,
                            bottom  = dpi(5),
                        },
                        {
                            progress_widget,
                            widget  = wibox.container.place,
                            valign  = "bottom"
                        },
                        widget      = wibox.layout.align.vertical,
                        fill_space  = true
                },
                widget = wibox.layout.fixed.horizontal,
            },
            widget                  = wibox.container.place,
            content_fill_horizontal = true,
        },
        widget  = wibox.container.margin,
        margins = dpi(25),
    })

    -- Default values
    play.widget.widget.widget.markup    = utilities.text.format(beautiful.icon_play, beautiful.bg_normal2, false, dpi(17))
    current_progress.markup             = utilities.text.format("0:00", beautiful.white, false, progress_font_size)
    artist.widget.markup                = utilities.text.format("No artist", beautiful.bg_alt, false, artist_font_size)
    title.widget.markup                 = utilities.text.format("No music playing", beautiful.white, false, title_font_size)
    progress_bar.value                  = 0
    duration.markup                     = utilities.text.format("0:00", beautiful.white, false, nil)
    cover.bgimage                       = utilities.mcairo.resize_png(beautiful.player_image, cover.forced_width, cover.forced_height)

    -- Updates progress_bar information
    awesome.connect_signal("signal:music_pos", function(percentage, progress)
        progress_bar.value      = percentage
        local progress_minutes  = tostring(math.floor(progress // 60))
        local progress_seconds  = tostring(math.floor(progress % 60))

        -- Add a 0 in front
        if tonumber(progress_seconds) < 10 then
            progress_seconds = "0" .. progress_seconds
        end

        local progress_time     = progress_minutes .. ":" .. progress_seconds
        current_progress.markup = utilities.text.format(progress_time, beautiful.white, false, progress_font_size)
    end)

    -- Updates when play_pause button is pressed
    awesome.connect_signal("signal:update_play_pause", function(is_playing)
        if is_playing then
            play.widget.widget.widget.markup = utilities.text.format(beautiful.icon_pause, beautiful.bg_normal2, false, dpi(17))
        else
            play.widget.widget.widget.markup = utilities.text.format(beautiful.icon_play, beautiful.bg_normal2, false, dpi(17))
        end
    end)

    -- Updates cover image
    awesome.connect_signal("signal:update_cover", function(cover_url)
        if gears.filesystem.file_readable(cover_image) and cover_url ~= nil then
            cover.bgimage = utilities.mcairo.resize_png(cover_image, cover.forced_width, cover.forced_height)
        else
            cover.bgimage = utilities.mcairo.resize_png(beautiful.player_image, cover.forced_width, cover.forced_height)
        end
    end)

    -- Updates music info in a song change event
    awesome.connect_signal("signal:music_info", function(status)
        awesome.emit_signal("player:reset_scroll")
        -- Update song
        if status[2] == nil then
            status[2] = "No music playing"
        end

        if status[3] == nil then
            status[3] = "No artist"
        end

        if status[4] ~= nil then
            cover.bgimage = gears.surface.load_uncached(utilities.mcairo.resize_png(beautiful.player_image, cover.forced_width, cover.forced_height))
        else
            cover.bgimage = gears.surface.load_uncached(utilities.mcairo.resize_png(cover_image, cover.forced_width, cover.forced_height))
        end

        if status[6] == nil then
            status[6] = 0
        end

        if status[6] == nil then
            status[6] = 0
        end

        local duration_minutes = tostring(math.floor(status[6] // 60))
        local duration_seconds = tostring(math.floor(status[6] % 60))

        -- Add a 0 in front
        if tonumber(duration_seconds) < 10 then
            duration_seconds = "0" .. duration_seconds
        end

        local duration_time = duration_minutes .. ":" .. duration_seconds

        if status[1] then
            play.widget.widget.widget.markup = utilities.text.format(beautiful.icon_pause, beautiful.bg_normal2, false, dpi(17))
        else
            play.widget.widget.widget.markup = utilities.text.format(beautiful.icon_play, beautiful.bg_normal2, false, dpi(17))
        end

        duration.markup         = utilities.text.format(duration_time, beautiful.white, false, progress_font_size)
        artist.widget.markup    = utilities.text.format(status[3], beautiful.black_alt, false, artist_font_size)
        title.widget.markup     = utilities.text.format(status[2], beautiful.white, false, title_font_size)
    end)

    return widget
end
