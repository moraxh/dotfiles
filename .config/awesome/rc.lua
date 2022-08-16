local gears = require("gears")
local beautiful = require("beautiful")
require("awful.autofocus")

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
