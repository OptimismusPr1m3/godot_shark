extends Area2D

@onready var shark = $'../Sharkie'

func _ready() -> void:
	var coin = $AnimatedSprite2D
	coin.play("coin_blinking")

	body_entered.connect(_onPickUp)
	


func _onPickUp(body: Node2D):
	print('Coin collected from: ', body)
	shark.coins += 10
	queue_free()
