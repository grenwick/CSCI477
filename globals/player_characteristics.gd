extends Node

var MAX_HEALTH = 3;
var current_health

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset():
	current_health = MAX_HEALTH
		

	
	
