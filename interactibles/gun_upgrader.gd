extends Interactible

signal upgrade_weapon

var UPGRADE_COST_L1 = 2500
var UPGRADE_COST_L2 = 10000
var UPGRADE_COST_L3 = 25000

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
					if GameCharacteristics.current_score >= UPGRADE_COST_L1:
						GameCharacteristics.current_score -= UPGRADE_COST_L1
						emit_signal("upgrade_weapon")
				1:
					if GameCharacteristics.current_score >= UPGRADE_COST_L2:
						GameCharacteristics.current_score -= UPGRADE_COST_L2
						emit_signal("upgrade_weapon")
				2:
					if GameCharacteristics.current_score >= UPGRADE_COST_L3:
						GameCharacteristics.current_score -= UPGRADE_COST_L3
						emit_signal("upgrade_weapon")
				_:
					pass
