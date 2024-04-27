extends Node3D

var WEAPON_DAMAGE
var alpha = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alpha -= delta * 6
	$MeshInstance3D.mesh.material.albedo_color.a = alpha
	var bodies = $Area3D.get_overlapping_bodies()
	for i in bodies:
		if i.is_in_group("enemy"):
			i.hit(WEAPON_DAMAGE)
	


func _on_timer_timeout():
	queue_free()




func _on_area_3d_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit(WEAPON_DAMAGE)


