extends Control

# reference the BoardEntry scene so it can be instanced when needed
export (PackedScene) var board_entry_scene 

onready var player_list = $ScrollContainer/PlayersList
onready var http_request = $LeaderboardHTTPRequest
	
func _process(delta):
	if Input.is_action_pressed("return"):
		get_tree().change_scene("res://MainMenu.tscn")
		
#func _ready():
#	# wait for the leaderboard data to be retrieved from the server
#	yield(http_request.get_board(), "completed")
#	# go through each row in the leaderboard and write its contents to an instance of the 
#	# BoardEntry scene
#	for i in http_request.board:
#		var entry = board_entry_scene.instance()
#		entry.player_name = i['metadata']
#		entry.player_score = i['score']
#		# add the row to the leaderboard screen
#		player_list.add_child(entry)
	
	
