extends ParallaxBackground

var camera: Camera2D

func _ready():
	# Initialize and update the scroll offset based on camera position
	_update_scroll_offset()

func _update_scroll_offset():
	if camera:
		self.scroll_offset.x = camera.position.x

func _process(delta):
	_update_scroll_offset()
