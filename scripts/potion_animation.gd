extends Area2D

@onready var shark = $'../Sharkie'

func _ready() -> void:
	var potion = $AnimatedSprite2D
	potion.play("potion_blinking")

	self.body_entered.connect(_onPickUp)
	


func _onPickUp(body: Node2D):
	print('Potion collected from: ', body)
	shark.potions += 10
	queue_free()
