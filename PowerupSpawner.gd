extends Node2D

const width = 950
const height = 400
var spawnArea = Rect2()
const SPEEDPOWERUP = preload("res://SpeedPowerup.tscn") # gets reference to powerup class

# set the time range that a powerup can spawn within
var spawn_range = 90
var offset = 2

# called when the powerup enters the scene
func _ready():
	randomize()
	spawnArea = Rect2(0,0,width,height)
	set_next_spawn()
	var lifespan = get_tree().create_timer(15) # initiates the timer
	lifespan.connect("timeout", self, "queue_free") #deletes the powerup once the timer is up
	
func spawn_powerup():
	# assign random x and y coordinates to the spawn point
	var position = Vector2(randi()%950%width, randi()%400%height)
	# spawn the powerup into the scene
	var speed_powerup = SPEEDPOWERUP.instance()
	speed_powerup.position = position
	$"../Powerups".add_child(speed_powerup)
	return position
	
func set_next_spawn():
	# calculate a random offset between -2.0 and 2.0 to add to the spawn rate 
	var nextTime = randi()%spawn_range + (randf()-2.0)*2*offset
	#set the timer's time to the next spawn time and start it
	$Timer.wait_time = nextTime
	$Timer.start()

func _on_Timer_timeout():
	spawn_powerup()
	set_next_spawn()
	
