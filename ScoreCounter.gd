extends Control

var score = 0
onready var counter = $Label

func _ready():
	Globals.counter = self

func _process(delta):
	counter.text = str(score)

