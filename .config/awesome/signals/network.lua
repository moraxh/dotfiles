local gears = require("gears")
local awful = require("awful")

local network = {}

local naughty = require("naughty")

exit = nil
level = nil

function network:connected()
	 awful.spawn.easy_async_with_shell("wget --spider google.com", function(a, b, c, out)
		exit = out
	end)

	return { exit, level }
end

function network:level()
	if exit == 0 then 
		awful.spawn.easy_async_with_shell("awk 'NR==3{print int($4 * -1)}' /proc/net/wireless", function(stdout) 
			level = stdout
		end)
	end	
end

gears.timer { call_now = true, timeout = 5, autostart = true, callback = function() 
	awesome.emit_signal("signal:network", network.connected())
end }

gears.timer { call_now = false, timeout = 10, autostart = true, callback = function() 
	network.level()
end }
