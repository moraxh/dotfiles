local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local utilities = require("utilities")
local animation = require("lib.rubato")

local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

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

					self.tag_animator = animation.timed {
						outro = 0.1,
						duration = 0.3,
						pos = beautiful.taglist_size,
						easing = animation.quadratic,
						subscribed = function(pos)
							tag_indicator.children[1].forced_width = beautiful.taglist_size * pos
						end
					}

					self:set_widget(tag_indicator)

					if tag.selected and #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_animator.target = 1
					elseif tag.selected then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_animator.target = 4
					elseif #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_empty
						self.tag_animator.target = 1
					else
						self.widget.children[1].bg = beautiful.tag_normal
						self.tag_animator.target = 2
					end
				end,
				update_callback = function(self, tag)
					if tag.selected and #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_animator.target = 1
					elseif tag.selected then
						self.widget.children[1].bg = beautiful.tag_focus
						self.tag_animator.target = 4
					elseif #tag:clients() == 0 then
						self.widget.children[1].bg = beautiful.tag_empty
						self.tag_animator.target = 1
					else
						self.widget.children[1].bg = beautiful.tag_normal
						self.tag_animator.target = 2
					end
				end
			},
		style = {
			font = beautiful.taglist_icon,
			spacing = dpi(12),
		},
		buttons = taglist_buttons
	})

	local widget = wibox.widget({
        {
            widget = wibox.container.background,
            {
                taglist,
                widget = wibox.container.place,
            },
            forced_height = beautiful.widget_height * 0.7,
            forced_width = dpi(260),
            bg = beautiful.bg_alt2,
            shape = gears.shape.rounded_bar,
        },
        widget = wibox.container.place,
        valign = "center",
        halign = "center"
	})

	return widget

end
