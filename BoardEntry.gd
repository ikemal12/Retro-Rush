extends HBoxContainer

# set placeholders for the label texts
var player_name = "Bob"
var player_score = "00000"

# get references to label nodes
onready var name_label = $NameLabel
onready var score_label = $ScoreLabel

# writes the name and score retrieved from the server to the labels
func update_labels():
	name_label.text = "%s" % player_name
	score_label.text = "%s" % player_score

# updates the leaderboard at the start of the scene
func _ready():
	update_labels()
