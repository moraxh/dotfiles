local gears = require("gears")

local shapes = {}

function shapes.rrect(radius)
	return function (cr, width, height)
		gears.shape.rounded_rect (cr, width, height, radius)
	end
end

function shapes.prrect(tl, tr, br, bl, radius)
	return function (cr, width, height)
		gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
	end
end

function shapes.squircle(rate)
	return function(cr, width, height, delta)
		gears.shape.squircle (cr, width, height, rate, delta)
	end
end

return shapes
