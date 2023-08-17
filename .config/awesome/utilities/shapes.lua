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
		gears.shape.squircle(cr, width, height, rate, delta)
	end
end

function shapes.arc(thickness, start_angle, end_angle, start_rounded, end_rounded)
    return function(cr, width, height)
        gears.shape.arc(cr, width, height, thickness, start_angle, end_angle, start_rounded, end_rounded)
    end
end

return shapes
