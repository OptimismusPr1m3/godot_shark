extends CharacterBody2D

@onready var animShark = $AnimatedSprite2D
#@onready var coin = $"../Coin"

var sharkSpeed = 5.0
var was_hit = false

func _ready() -> void:
	add_to_group('player')
	animShark.animation_finished.connect(_on_animation_finished)


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
	manageCollision()


func manageCollision():
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		#var collider = collision.get_collider()
		if collider.is_in_group('enemies'):
			hit(10)

func hit(damage: int):
	print('Got dmg: ', damage)
	was_hit = true
	animShark.play("poisoned_hurt")
	

func _on_animation_finished():
	if animShark.animation == 'poisoned_hurt':
		was_hit = false
