extends Control

var finalscore 
onready var score_label = $Score
onready var high_score_label = $HighScore

func _process(delta):
	if Input.is_action_pressed("continue"):
		get_tree().change_scene("res://CountdownScreen.tscn")
	if Input.is_action_pressed("return"):
		get_tree().change_scene("res://MainMenu.tscn")
	
func _ready():
	Globals.GameOver = self
	MenuMusicController.audioplayer.play()
	finalscore = Globals.finalscore
	score_label.text = str("Your score was ",finalscore,"!")
	# update the highscore if the final game score is greater than it
	if finalscore > Globals.highscore:
		Globals.highscore = finalscore
		Globals.HighScore.set_highscore(finalscore)
		print(Globals.highscore)
		# set the labels accordingly
		high_score_label.text = str("Your high score is ",Globals.highscore,"!")
	else:
		high_score_label.text = str("Your high score is ",Globals.highscore,"!")


#func submit_new_highscore():
#	# instantiate information to be passed into the request function
#	var url = "https://api.lootlocker.io/game/leaderboards/11971/submit"
#	var header = ["Content-Type: application/json", "x-session-token: %s" % Lootlocker.token]
#	var method = HTTPClient.METHOD_POST
#	# use a dictionary to store each record's fields
#	var request_data = {
#		"score" : Score.high_score,
#		"member_id" : Lootlocker.player_id,
#		"metadata" : line_edit.text
#	}
#	# make the request
#	http_request.request(url, header, false, method, to_json(request_data))
#	# wait until it has been completed
#	yield(http_request, "request_completed")

# references the input text and the HTTP request node
#onready var line_edit = $UsernameInput/NinePatchRect/Username
#onready var http_request = $HighscoreHTTPRequest
