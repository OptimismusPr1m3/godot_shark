extends MovableObject

@onready var animBoss = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group('player')
var hasSpawned = false
var aggroDistance = 800
var isSpawning = false

func _ready() -> void:
	add_to_group('boss')
	animBoss.animation_finished.connect(_onAnimFinished)

func _process(delta: float) -> void:
	checkHealth()

func _physics_process(delta: float) -> void:
	calculatePlayerDistance()
	#print('Bosshealth is: ',health)
	if hasSpawned && !was_hit && !isAttacking && !isDead:
		animBoss.play('idle')
		moveToPlayer()
	if isAttacking && !was_hit && !isDead:
		animBoss.play('attacking')
		velocity = Vector2.ZERO
	if was_hit && !isAttacking && !isDead:
		animBoss.play('hurt')
		velocity = Vector2.ZERO
	if isDead:
		animBoss.play("dead")

func _onAnimFinished():
	if animBoss.animation == 'spawning':
		hasSpawned = true
	if animBoss.animation == 'attacking':
		isAttacking = false
	if animBoss.animation == 'hurt':
		health -= 40
		was_hit = false
	if animBoss.animation == 'dead':
		queue_free()

func moveToPlayer():
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * 100
	if direction.x > 0:
		animBoss.flip_h = true
	else:
		animBoss.flip_h = false
	move_and_slide()

func calculatePlayerDistance():
	if player && !hasSpawned && !isSpawning:
		var distanceToPlayer = global_position.distance_to(player.global_position)
		var isInRange = distanceToPlayer < aggroDistance
		if isInRange && !hasSpawned:
			animBoss.play('spawning')
			isSpawning = true
			
