extends Node2D

# initialise reference variables
var minutes
var seconds
var dsec

func _ready():
	MenuMusicController.audioplayer.stop()
	var player_health = $Player/HealthUnit
	var health_bar = $HealthBar/ProgressBar
	player_health.connect("changed", health_bar, "set_value")
	player_health.connect("max_changed", health_bar, "set_max")
	#player_health.initialise()
	
	# get the references to their respective labels in the GameTimer scene
	minutes = get_node("GameTimer/Control/minutes")
	seconds = get_node("GameTimer/Control/seconds")
	dsec = get_node("GameTimer/Control/dsec")
	
func _physics_process(delta):
	# once the timer is up, quit the main game scene
	if minutes.text == "00" and seconds.text == "00" and dsec.text == "00":
		#Globals.GameOver.finalscore = Globals.counter.score
		Globals.finalscore = Globals.counter.score
		print(Globals.counter.score)
		get_tree().change_scene("res://GameOver.tscn")
		
