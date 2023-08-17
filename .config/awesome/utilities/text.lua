local text = {}

function text.format(text, color, bold, size)
	if size ~= nil then
		if bold == true then
			return "<span foreground='" .. color .. "' size='" .. tostring(size) .. "pt'><b>" .. text .. "</b></span>"
		else
			return "<span foreground='" .. color .. "' size='" .. tostring(size) .. "pt'>" .. text .. "</span>"
		end
	elseif bold == true then
		return "<span foreground='" .. color .. "'><b>" .. text .. "</b></span>"
	else
		return "<span foreground='" .. color .. "'>" .. text .. "</span>"
	end
end

return text
