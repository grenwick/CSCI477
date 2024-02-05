extends Interactible

signal make_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact():
	if GameCharacteristics.current_score >= 950:
		GameCharacteristics.current_score -= 950
		emit_signal("make_weapon")
