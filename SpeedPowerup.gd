# inherits the base class
extends Powerups

func applyPowerup():
	Globals.player.speed = 300 # boost the speed of the player
	print(Globals.player.speed) # debug
	
func _on_Timer_timeout():
	# when the timer is up, return the player's speed back to normal
	Globals.player.speed = 200
	print(Globals.player.speed) # debug 
	
func _on_timer_timeout():
	# when the timer is up, return the player's speed back to normal
	Globals.player.speed = 200

func _process(delta):
	print($Timer.time_left) # debug
	
func _on_SpeedBoostTimer_timeout():
	Globals.player.speed = 200
	print(Globals.player.speed) # debug

