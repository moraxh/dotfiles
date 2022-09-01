local gears = require("gears")
local beautiful = require("beautiful")

local _ui = {}

function _ui.rrect(radius) 
	return function (cr, width, height)
		gears.shape.rounded_rect (cr, width, height, radius)
	end
end

function _ui.prrect(tl, tr, br, bl, radius) 
	return function (cr, width, height)
		gears.shape.partially_rounded_rect (cr, width, height, tl, tr, br, bl, radius)
	end
end

function _ui.format(text, color, bold, size)
	if size ~= nil then 
		if bold == true then
			return "<span foreground='" .. color .. "' size='" .. tostring(size) .. "pt'>" .. text .. "</span>"
		else
			return "<span foreground='" .. color .. "' size='" .. tostring(size) .. "pt'><b>" .. text .. "</b></span>"
		end
	elseif bold == true then
		return "<span foreground='" .. color .. "'><b>" .. text .. "</b></span>"	
	else
		return "<span foreground='" .. color .. "'>" .. text .. "</span>"	
	end
end

return _ui
