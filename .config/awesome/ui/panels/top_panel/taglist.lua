local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local naughty = require("naughty")
return function(s)

	local taglist_buttons = gears.table.join({
		awful.button({}, 1, function(t) 
			t:view_only()
		end)
	})

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
			widget_template = {
				widget = wibox.container.margin,
				forced_width = dpi(20),
				forced_height = dpi(20),
				create_callback = function(self, tag)
					local tag_indicator = wibox.widget({
						{
							widget = wibox.container.background,
							forced_height = beautiful.taglist_size,
							shape = gears.shape.rounded_bar,
						},
						widget = wibox.container.place,
						valign = "center",
					})

					function self.tag_width(pos) 
						tag_indicator.children[1].forced_width = beautiful.taglist_size * pos
					end

					self:set_widget(tag_indicator)


					if tag.selected and #tag:clients() == 0 then 
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_width(1)
					elseif tag.selected then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_width(4)
					elseif #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_empty
						self.tag_width(1)
					else 
						self.widget.children[1].bg = beautiful.tag_normal
						self.tag_width(2)
					end
				end,
				update_callback = function(self, tag)
					if tag.selected and #tag:clients() == 0 then 
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_width(1)
					elseif tag.selected then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_width(4)
					elseif #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_empty
						self.tag_width(1)
					else 
						self.widget.children[1].bg = beautiful.tag_normal
						self.tag_width(2)
					end
				end
			},
		style = {
			font = beautiful.taglist_icon,
			spacing = dpi(10),
		},
		buttons = taglist_buttons
	})

	local widget = wibox.widget({
		widget = wibox.container.background,
		{
			taglist,
			widget = wibox.container.place,
		},
		forced_height = beautiful.wibar_height,
		forced_width = dpi(240),
		border_width = beautiful.wibar_border,
		border_color = beautiful.bg_alt,
		bg = beautiful.bg_normal,
		shape = gears.shape.rounded_bar,
	})

	return widget

end
