xresources = require("beautiful.xresources")
utilities  = require("utilities")
animation  = require("lib.rubato")
cairo      = require("lgi").cairo
dpi        = xresources.apply_dpi

beautiful  = require("beautiful")
naughty    = require("naughty")
wibox      = require("wibox")
ruled      = require("ruled")
awful      = require("awful")
gears      = require("gears")

require("awful.autofocus")

--  ________
-- /_  __/ /  ___ __ _  ___
--  / / / _ \/ -_)  ' \/ -_)
-- /_/ /_//_/\__/_/_/_/\__/

local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
beautiful.init(theme_dir .. "theme.lua")

--   _____          ____                    __  _
--  / ___/__  ___  / _(_)__ ___ _________ _/ /_(_)__  ___
-- / /__/ _ \/ _ \/ _/ / _ `/ // / __/ _ `/ __/ / _ \/ _ \
-- \___/\___/_//_/_//_/\_, /\_,_/_/  \_,_/\__/_/\___/_//_/
--                    /___/

require("configuration")

--   __  ______
--  / / / /  _/
-- / /_/ // /
-- \____/___/

require("ui")

--    _____                __
--   / __(_)__ ____  ___ _/ /__
--  _\ \/ / _ `/ _ \/ _ `/ (_-<
-- /___/_/\_, /_//_/\_,_/_/___/
--       /___/

require("signals")

--   _____         __
--  / ___/__ _____/ /  ___ ____ ____
-- / (_ / _ `/ __/ _ \/ _ `/ _ `/ -_)
-- \___/\_,_/_/ /_.__/\_,_/\_, /\__/
--                        /___/

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({ timeout = 5, autostart = true, call_now = true, callback = function()
    collectgarbage("collect")
end})
