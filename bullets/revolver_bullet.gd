extends Node3D

const SPEED = 90

var WEAPON_DAMAGE

@onready var mesh = $MeshInstance3D
@onready var ray_cast = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray_cast.is_colliding():
		mesh.visible = false
		if ray_cast.get_collider().is_in_group("enemy"):
			ray_cast.get_collider().hit(WEAPON_DAMAGE)
		queue_free()
		


func _on_timer_timeout():
	queue_free()