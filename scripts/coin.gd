extends Area2D

#emit a signal when collected
signal coin_collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	#play idlle animation
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "Idle"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().call_group("Player", "_on_coin_collected")
		hide()
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(0.2).timeout
		queue_free()
