extends CharacterBody2D

@onready var animShark = $AnimatedSprite2D
#@onready var coin = $"../Coin"

var sharkSpeed = 5.0


func _physics_process(_delta: float) -> void:
	if (Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_left") || 
	Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_right") || 
	Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_right") || 
	Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_left")):
		manageVerticalMovement()
	elif (Input.is_action_pressed("ui_down") || 
	Input.is_action_pressed("ui_up") || 
	Input.is_action_pressed("ui_right") || 
	Input.is_action_pressed("ui_left")):
		manageMovement()
	else:
		animShark.play("idle")
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	

func manageVerticalMovement():
	if Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_left"):
		animShark.play("swim")
		velocity.y = 100 * sharkSpeed
		velocity.x = -100 * sharkSpeed
		animShark.flip_h = true
	elif Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_right"):
		animShark.play("swim")
		velocity.y = 100 * sharkSpeed
		velocity.x = 100 * sharkSpeed
		animShark.flip_h = false
	elif Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_right"):
		animShark.play("swim")
		velocity.y = -100 * sharkSpeed
		velocity.x = 100 * sharkSpeed
		animShark.flip_h = false
	elif Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_left"):
		animShark.play("swim")
		velocity.y = -100 * sharkSpeed
		velocity.x = -100 * sharkSpeed
		animShark.flip_h = true

func manageMovement():
	if Input.is_action_pressed("ui_down"):
		animShark.play("swim")
		velocity.y = 100 * sharkSpeed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		animShark.play("swim")
		velocity.y = -100 * sharkSpeed
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		animShark.play("swim")
		velocity.x = 100 * sharkSpeed
		animShark.flip_h = false
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		animShark.play("swim")
		velocity.x = -100 * sharkSpeed
		animShark.flip_h = true
		velocity.y = 0
	
