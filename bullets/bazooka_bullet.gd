extends Node3D

const SPEED = 200

var WEAPON_DAMAGE

var level = null
var explosion = preload("res://bullets/bazooka_explosion.tscn")
@export var level_path := "/root/Level"

@onready var mesh = $MeshInstance3D
@onready var ray_cast = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_node(level_path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.basis * Vector3(0, 0, -SPEED) * delta


func _on_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	var boom = explosion.instantiate()
	boom.position = position
	level.add_child(boom)
	if area.is_in_group("enemy"):
		area.hit(WEAPON_DAMAGE)
	queue_free()
