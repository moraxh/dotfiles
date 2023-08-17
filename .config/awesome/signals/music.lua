local apps = require("configuration.apps")
local music = {}


local there_is_player = false
local is_playing = false
local title = nil
local artist = nil
local cover_url = nil
local actual = nil
local max = nil

function music:is_playing()
    awful.spawn.easy_async_with_shell("playerctl -p " .. apps.player .. " status", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")

        if stdout == "Playing" then
            if not(is_playing) then
                is_playing = true
                awesome.emit_signal("signal:update_play_pause", is_playing)
            end

            music.get_title()
            music.send_pos()
        else
            if is_playing then
                is_playing = false
                awesome.emit_signal("signal:update_play_pause", is_playing)
            end
        end
    end)
end

function music:there_is_player()
    awful.spawn.easy_async_with_shell("playerctl -s -l | grep " .. apps.player, function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")

        if stdout == apps.player then
            there_is_player = true

            music.is_playing()
        else
            -- Execute only in changed state
            if there_is_player == true then
                there_is_player = false
                is_playing = false
                title = nil
                artist = nil
                cover_url = nil
                actual = nil
                max = nil
                awesome.emit_signal("signal:music_info", {is_playing, title, artist, cover_url, actual, max})
                awesome.emit_signal("signal:update_cover", cover_url)
                awesome.emit_signal("signal:music_pos", 0, 0)
            end
        end
    end)
end

function music:send_info()
    awful.spawn.easy_async_with_shell("playerctl -p " .. apps.player .. " metadata --format title:{{title}},artist:{{artist}},artUrl:{{mpris:artUrl}},duration:{{mpris:length}}", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")

        title = stdout:match('title:(.*),artist:') or nil
        artist = stdout:match('artist:(.*),artUrl:') or nil
        cover_url = stdout:match('artUrl:(.*)') or nil
        max = tonumber(stdout:match('duration:(.*)')) / 1000000 or nil

        music.download_cover()
        awesome.emit_signal("signal:music_info", {is_playing, title, artist, cover_url, actual, max})
    end)
end

function music:get_title()
    awful.spawn.easy_async_with_shell("playerctl -p " .. apps.player .. " metadata title", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")
        stdout = stdout or nil
        -- If song changed
        if title ~= stdout then
            title = stdout
            awesome.emit_signal("music:song_changed")
        end
    end)
end

function music:download_cover()
    -- Download image and convert it
    awful.spawn.easy_async_with_shell("curl $(playerctl -p " .. apps.player .. " metadata mpris:artUrl) --output ~/.cache/awesome/cover ; mogrify -format png ~/.cache/awesome/cover ; rm ~/.cache/awesome/cover", function()
        awesome.emit_signal("signal:update_cover", cover_url)
    end)
end

function music:send_pos()
    awful.spawn.easy_async_with_shell("playerctl -p " .. apps.player .. " position", function(stdout)
        actual = stdout or nil
    end)

    percentage = (tonumber(actual) / tonumber(max))
    awesome.emit_signal("signal:music_pos", percentage, actual)
end

gears.timer { call_now = true, timeout = 0.5, autostart = true, callback = function()
    music.there_is_player()
end }

awesome.connect_signal("music:song_changed", function()
    music.send_info()
end)
