local gears = require("gears")
local beautiful = require("beautiful")

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
