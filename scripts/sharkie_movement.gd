extends MovableObject

@onready var animShark = $AnimatedSprite2D
@onready var areaShark = $Area2D
@onready var pBubble = preload("res://scenes/p_bubble.tscn")
@onready var wBubble = preload("res://scenes/w_bubble.tscn")

var direction = Vector2()
var bubbleOffset_x: int = 110
var pBubbleLaunched = false
var wBubbleLaunched = false

func _ready() -> void:
	add_to_group('player')
	animShark.animation_finished.connect(_on_animation_finished)
	areaShark.body_entered.connect(_onEnemyHit)
	movementSpeed = 5.0

func _physics_process(_delta: float) -> void:
	direction.x = Input.get_axis("ui_left", "ui_right") # -1 wenn left, 1 wenn rechts -- 0 wenn keines von Beiden oder Beide gleichzeitig
	direction.y = Input.get_axis("ui_up", "ui_down") # -1 wenn up, 1 wenn down -- 0 wenn keines von Beiden oder Beide gleichzeitig 
	
	moveChar(direction, animShark, 'swim', 'idle')
	spawnBubble()
	move_and_slide()
	setBubbleLaunch()

func spawnBubble():
	if Input.is_action_just_pressed("ui_select") && !hasLaunched && !isColliding:
		hasLaunched = true
		animShark.play("green_bubble")
	if Input.is_action_just_pressed("g") && !hasLaunched && !isColliding:
		hasLaunched = true
		animShark.play("white_bubble")

func _onEnemyHit(body:Node2D):
	#print('Enemy has collided: ', body)
	if body.is_in_group('enemies_p') || body.is_in_group('enemies_j'):
		isColliding = true
		hit(10, animShark, "poisoned_hurt")
		print('Coins:', coins)

func getDirection():
	if !animShark.flip_h:
		return 1
	else:
		return -1

func setBubbleLaunch():
	if pBubbleLaunched && !wBubbleLaunched:
		launchBubble('green')
	elif !pBubbleLaunched && wBubbleLaunched:
		launchBubble('white')

func launchBubble(color: String):
	var direction = getDirection()
	var bubble
	if  color == 'green':
		bubble = pBubble.instantiate()
	elif color == 'white':
		bubble = wBubble.instantiate()
	bubble.setDirection(direction)
	print('Die DIrection ist: ', direction)
	bubble.global_position.y = global_position.y + 40
	bubble.global_position.x = global_position.x + (bubbleOffset_x * direction)
	print ('Hier die globale Position der Bubble: ',bubble.global_position.x)
	get_parent().add_child(bubble)
	pBubbleLaunched = false
	wBubbleLaunched = false


func _on_animation_finished():
	if animShark.animation == 'poisoned_hurt':
		was_hit = false
		isColliding = false
		hasSlapped = false
		hasLaunched = false
	if animShark.animation == 'green_bubble':
		hasSlapped = false
		hasLaunched = false
		pBubbleLaunched = true
	if animShark.animation == 'white_bubble':
		hasSlapped = false
		hasLaunched = false
		wBubbleLaunched = true
		
		
	
