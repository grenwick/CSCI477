class_name Pickable extends Node3D

@export var is_highlighted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func handle_highlight():
	if is_highlighted:
		$HighlightBox.highlight_bool = true
	else:
		$HighlightBox.highlight_bool = false
