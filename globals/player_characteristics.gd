extends Node

var MAX_HEALTH = 3
var current_health
var reload_multiplier = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset():
	current_health = MAX_HEALTH
		

	
	
