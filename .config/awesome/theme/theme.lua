local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")

local theme = {}

theme.wallpaper 	= "~/Pictures/Wallpapers/Wallp1.jpg"

theme.font 			= "Chillax 11"
theme.icon_font 	= "Font Awesome 6 Free solid 7"

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

theme.bg_normal 	= "#181825"
theme.bg_alt		= "#313244"

theme.tag_empty 	= "#45475A"
theme.tag_focus 	= "#8CAAEE"
theme.tag_normal	= "#BAC2DE"
theme.tag_urgent 	= "#F38BA8"

--  _      ___ __           
-- | | /| / (_) /  ___ _____
-- | |/ |/ / / _ \/ _ `/ __/
-- |__/|__/_/_.__/\_,_/_/                             

theme.wibar_height 	= dpi(30)
theme.wibar_font   	= "Chillax medium 12"

-- Taglist
theme.taglist_icon 	= "Font Awesome 6 Free solid 7"
theme.taglist_size  = dpi(6)

-- Battery


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


return theme
