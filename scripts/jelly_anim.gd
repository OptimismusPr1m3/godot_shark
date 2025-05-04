extends MovableObject

@onready var animJelly = $AnimatedSprite2D
@onready var jellyArea = $Area2D

var speed = 1.0

func _ready() -> void:
	add_to_group('enemies_j')
	animJelly.animation_finished.connect(onHit)

func _physics_process(_delta: float) -> void:
	if !isDead && !was_hit:
		animJelly.play("swim_lila")
		velocity.x = -100 * speed
	elif was_hit && !isDead:
		animJelly.play("dead_lila")
		velocity.x = 0
	move_and_slide()

func onHit():
	if animJelly.animation == "dead_lila":
		if dieAnimationCount < 2:
			dieAnimationCount+= 1
		elif dieAnimationCount >= 2:
			isDead = true
			queue_free()
