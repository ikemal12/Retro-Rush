extends Area2D

# called when the coin enters the scene 
func _ready():
	var lifespan = get_tree().create_timer(10) # initiates the timer
	lifespan.connect("timeout", self, "queue_free") # deletes the coin once the timer is up

# runs every frame so the animation is on loop
func _process(delta):
	$AnimationPlayer.play("idle")

func _on_Coin_body_entered(body):
	# if the player touches the coin, it is removed from the scene
	if body.is_in_group("player"):
		AudioStreamManager.play("res://Sound effects/collectcoin-6075.mp3") # pickup sound effect
		# adds 10 points to the score counter
		Globals.counter.score += (10 * Globals.pointsMultiplier)
		queue_free()
