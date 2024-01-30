extends Node2D

func _on_Play_Button_pressed():
	AudioStreamManager.play("res://Sound effects/el_interface_button_22_hpx.wav")
	get_tree().change_scene("res://UsernameInputScreen.tscn")
	
func _on_Exit_Button_pressed():
	AudioStreamManager.play("res://Sound effects/el_interface_button_22_hpx.wav")
	get_tree().quit()

func _on_Leaderboard_Button_pressed():
	AudioStreamManager.play("res://Sound effects/el_interface_button_22_hpx.wav")
	get_tree().change_scene("res://HighScoreScreen.tscn")
	
func _on_Controls_Button_pressed():
	AudioStreamManager.play("res://Sound effects/el_interface_button_22_hpx.wav")
	get_tree().change_scene("res://ControlsScreen.tscn")
	
