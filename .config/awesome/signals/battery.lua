local battery = {}

local percentage = 0
local time_left = 0
local is_pluged = false

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
gears.timer { call_now = true, timeout = 0.5, autostart = true, callback = function()
	awesome.emit_signal("signal:battery", battery.status())
end }
