extends Area2D

var bubbleSpeed = 1.0
var direction: int

func setDirection(direct: int):
	direction = direct

func _physics_process(delta: float) -> void:
	move_local_x(direction * 9)
	
