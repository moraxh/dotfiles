local theme = {}

theme.lockscreen_wallpaper = gears.filesystem.get_configuration_dir() .. "/theme/assets/Wallpapers/wp2.png"
theme.wallpaper            = gears.filesystem.get_configuration_dir() .. "/theme/assets/Wallpapers/wp6.png"

--   _____     __
--  / ___/__  / /__  _______
-- / /__/ _ \/ / _ \/ __(_-<
-- \___/\___/_/\___/_/ /___/

-- Using mocha colorscheme from cattpuccin
-- https://github.com/catppuccin/catppuccin

theme.transparent = "#00000000"

theme.black       = "#45475A"
theme.black_alt   = "#585B70"
theme.white       = "#CDD6F4"
theme.white_alt   = "#A6ADC8"
theme.white_alt2  = "#6C7086"

theme.red         = "#F38BA8"
theme.green       = "#A6E3A1"
theme.yellow      = "#F9E2AF"
theme.blue        = "#89B4FA"
theme.magenta     = "#F5C2E7"
theme.cyan        = "#94E2D5"

theme.bg_normal   = "#1e1e2e"
theme.bg_normal2  = "#11111b"
theme.bg_alt      = "#313244"

theme.tag_empty   = "#45475A"
theme.tag_focus   = "#8CAAEE"
theme.tag_normal  = "#BAC2DE"
theme.tag_urgent  = "#F38BA8"


--    ____
--   /  _/______  ___  ___
--  _/ // __/ _ \/ _ \(_-<
-- /___/\__/\___/_//_/___/
--

theme.icon_font1        = "Font Awesome 6 Free"
theme.icon_font2        = "Font Awesome 6 Free Solid"
theme.icon_font3        = "FiraCode Nerd Font Mono"

theme.icon_no_network   = "󰤮"
theme.icon_network_low  = "󰤟"
theme.icon_network_mid  = "󰤢"
theme.icon_network_high = "󰤨"

theme.icon_no_volume    = ""
theme.icon_volume_low   = ""
theme.icon_volume_mid   = ""
theme.icon_volume_high  = ""

theme.icon_menu         = ""

theme.icon_poweroff     = ""
theme.icon_reboot       = ""
theme.icon_lock         = ""
theme.icon_logout       = ""
theme.icon_suspend      = ""

theme.icon_prev         = ""
theme.icon_play         = ""
theme.icon_pause        = ""
theme.icon_next         = ""


--  ______        __
-- /_  __/____ __/ /_
--  / / / -_) \ / __/
-- /_/  \__/_\_\\__/
--

theme.font_medium   = "Chillax medium"
theme.font_semibold = "Chillax semibold"

--  _      ___ __
-- | | /| / (_) /  ___ _____
-- | |/ |/ / / _ \/ _ `/ __/
-- |__/|__/_/_.__/\_,_/_/
--

theme.wibar_margin	= dpi(20)
theme.wibar_height 	= dpi(42)
theme.wibar_gap     = dpi(20)
theme.wibar_spacing = dpi(20)

-- Icons
theme.wibar_icons_spacing1 = dpi(15)
theme.wibar_icons_spacing2 = dpi(12)

-- Taglist
theme.taglist_size    = dpi(15)
theme.taglist_spacing = dpi(17)

--   ________          __
--  / ___/ (_)__ ___  / /____
-- / /__/ / / -_) _ \/ __(_-<
-- \___/_/_/\__/_//_/\__/___/

theme.useless_gap  = dpi(10)

--    __  ___
--   /  |/  /__ ___  __ __
--  / /|_/ / -_) _ \/ // /
-- /_/  /_/\__/_//_/\_,_/

-- Menu
theme.menu_hgap = dpi(25)
theme.menu_vgap = dpi(25)

-- User image
if gears.filesystem.file_readable(os.getenv("HOME") .. "/.face") then
    -- String means error
    if type(awful.spawn.easy_async_with_shell("mogrify -format png -path ~/.cache/awesome/ ~/.face ; mv ~/.cache/awesome/.png ~/.cache/awesome/user.png")) ~= "string" then
        theme.profile_image = gears.filesystem.get_cache_dir() .. "user.png"
    else
        theme.profile_image = gears.filesystem.get_configuration_dir() .. "/theme/assets/profile.png"
    end
else
        naughty.notify({ text = "2" })
    theme.profile_image = gears.filesystem.get_configuration_dir() .. "/theme/assets/profile.png"
end

-- Player
theme.player_image  = gears.filesystem.get_configuration_dir() .. "/theme/assets/no_music.png"

--    __            __    ____
--   / /  ___  ____/ /__ / __/__________ ___ ___
--  / /__/ _ \/ __/  '_/_\ \/ __/ __/ -_) -_) _ \
-- /____/\___/\__/_/\_\/___/\__/_/  \__/\__/_//_/

return theme
