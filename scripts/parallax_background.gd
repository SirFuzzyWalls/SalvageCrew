extends ParallaxBackground

var camera: Camera2D

func _ready():
	# Scale sprites to match viewport size
	_scale_sprites_to_viewport()
	
func _scale_sprites_to_viewport():
	var viewport_size = get_viewport().get_visible_rect().size
	for layer in get_children():
		if  layer is ParallaxLayer:
			for sprite in layer.get_children():
				if sprite is Sprite2D:
					var texture_size = sprite.texture.get_size()
					var scale_x = viewport_size.x / texture_size.x
					var scale_y = viewport_size.y / texture_size.y
					sprite.scale = Vector2(scale_x, scale_y)

func _process(delta):
	if camera:
		self.scroll_offset.x = camera.position.x
