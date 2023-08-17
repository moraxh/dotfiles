local audio = {}

local is_unmute = true
local volume  = 50

function audio:get_status()
	awful.spawn.easy_async_with_shell("awk -F'[][]' '/Left:/ { print $2 }' <(amixer sget Master) | sed 's/%//'", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")
        stdout = stdout or 0
        volume = stdout
	end)

	awful.spawn.easy_async_with_shell("awk -F'[][]' '/Left:/ { print $4 }' <(amixer sget Master)", function(stdout)
        -- Delete line break
        stdout = string.gsub(stdout,"\n","")
        stdout = stdout or 0
        if stdout == "on" then
            is_unmute = true
        else
            is_unmute = false
        end
	end)

    return { is_unmute, volume }
end

gears.timer { call_now = true, timeout = 0.5, autostart = true, callback = function()
	awesome.emit_signal("signal:volume_info", audio.get_status())
end }

awesome.connect_signal("signal:update_audio", function()
	awesome.emit_signal("signal:volume_info", audio.get_status())
end)
