extends Button

@onready var btn = $Button

func _process(delta: float) -> void:
	if button_pressed:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		

func _exit_tree() -> void:
	queue_free()
