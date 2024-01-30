extends Node2D

# set dimensions of the spawn area
const width = 950
const height = 400
const COIN = preload("res://Coin.tscn") # gets reference to coin scene
var coins = []
var spawnArea = Rect2()

# Spawn time management:
var spawn_rate = 1
var offset = 0.25

func _ready():
	randomize()
	spawnArea = Rect2(0,0,width,height)
	set_next_spawn()
	
func spawn_coin():
	# assign random x and y coordinates to the spawn point
	var position = Vector2(randi()%950%width, randi()%400%height)
	# spawn the coin into the scene
	var coin = COIN.instance()
	coins.append(coin) # add the instance of the coin to the array
	coin.position = position
	$"../Coins".add_child(coin)
	return position
	
func set_next_spawn():
	# calculate a random offset between -0.25 and 0.25 to add to the spawn rate 
	var nextTime = spawn_rate + (randf()-0.25)*2*offset
	#set the timer's time to the next spawn time and start it
	$Timer.wait_time = nextTime
	$Timer.start()

func _on_timeout():
	spawn_coin()
	set_next_spawn()
