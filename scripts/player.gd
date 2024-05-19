extends CharacterBody2D

@export var speed = 475 # how fast can the player move? 
@export var gravity = 30 # how much gravity affects the player?
@export var jump_force = 500 
var screen_size
var score = 0
func _ready():
	screen_size = get_viewport_rect().size
	#connect to the global coin signal
	add_to_group("Player")
	#hide()
	#uncomment this when we have a "start game" button
	
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	#jump
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force
	#basic player controller
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	
	move_and_slide()
	update_animation(horizontal_direction)
	
func update_animation(horizontal_direction):
	$AnimatedSprite2D.play()
	if is_on_floor():
		if horizontal_direction == 0:
			$AnimatedSprite2D.animation = "Idle"
		else:
			$AnimatedSprite2D.animation = "Run"
			$AnimatedSprite2D.flip_v = false
			#flip on the horizontal axis if we are moving left 
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else: 
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "Jump"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y == 0:
			$AnimatedSprite2D.animation = "JumpToFall"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "Fall"
			$AnimatedSprite2D.flip_h = velocity.x < 0

func _on_coin_collected():
	score += 100
	print("Score: ", score)
