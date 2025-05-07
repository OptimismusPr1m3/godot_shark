extends CanvasLayer

@onready var health = $health
@onready var coins = $coins
@onready var potion = $potion
@onready var player = get_tree().get_first_node_in_group('player')

func _process(delta: float) -> void:
	checkBars('health')
	checkBars('coins')
	checkBars('potion')

func checkBars(bar: String) -> void:
	if bar == 'health':
		if player.health > 80:
			health.set_frame_and_progress(0, 1)
		elif player.health >= 60 && player.health < 80:
			health.set_frame_and_progress(1, 1)
		elif player.health >= 40 && player.health < 60:
			health.set_frame_and_progress(2, 1) 
		elif player.health >= 20 && player.health < 40:
			health.set_frame_and_progress(3, 1)
		elif player.health > 0 && player.health < 20:
			health.set_frame_and_progress(4, 1)
		elif player.health == 0:
			health.set_frame_and_progress(5, 1)
	if bar == 'coins':
		if player.coins > 80:
			coins.set_frame_and_progress(0, 1)
		elif player.coins >= 60 && player.coins < 80:
			coins.set_frame_and_progress(1, 1)
		elif player.coins >= 40 && player.coins < 60:
			coins.set_frame_and_progress(2, 1) 
		elif player.coins >= 20 && player.coins < 40:
			coins.set_frame_and_progress(3, 1)
		elif player.coins > 0 && player.coins < 20:
			coins.set_frame_and_progress(4, 1)
		elif player.coins == 0:
			coins.set_frame_and_progress(5, 1)
	if bar == 'potion':
		if player.potions > 80:
			potion.set_frame_and_progress(0, 1)
		elif player.potions >= 60 && player.potions < 80:
			potion.set_frame_and_progress(1, 1)
		elif player.potions >= 40 && player.potions < 60:
			potion.set_frame_and_progress(2, 1) 
		elif player.potions >= 20 && player.potions < 40:
			potion.set_frame_and_progress(3, 1)
		elif player.potions > 0 && player.potions < 20:
			potion.set_frame_and_progress(4, 1)
		elif player.potions == 0:
			potion.set_frame_and_progress(5, 1)
