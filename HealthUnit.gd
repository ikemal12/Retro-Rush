extends Node

signal take_damage(amount)  # created a signal which is emitted when taking damage
export(int) var health := 100  # set the health value 
 
func _ready():
	connect("take_damage", self, "_on_take_damage") # connects the signal to its class
	
func _on_take_damage(amount):
	health -= amount  # decrements the health by a fixed amount each time a bullet collides
	if health <= 0:
		health = 0 # make sure the health does not become negative
