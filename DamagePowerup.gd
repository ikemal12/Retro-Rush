# inherits the base class
extends Powerups

func applyPowerup():
	# checks if the bullet instance is in the scene before increasing the damage
	if is_instance_valid(Globals.bullet):
		print("bullet access")
		#Globals.bullet.damage = 100
		Globals.player.damageMultiplier = 3
