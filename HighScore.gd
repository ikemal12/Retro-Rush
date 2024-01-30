extends Node

var highscore = 0 setget set_highscore
const filepath = "user://highscore.data" # creates a file in the user directory

func _ready():
	Globals.HighScore = self
	load_highscore()

func load_highscore():
	# reads the contents of the file and stores it in highscore
	var file = File.new()
	if not file.file_exists(filepath): return
	file.open(filepath, File.READ)
	highscore = file.get_var()
	Globals.highscore = highscore
	file.close()
	
func save_highscore():
	# writes highscore to the file
	var file = File.new()
	file.open(filepath, File.WRITE)
	file.store_var(highscore)
	Globals.highscore = highscore
	file.close()
	
func set_highscore(new_value):
	# update the highscore value
	highscore = new_value
	Globals.highscore = highscore
	save_highscore()
	
