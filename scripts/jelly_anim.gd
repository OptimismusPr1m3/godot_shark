extends CharacterBody2D

@onready var animJelly = $AnimatedSprite2D

var isDead = false
var speed = 1.0

func _ready() -> void:
	add_to_group('enemies')

func _physics_process(delta: float) -> void:
	if !isDead:
		animJelly.play("swim_lila")
		velocity.x = -100 * speed
	move_and_slide()
