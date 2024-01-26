extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GlobalVars.held_object):
		$AspectRatioContainer3/CurrentItem.texture = load(GlobalVars.held_object.icon)
	else:
		$AspectRatioContainer3/CurrentItem.texture = null
