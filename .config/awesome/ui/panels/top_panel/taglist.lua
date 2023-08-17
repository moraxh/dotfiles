return function(s)

	local taglist_buttons = gears.table.join({
		awful.button({}, 1, function(t)
			t:view_only()
		end)
	})

	local widget = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
			widget_template = {
				widget = wibox.container.place,

				create_callback = function(self, tag)
					local tag_indicator = wibox.widget({
						{
                            {
                                {
                                    widget = wibox.container.background,
                                    forced_width    = beautiful.taglist_size,
                                    shape           = gears.shape.circle,
                                },
                                widget = wibox.container.place,
                                valign = "bottom",
                            },
							widget = wibox.container.background,
							forced_height   = beautiful.taglist_size,
							forced_width    = beautiful.taglist_size,
                            border_width    = dpi(1),
                            border_color    = beautiful.white,
							shape           = gears.shape.circle,
                            bg              = beautiful.transparent,
						},
						widget = wibox.container.place,
					})

                    utilities.ui.add_hover(tag_indicator)
					self:set_widget(tag_indicator)

					self.tag_animator = animation.timed {
						duration    = 0.5,
						easing      = animation.quadratic,
						intro       = 0.25,
						pos         = beautiful.taglist_size,
						subscribed = function(pos)
                            tag_indicator.children[1].children[1].children[1].forced_height = pos
						end
					}

					if tag.selected and #tag:clients() == 0 then
						self.widget.children[1].border_color = beautiful.tag_focus
                        self.tag_animator.target = 0
					elseif tag.selected then
                        self.widget.children[1].children[1].children[1].bg = beautiful.tag_focus
						self.widget.children[1].border_color = beautiful.tag_focus
                        self.tag_animator.target = beautiful.taglist_size
					elseif #tag:clients() == 0 then
						self.widget.children[1].border_color = beautiful.tag_normal
                        self.tag_animator.target = 0
					else
                        self.widget.children[1].children[1].children[1].bg = beautiful.tag_normal
						self.widget.children[1].border_color = beautiful.tag_normal
                        self.tag_animator.target = beautiful.taglist_size
					end
				end,
				update_callback = function(self, tag)
					if tag.selected and #tag:clients() == 0 then
						self.widget.children[1].border_color = beautiful.tag_focus
                        self.tag_animator.target = 0
					elseif tag.selected then
                        self.widget.children[1].children[1].children[1].bg = beautiful.tag_focus
						self.widget.children[1].border_color = beautiful.tag_focus
                        self.tag_animator.target = beautiful.taglist_size
					elseif #tag:clients() == 0 then
						self.widget.children[1].border_color = beautiful.tag_normal
                        self.tag_animator.target = 0
					else
                        self.widget.children[1].children[1].children[1].bg = beautiful.tag_normal
						self.widget.children[1].border_color = beautiful.tag_normal
                        self.tag_animator.target = beautiful.taglist_size
					end
				end
			},
		style = {
			spacing = dpi(17),
		},
		buttons = taglist_buttons
	})

	return widget
end
