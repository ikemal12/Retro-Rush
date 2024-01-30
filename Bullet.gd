extends RigidBody2D

var explosion = preload("res://Explosion.tscn") # creates reference to the animation
export (int) var damage = 50

func _ready():
	Globals.bullet = self

func _on_Bullet_body_entered(body): 
	# runs whenever the bullet collides with an object
	if !body.is_in_group("player"): # makes sure the collision object is not the player
		if "health_unit" in body:
			body.health_unit.emit_signal("take_damage", damage)
		
		var explosion_instance = explosion.instance() # creates an instance of the animation
		explosion_instance.position = get_global_position() # sets the position of the animation
		# to play wherever the bullet is at that time
		get_tree().get_root().add_child(explosion_instance) # adds the instance to the game scene
		queue_free()  # removes the bullet from the scene
		

