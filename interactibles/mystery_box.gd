extends Interactible

signal make_weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact():
	if GameCharacteristics.score >= 950:
		GameCharacteristics.score -= 950
		generate_weapon()
	else:
		print("broke boi lmao")
		
func generate_weapon():
	emit_signal("make_weapon")
	
	
	
	
