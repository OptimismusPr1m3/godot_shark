extends Throwable

func _ready() -> void:
	add_to_group('w_bubbles')
	self.body_entered.connect(checkEnemyCollision)
	startpoint = global_position.x

func setDirection(direct: int):
	direction = direct

func _physics_process(_delta: float):
	move_local_x(direction * 9)

func checkEnemyCollision(body: Node2D):
	if body.is_in_group('enemies_j'):
		print('Jelly hit')
		body.movementSpeed = 0.0
		body.was_hit = true
		queue_free()
