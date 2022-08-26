local gears = require("gears")
local awful = require("awful")

local battery = {}
tempfile = "/tmp/awesome_battery"

percentage = nil
time_left = nil 
is_pluged = nil

function battery:state()
	awful.spawn.easy_async_with_shell("acpi -b", function(stdout)
		percentage = string.match(stdout, ".-(%d+)%%")
		time_left = string.match(stdout, ".-(%d+:%d+:%d+)")
	end)
end

-- Updating pluged every second
function battery:status()
	awful.spawn.easy_async_with_shell("acpi -b", function(stdout)
		-- Update time left when is_pluged change
		if is_pluged ~= (string.find(stdout, "Discharging") == nil) then
			time_left = string.match(stdout, ".-(%d+:%d+:%d+)")
		end
			
		is_pluged = string.find(stdout, "Discharging") == nil
	end)

	return { tonumber(percentage), time_left, is_pluged }
end

-- Battery State update
gears.timer { call_now = true, timeout = 20, autostart = true, callback = function() battery.state() end }

-- Pluged update and emit signal 
gears.timer { call_now = true, timeout = 1, autostart = true, callback = function()  
	awesome.emit_signal("signal:battery", battery.status())
end }
