extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group('player')
@onready var puff = $AnimatedSprite2D

var puffSpeed = 1.0
var aggroDistance = 420
var isAggro = false
var isAggroTrans = false

func _ready() -> void:
	add_to_group('enemies')
	puff.animation_finished.connect(_aggroTransition)
	print(player)


func _physics_process(delta: float) -> void:
	if !isAggro && !isAggroTrans:
		puff.play("swim")
		velocity.x = -100 * puffSpeed
	elif isAggroTrans:
		puff.play("aggro_trans")
		velocity.x = -100 * puffSpeed
	elif isAggro && !isAggroTrans:
		puff.play("aggro_swim")
		velocity.x = -100 * puffSpeed
	calcDistanceToPlayer()
	move_and_slide()

func _aggroTransition():
	if puff.animation == 'aggro_trans':
		isAggroTrans = false
		isAggro = true
		puff.play("aggro_swim")
		puffSpeed = 2.0

func calcDistanceToPlayer():
	if player:
		var distanceToPlayer = global_position.distance_to(player.global_position)
		var isInAggroRange = distanceToPlayer < aggroDistance
		if isInAggroRange && !isAggroTrans && !isAggro:
			isAggroTrans = true
			puff.play("aggro_trans")
			puffSpeed = 0.5
