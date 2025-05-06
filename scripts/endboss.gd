extends MovableObject


@onready var animBoss = $AnimatedSprite2D
@onready var player = get_tree().get_first_node_in_group('player')
var hasSpawned = false
var aggroDistance = 500
var isSpawning = false

func _ready() -> void:
	add_to_group('boss')
	animBoss.animation_finished.connect(_onAnimFinished)

func _physics_process(delta: float) -> void:
	calculatePlayerDistance()
	if hasSpawned && !was_hit && !isAttacking:
		print('Nun gespawnt !')
		animBoss.play('idle')

func _onAnimFinished():
	if animBoss.animation == 'spawning':
		hasSpawned = true


func calculatePlayerDistance():
	if player && !hasSpawned && !isSpawning:
		var distanceToPlayer = global_position.distance_to(player.global_position)
		var isInRange = distanceToPlayer < aggroDistance
		if isInRange && !hasSpawned:
			animBoss.play('spawning')
			isSpawning = true
