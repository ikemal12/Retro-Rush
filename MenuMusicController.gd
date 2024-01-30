extends Node

var menu_music = load("res://Audio/through space.ogg")
onready var audioplayer = $MenuMusic

func _ready():
	play_music()

func play_music():
	$MenuMusic.stream = menu_music
	$MenuMusic.play()

