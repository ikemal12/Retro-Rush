extends Control

func _on_Username_text_entered(new_text):
	if new_text.length() >= 2:
		get_tree().change_scene("res://LoadingScreen.tscn")
	
# runs this function every frame - 'delta' is the time elapsed from the previous frame
func _process(delta):
	#if focus_entered() == false:
		if Input.is_action_pressed("return"):  
			get_tree().change_scene("res://MainMenu.tscn") # changes scene to the menu 
		
