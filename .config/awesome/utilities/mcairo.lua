local mcairo = {}

function mcairo.resize_png(_path, _width, _height)
    local surface = cairo.ImageSurface.create(cairo.Format.ARGB32, _width, _height)
    local cr  = cairo.Context(surface)
    local img = cairo.ImageSurface.create_from_png(_path)

	cr:scale(_width / img.width, _height / img.height)
	cr:set_source_surface(img, 0, 0)
	cr:paint()

    return surface
end

function mcairo.dark_surface(_surface, _darkness)
    local cr = cairo.Context(_surface)
    cr:set_source_rgba(0, 0, 0, _darkness)
    cr:rectangle(0, 0, _surface.width, _surface.height)
    cr:fill()

    return _surface
end

return mcairo
