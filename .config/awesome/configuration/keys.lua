local apps = require("configuration.apps")

local mod = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"

-- Global bindings
awful.keyboard.append_global_keybindings({


    --    ___
    --   / _ | ___  ___  ___
    --  / __ |/ _ \/ _ \(_-<
    -- /_/ |_/ .__/ .__/___/
    --      /_/  /_/

	-- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn(apps.terminal)
	end, {description = "Open a terminal", group = "App"}),

	-- Launcher
	awful.key({ mod }, "d", function()
		awful.spawn(apps.launcher)
	end, {description = "Open the lanucher", group = "App"}),

    --    ___
    --   / _ |_    _____ ___ ___  __ _  ___
    --  / __ | |/|/ / -_|_-</ _ \/  ' \/ -_)
    -- /_/ |_|__,__/\__/___/\___/_/_/_/\__/
    --

	-- Restart awesome
    	awful.key({ mod, ctrl }, "r", awesome.restart,
        {description = "Reload awesome", group = "Awesome"}),

	-- View tag
	awful.key({
		modifiers = { mod },
		description = "View tag",
		group = "Tags",
		keygroup = "numrow",
		on_press = function(i)
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
			   tag:view_only()
			end
		end,
	}),
	-- Move client to tag
	awful.key({
		modifiers = { mod, shift },
		description = "Move client to tag",
		group = "Tags",
		keygroup = "numrow",
		on_press = function(i)
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
	end}),

	-- Move client to tag then view the tag
	awful.key({
		modifiers = { mod, ctrl },
		description = "Move client to tag and view tag",
		group = "Tags",
		keygroup = "numrow",
		on_press = function(i)
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
			      tag:view_only()
                          end
                     end
	end}),


    --   _____          __           __
    --  / ___/__  ___  / /________  / /__
    -- / /__/ _ \/ _ \/ __/ __/ _ \/ (_-<
    -- \___/\___/_//_/\__/_/  \___/_/___/

    -- Brightness
	awful.key({ }, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl s +10% -q")
	end, {description = "Brightness up", group = "Awesome"}),

	awful.key({ }, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl s 10%- -q")
	end, {description = "Brightness down", group = "Awesome"}),

	-- Volume
	awful.key({ }, "XF86AudioRaiseVolume", function()
		awful.spawn("amixer -q -D default set Master 5%+ unmute")
	end, {description = "Volume up", group = "Awesome"}),

	awful.key({ }, "XF86AudioLowerVolume", function()
		awful.spawn("amixer -q -D default set Master 5%- unmute")
	end, {description = "Volume down", group = "Awesome"}),

	awful.key({ }, "XF86AudioMute", function()
		awful.spawn("amixer -q -D default set Master toggle")
	end, {description = "Toggle mute", group = "Awesome"}),

    -- Play Pause
	awful.key({ }, "XF86AudioPlay", function()
		awful.spawn("playerctl play-pause --player=" .. apps.player)
	end, {description = "Toggle mute", group = "Awesome"}),

    -- Screenshot
	awful.key({ }, "Print", function()
        utilities.sshot.full()
	end, {description = "Take screenshot", group = "Awesome"}),

    --   _____         __
    --  / ___/_ _____ / /____  __ _
    -- / /__/ // (_-</ __/ _ \/  ' \
    -- \___/\_,_/___/\__/\___/_/_/_/

	awful.key({ mod }, "Escape", function()
        awesome.emit_signal("signal:menu_toggle")
	end, {description = "Toggle menu", group = "Awesome"}),

	awful.key({ mod, shift }, "e", function()
        awesome.emit_signal("signal:powermenu_toggle")
	end, {description = "Toggle powermenu", group = "Awesome"}),

	awful.key({ mod, shift }, "l", function()
        awesome.emit_signal("signal:lockscreen_lock")
	end, {description = "Toggle lockscreen", group = "Awesome"}),

})

-- Client bindings
awful.keyboard.append_client_keybindings({

	-- Close
	awful.key({ mod }, "w", function()
		client.focus:kill()
	end, { description = "Close", group = "Client" }),

	-- Focus client by direction
	awful.key({ mod }, "l", function()
		awful.client.focus.bydirection("right")
	end, {description = "Focus right", group = "Client"}),
	awful.key({ mod }, "h", function()
		awful.client.focus.bydirection("left")
	end, {description = "Focus left", group = "Client"}),
	awful.key({ mod }, "k", function()
		awful.client.focus.bydirection("up")
	end, {description = "Focus up", group = "Client"}),
	awful.key({ mod }, "j", function()
		awful.client.focus.bydirection("down")
	end, {description = "Focus down", group = "Client"}),

	-- Swap client by direction
	awful.key({ mod, shift }, "l", function()
		awful.client.swap.bydirection("right")
	end, {description = "Swap left ", group = "Client"}),
	awful.key({ mod, shift }, "h", function()
		awful.client.swap.bydirection("left")
	end, {description = "Swap right", group = "Client"}),
	awful.key({ mod, shift }, "k", function()
		awful.client.swap.bydirection("up")
	end, {description = "Swap up", group = "Client"}),
	awful.key({ mod, shift }, "j", function()
		awful.client.swap.bydirection("down")
	end, {description = "Swap down", group = "Client"}),

	-- Toggle floating
	awful.key({ mod, shift }, "space", function()
		client.focus.floating = not client.focus.floating
		client.focus.raise()
	end, {description = "Toggle floating", group = "Client"}),
	-- Toggle fullscreen
	awful.key({ mod }, "f", function()
		client.focus.fullscreen = not client.focus.fullscreen
	end, {description = "Toggle fullscreen", group = "Client"}),

	-- Resize client
	-- TODO

	-- Toggle sticky
	awful.key({ mod, shift }, "s", function(c)
		c.sticky = not c.sticky
	end, {description = "Toggle sticky", group = "Client"}),

})

-- Mouse bindings
awful.mouse.append_client_mousebindings({
	-- Move client
	awful.button({ mod }, 1, function(c)
		c:activate({ context = "mouse_click", action = "mouse_move" })
	end, {description = "Move client", group = "Client"}),

	-- Resize client
	awful.button({ mod }, 3, function(c)
		c:activate({ context = "mouse_click", action = "mouse_resize" })
	end, {description = "Resize client", group = "Client"}),
})
