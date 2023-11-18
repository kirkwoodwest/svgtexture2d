@tool
extends Sprite2D
class_name SVGSprite2D

@export var SVGTexture: SVGTexture2D = null:
	get:
		return SVGTexture
	set(value):
		SVGTexture = value
		_update_texture()

@export var Resolution: float = 1.0:
	get:
		return Resolution
	set(value):
		Resolution = value
		_update_texture()

@export var sprite_size : float = 1.0:
	get:
		return sprite_size
	set(value):
		sprite_size = value
		_update_texture()

func _update_texture():
	if SVGTexture:
		var image = _rasterize_svg(SVGTexture.svg_data, sprite_size * Resolution, SVGTexture.frames[0])
		var texture = ImageTexture.new()
		texture.set_image(image)
		self.texture = texture
	scale = Vector2(1.0 / Resolution, 1.0 / Resolution)

func _rasterize_svg(data, scale, frameData):
	var image = Image.new()
	image.load_svg_from_string(data, scale)
	frameData *= Vector4(image.get_width(), image.get_height(), image.get_width(), image.get_height())
	var cropped = Image.create(frameData.z, frameData.w, false, image.get_format())
	cropped.blit_rect(image, Rect2i(frameData.x, frameData.y, frameData.z, frameData.w), Vector2(0, 0))
	return cropped
	
