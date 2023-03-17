local awful = require("awful")
local gears = require("gears")
local apps = require("configuration.apps")

local mod = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"

-- Global bindings
awful.keyboard.append_global_keybindings({

	----- Apps
	----------

	-- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn(apps.terminal)
	end, {description = "Open a terminal", group = "App"}),

	-- Launcher
	awful.key({ mod }, "d", function()
		awful.spawn(apps.launcher)
	end, {description = "Open the lanucher", group = "App"}),


	----- Awesome
	-------------

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


    -- Custom keys
	awful.key({ mod }, "Escape", function()
        awesome.emit_signal("signal:menu_toggle")
	end, {description = "Toggle menu", group = "Awesome"}),

	awful.key({ mod, shift }, "e", function()
        awesome.emit_signal("signal:powermenu_toggle")
	end, {description = "Toggle powermenu", group = "Awesome"}),

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
