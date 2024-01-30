extends Control

# set the starting value
var seconds = 5

# start the timer on entry into the scene
func _ready():
	MenuMusicController.audioplayer.stop()
	$Timer.start()

func _on_Timer_timeout():
# when the timer is done, check if the countdown is on 1. If so change the text to 'GO!'
# and then start the end game timer
	var time = 1
	if $Seconds.text == "1":
		$Timer.stop()
		$Seconds.set_text("") # make the seconds label empty
		$Go.set_text("GO!") # add the 'GO!' text to the offset label
		$EndGameTimer.wait_time = time
		$EndGameTimer.start()
	else:
		pass

	# otherwise decrement the number and change the label's text to it
	if !seconds == 1:
		seconds -= 1
		$Seconds.set_text(str(seconds))
		$Timer.start()

func _on_EndGameTimer_timeout():
	get_tree().change_scene("res://MainGame.tscn")
	
