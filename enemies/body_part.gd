extends Area3D

@export var damage_multiplier = 1

signal body_part_hit(damage)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hit(damage):
	var total_damage = damage * damage_multiplier
	emit_signal("body_part_hit", total_damage)
	
