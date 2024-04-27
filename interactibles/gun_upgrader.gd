extends Interactible

signal upgrade_weapon

@onready var upgrade_audio = $upgrade_audio

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func interact():
	if GlobalVars.held_object:
		if is_instance_of(GlobalVars.held_object, Gun):
			match GlobalVars.held_object.weapon_level:
				0:
					if GameCharacteristics.current_score >= GameCharacteristics.upgrade_cost_l1:
						GameCharacteristics.current_score -= GameCharacteristics.upgrade_cost_l1
						emit_signal("upgrade_weapon")
						upgrade_audio.play()
				1:
					if GameCharacteristics.current_score >= GameCharacteristics.upgrade_cost_l2:
						GameCharacteristics.current_score -= GameCharacteristics.upgrade_cost_l2
						emit_signal("upgrade_weapon")
						upgrade_audio.play()
				2:
					if GameCharacteristics.current_score >= GameCharacteristics.upgrade_cost_l3:
						GameCharacteristics.current_score -= GameCharacteristics.upgrade_cost_l3
						emit_signal("upgrade_weapon")
						upgrade_audio.play()
				_:
					pass
