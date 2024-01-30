class_name Powerups # set up a base class
extends Area2D

# initialise a function for the functionality of each powerup
func applyPowerup():
	# this needs to be implemented by the inheriting class
	pass

# when the player picks up a powerup, apply it then delete it from the scene
func _on_Powerups_body_entered(body):
	if body.is_in_group("player"):
		AudioStreamManager.play("res://Sound effects/Video-Game-Positive-Sound-A1-8bit-www.fesliyanstudios.com.mp3")
		applyPowerup()
		queue_free()

