extends Control

func _process(delta):
	if Input.is_action_pressed("return"):
		get_tree().change_scene("res://MainMenu.tscn")
