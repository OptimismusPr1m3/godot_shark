extends AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		move_local_x(delta)
		play("swim")
