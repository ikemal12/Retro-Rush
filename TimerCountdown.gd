extends Control

# sets default values which I can change in the editor
export (int) var minutes = 0
export (int) var seconds = 0
var dsec = 0

func _physics_process(delta):
	# decrement the seconds value and reset the decisecond value after each second
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	# decrement the minutes value and reset the seconds value after each minute
	if minutes > 0 and seconds <= 0:
		minutes -= 1
		seconds = 60

	# change each minute, second and decisecond label accordingly
	if seconds >= 10:
		$seconds.set_text(str(seconds))
	else:
		$seconds.set_text("0"+str(seconds))
	if dsec >= 10:
		$dsec.set_text(str(dsec))
	else:
		$dsec.set_text("0"+str(dsec))
	if minutes >= 10:
		$minutes.set_text(str(minutes))
	else:
		$minutes.set_text("0"+str(minutes))
		
func _on_Timer_timeout():
	# decrement the decisecond value every decisecond 
	dsec -= 1

