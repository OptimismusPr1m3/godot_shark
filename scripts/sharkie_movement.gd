extends CharacterBody2D

@onready var animShark = $AnimatedSprite2D
@onready var areaShark = $Area2D

var sharkSpeed = 5.0
var was_hit = false
var health = 100

func _ready() -> void:
	add_to_group('player')
	animShark.animation_finished.connect(_on_animation_finished)
	areaShark.body_entered.connect(_onEnemyHit)


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right") # -1 wenn left, 1 wenn rechts -- 0 wenn keines von Beiden oder Beide gleichzeitig
	direction.y = Input.get_axis("ui_up", "ui_down") # -1 wenn up, 1 wenn down -- 0 wenn keines von Beiden oder Beide gleichzeitig 
	
	if direction != Vector2.ZERO:
		velocity = direction * 100 * sharkSpeed
		if !was_hit:
			animShark.play('swim')
		if direction.x != 0:
			animShark.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		if !was_hit:
			animShark.play("idle")
		
	move_and_slide()


func _onEnemyHit(body:Node2D):
	print('Enemy has collided: ', body)
	if body.is_in_group('enemies'):
		hit(10)
		print('Lebenspunkte: ',health)

func hit(damage: int):
	print('Got dmg: ', damage)
	health -= damage
	was_hit = true
	animShark.play("poisoned_hurt")
	

func _on_animation_finished():
	if animShark.animation == 'poisoned_hurt':
		was_hit = false
