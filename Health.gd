extends Node

# set variables for the maximum and current amount of health
# the 'setget' is used here to encapsulate the variables within their respective methods
export(int) var max_amount = 10 setget set_max
onready var current = max_amount setget set_current 

# initialise signals for changing the values and when the health reaches 0
signal max_changed(new_max)
signal changed(new_amount)
signal depleted

func _ready():
	_initialise()

func set_max(new_max):
	max_amount = new_max
	# set the maximum to the new max and emit a signal
	max_amount = max(1, new_max)
	emit_signal("max_changed", max_amount)
	
func set_current(new_value):
	current = new_value
	# change the current value whilst ensuring it does not exceed the maximum
	current = clamp(current, 0 , max_amount)
	emit_signal("changed", current)
	
	if current == 0:
		emit_signal("depleted")
		
func _initialise():
	# set the default values at the start
	emit_signal("max_changed", max_amount)
	emit_signal("changed", current)
