extends Node2D

# set dimensions of the spawn area
const width = 950
const height = 400
const ALIEN = preload("res://Alien.tscn") # gets reference to alien scene

var spawnArea = Rect2()

# Spawn time management:
var spawn_rate = 2
var offset = 0.5

func _ready():
	randomize()
	spawnArea = Rect2(0,0,width,height)
	set_next_spawn()
	
func spawn_alien():
	# assign random x and y coordinates to the spawn point
	var position = Vector2(randi()%950%width, randi()%400%height)
	# spawn the alien into the scene
	var alien = ALIEN.instance()
	alien.position = position
	$"../Aliens".add_child(alien)
	return position

func set_next_spawn():
	# calculate a random offset between -0.5 and 0.5 to add to the spawn rate 
	var nextTime = spawn_rate + (randf()-0.5)*2*offset
	#set the timer's time to the next spawn time and start it
	$Timer.wait_time = nextTime
	$Timer.start()

func _on_timeout():
	spawn_alien()
	set_next_spawn()
	
