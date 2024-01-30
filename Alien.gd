extends KinematicBody2D

var target : Node2D
var speed := 80   # sets a speed value slightly less than the player's
onready var health_unit := $HealthUnit # creates a reference to the HealthUnit scene 
signal died() # create a signal for when the alien dies
onready var animation = $AnimationPlayer # create a reference
var is_touching 
var direction = Vector2()

var attack_damage = 10
var attack_cooldown_time = 1500
var next_attack_time = 0

var path: Array = []  # contains destination positions
var MapNavigation: Navigation2D = null  # references tilemap
var player = null

onready var line2D = $Line2D

func _ready():
	target = Globals.player# gets a reference to the player in the game scene
	
	yield(get_tree(), "idle_frame") # waits a frame for the game scene to be instanced
	var tree = get_tree() # gets reference to main game scene 
	if tree.has_group("MapNavigation"):
		# returns an array of nodes from the scene
		MapNavigation = tree.get_nodes_in_group("MapNavigation")[0]
	if tree.has_group("player"):
		player = tree.get_nodes_in_group("player")[0]
		
func navigate():   # defines the next position to go to 
	if path.size() > 0:
		# calculates the velocity based on the next point on the path
		direction = global_position.direction_to(path[1]) * speed
		# once we reach the next point, delete it from the path
		if global_position == path[0]:
			path.pop_front()
	
func generate_path():
	if MapNavigation != null and player != null:
		# gets the path between the alien and the player
		path = MapNavigation.get_simple_path(global_position, player.global_position, false)
		
func _physics_process(delta):
	if player and MapNavigation:
		generate_path()
		navigate()
	animation.play("running")
	if is_instance_valid(target):
		look_at(target.position)
#		direction = (target.global_position - global_position).normalized() * speed 
		move_and_slide(direction)  # get a direction vector to the player and move the alien in that direction
		
	# turn raycast2D towards movement direction
		if direction != Vector2.ZERO:
			$RayCast2D.cast_to = direction.normalized() * 24

func _process(delta):
	var now = OS.get_ticks_msec()
	if now >= next_attack_time:
		var target = $RayCast2D.get_collider()
		if target != null and target.name == "Player" and Globals.player.health_unit.health > 0:
			animation.play("attack")
			next_attack_time = now + attack_cooldown_time

func _on_Sprite_frame_changed():
	if $Sprite.frame == 3:
		var target = $RayCast2D.get_collider()
	if target != null and target.name == "Player" and Globals.player.health > 0:
			Globals.player.health_unit.emit_signal("take_damage", attack_damage)

func collision_detection():
	# checks every frame the alien is moving to see if it has collided with an object
	for index in get_slide_count():
		var collision = get_slide_collision(index) 
		# make sure the player is in the scene
		if is_instance_valid(target):
			# make sure the collision object is the player
			if collision.collider.is_in_group("player"):
				$Area2D/CollisionShape2D.set_deferred("Disabled", false)
				$Area2D/CollisionShape2D.disabled = false
				print("collision")
				animation.play("attack")
				Globals.player.health_unit.emit_signal("take_damage",10)
				break 
			else:
				$Area2D/CollisionShape2D.set_deferred("Disabled", true)
				$Area2D/CollisionShape2D.disabled = true
				
func alien_attack():
	# checks that the player and alien are colliding
	if is_touching and health_unit in Globals.player:
		print("collision")
		$Area2D/CollisionShape2D.set_deferred("Disabled", false)
		$Area2D/CollisionShape2D.disabled = false
		animation.play("attack")
		# takes damage from the player's health
		Globals.player.health_unit.emit_signal("take_damage",10)
	
func _on_Area2D_body_entered(body):
		print("body entered")
		is_touching = true
#		for index in get_slide_count():
#			var collision = get_slide_collision(index) # gets the instance of the collision
		if body.is_in_group("player") and is_touching:
			print("attack")
			alien_attack()  # if the timer is not running, then attack
			set_next_attack()
		else:
			pass # if the object is not the player, ignore it

func _on_Area2D_body_exited(body):
	is_touching = false

func set_next_attack():
	# set a wait time of one second
	var nextAttack = 1
	$Timer.wait_time = nextAttack
	# loop the timer
	$Timer.start()

func _on_Timer_timeout():
	alien_attack()
#
func _on_HealthUnit_take_damage(amount):
	if health_unit.health <= 0:
		emit_signal("died")   # if the alien's health reaches 0, a signal is sent

func _on_Alien_died():
	Globals.counter.score += (18 * Globals.pointsMultiplier)
	AudioStreamManager.play("res://Sound effects/mixkit-creature-cry-of-hurt-2208.wav")
	queue_free() # removes the alien from the game scene once it dies
