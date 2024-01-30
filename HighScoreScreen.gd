extends Control

onready var label = $HighScore

func _ready():
	label.text = str(Globals.highscore)
	
func _process(delta):
	if Input.is_action_pressed("return"):
		get_tree().change_scene("res://MainMenu.tscn")
