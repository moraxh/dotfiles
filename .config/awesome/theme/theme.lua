local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")

local theme = {}

theme.wallpaper 	= gears.filesystem.get_configuration_dir() .. "/theme/Wallpaper.jpg"

theme.font 			= "Chillax 11"
theme.icon_font 	= "Font Awesome 6 Free solid 7"
theme.icon_font_alt = "FiraCode Nerd Font Mono"

--   _____     __
--  / ___/__  / /__  _______
-- / /__/ _ \/ / _ \/ __(_-<
-- \___/\___/_/\___/_/ /___/

-- Using mocha colorscheme from cattpuccin
-- https://github.com/catppuccin/catppuccin

theme.transparent   = "#00000000"

theme.black   	    = "#45475A"
theme.altblack      = "#585B70"
theme.white   	    = "#BAC2DE"
theme.altwhite      = "#A6ADC8"

theme.red     	    = "#F38BA8"
theme.green   	    = "#A6E3A1"
theme.yellow  	    = "#F9E2AF"
theme.blue    	    = "#89B4FA"
theme.magenta 	    = "#F5C2E7"
theme.cyan    	    = "#94E2D5"

theme.useless_gap   = dpi(5)

theme.bg_normal 	= "#11111b"
theme.bg_alt		= "#313244"
theme.bg_alt2 		= "#1e1e2e"

theme.tag_empty 	= "#45475A"
theme.tag_focus 	= "#8CAAEE"
theme.tag_normal	= "#BAC2DE"
theme.tag_urgent 	= "#F38BA8"

--  _      ___ __
-- | | /| / (_) /  ___ _____
-- | |/ |/ / / _ \/ _ `/ __/
-- |__/|__/_/_.__/\_,_/_/

theme.wibar_height 	= dpi(40)
theme.wibar_font   	= "Chillax medium 14"
theme.wibar_gap		= dpi(5)
theme.wibar_spacing = dpi(15)
theme.widget_height = theme.wibar_height

-- Taglist
theme.taglist_size  = dpi(6)

-- Network
theme.network_font = "Material Icons 12"
theme.icon_no_network = ""
theme.icon_network_low = ""
theme.icon_network_mid = ""
theme.icon_network_high = ""

return theme
