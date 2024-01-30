extends Node3D

class_name PlayerManager

var MAX_HEALTH = 3;
var current_health

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_health <= 0:
		handle_death()
		
func handle_death():
	GlobalVars.reset()
	get_tree().reload_current_scene()
	
func get_health():
	return current_health
	
