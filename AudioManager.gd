extends Node

var num_players = 8
var bus = "master"
var available = []  # the available players
var queue = []  # the queue of sounds to play

func _ready():
	# create the pool of AudioStreamPlayer nodes
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p) # instance an audio player globally
		available.append(p)  # add to the available array
		p.connect("finished", self, "_on_stream_finished", [p]) 
		p.bus = bus

func _on_stream_finished(stream):
	# when finished playing a stream, make the player available again
	available.append(stream)

func play(sound_path):
	queue.append(sound_path) # add the sound to the queue

func _process(delta):
	# play a queued sound if any players are available
	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front() # remove stream from the queue
