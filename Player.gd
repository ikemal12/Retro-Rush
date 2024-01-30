extends KinematicBody2D

export var speed = 200  # set speed to an arbitrary value
var velocity = Vector2() # holds the direction of the player's movement
onready var animation = $AnimationPlayer # creates reference to the animation node
onready var health_unit := $HealthUnit # creates a reference to the HealthUnit scene 
onready var timer = $Timer
signal died() # create a signal for when the player dies

var bullet = preload("res://Bullet.tscn") # links the bullet scene
export var bullet_speed = 1000 # set an arbitrary speed
export var fire_rate = 0.2 
var can_fire = true 
var damageMultiplier = 1

func _ready():
	Globals.player = self
	
# everything in this function is executed repeatedly every frame
func _physics_process(delta):
	velocity = Vector2()
	
# checks if a movement key is pressed and moves the player accordingly
# if the player is moving, play the running animation
	if Input.is_action_pressed("down"):
		animation.play("running")
		velocity.y += speed
	if Input.is_action_pressed("up"):
		animation.play("running")
		velocity.y -= speed
	if Input.is_action_pressed("left"):
		animation.play("running")
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		animation.play("running")
		velocity.x += speed
	if velocity.length() == 0:  # if the player is not moving, then play 'idle'
		animation.play("idle")  
		
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)  # move the player in the direction of the pressed key
	look_at(get_global_mouse_position()) # rotates the player sprite to where the cursor 
	# is pointing 
	
	if Input.is_action_pressed("shoot") and can_fire:
		$AudioStreamPlayer2D.play()
		var bullet_instance = bullet.instance() # creates an instance of a bullet
		bullet_instance.position = $BulletPoint.get_global_position()  # sets the initial position of the bullet
		# to the position of the player at that instant in time
		bullet_instance.rotation_degrees = rotation_degrees # makes sure the bullet is facing the same way
		# as the player 
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		# this creates a force which projects the bullet from the player at a constance rate
		get_tree().get_root().add_child(bullet_instance) # adds bullet instance to the scene
		
		Globals.bullet.damage *= damageMultiplier
		can_fire = false 
		yield(get_tree().create_timer(fire_rate), "timeout") # creates delay between shots
		can_fire = true 
		$AudioStreamPlayer2D.stop()

func _on_HealthUnit_take_damage(amount):
	if health_unit.health <= 0:
		emit_signal("died") 

func _on_Player_died():
	queue_free()
	
