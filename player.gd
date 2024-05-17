extends Area2D

@export var speed = 400 # how fast can the player move? 
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	#uncomment this when we have a "start game" button
	
func _process(delta):
	var velocity = Vector2.ZERO #set players movement vector to 2d zero to start
	
	#basic player controller
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	#todo: add jump 
	
	#if velocity array is holding an x value and a y value (ie you're moving diagonolly, 
		#normalize it
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "Idle"
		#$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#which animation should we play?	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Run"
		$AnimatedSprite2D.flip_v = false
		#flip on the horizontal axis if we are moving left 
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "Jump"
			
		
