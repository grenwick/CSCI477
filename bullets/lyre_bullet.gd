extends Node3D

const SPEED = 15

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
		queue_free()


func _on_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	if area.is_in_group("enemy"):
		area.hit(WEAPON_DAMAGE)
		queue_free()
