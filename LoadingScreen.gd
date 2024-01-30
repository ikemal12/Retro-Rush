extends Node2D

var load_time = 10  # set the time it takes to fill up the loading bar
onready var tween = $Tween  # create a link to the tween node in the scene

# on opening the loading screen, this function sets the bar fill to 0 and then starts fillin it up
func _ready():
	tween.interpolate_property($LoadingBar, "value", 0,100 , load_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	
# once the bar is full, the screen will change scene to the game
func _on_Tween_tween_all_completed():
	get_tree().change_scene("res://CountdownScreen.tscn")
	
