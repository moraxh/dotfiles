local gears = require("gears")
local awful = require("awful")

local network = {}

function network:connected() 
	return os.execute("wget --spider google.com &> /dev/null")
end

gears.timer { call_now = true, timeout = 10, autostart = true, callback = function() 
	awesome.emit_signal("signal:network", network.connected())
end }

