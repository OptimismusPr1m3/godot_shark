class_name Throwable extends Area2D

var bubbleSpeed = 1.0
var direction: int
var travelDistance = 600
var startpoint = 0

func _process(_delta: float):
	calculateBubbleTravel()

func calculateBubbleTravel():
	var distance = global_position.x - startpoint
	if distance >= travelDistance:
		queue_free()
