class_name Gun extends Pickable

@export var bullethole : PackedScene
@export var gun_name : String
@export var gun_barrel : Node3D

var bullet_trail = preload("res://bullets/bullet_trail.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):

	if gun_name == "Frostbringer":
		var bullet_array = [bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate()]
		var increment = 0
		for i in bullet_array:
			i.set_as_top_level(true)
			get_parent().add_child(i)
			
			#make bullet trail, either it collides with object, or shoot it into space
			instance = bullet_trail.instantiate()
			if shot_spread[increment].is_colliding():
				if shot_spread[increment].get_collider().is_in_group("enemy"):
					shot_spread[increment].get_collider().hit(20)
				instance.init(gun_barrel.global_position, shot_spread[increment].get_collision_point())
			else:
				instance.init(gun_barrel.global_position, shot_trails[increment].global_position)
			get_parent().add_child(instance)
			
			i.global_transform.origin = shot_spread[increment].get_collision_point() as Vector3
			increment += 1
			
	if gun_name == "Lyre":
		var bulletInst = bullethole.instantiate() as Node3D
		bulletInst.set_as_top_level(true)
		get_parent().add_child(bulletInst)
		
		#make bullet trail, either it collides with object, or shoot it into space
		instance = bullet_trail.instantiate()
		if shot_spread[0].is_colliding():
			if shot_spread[0].get_collider().is_in_group("enemy"):
					shot_spread[0].get_collider().hit(20)
			instance.init(gun_barrel.global_position, shot_spread[0].get_collision_point())
		else:
			instance.init(gun_barrel.global_position, shot_trails[0].global_position)
		get_parent().add_child(instance)
		bulletInst.global_transform.origin = shot_spread[0].get_collision_point() as Vector3
		
	if gun_name == "Revolver":
		var bulletInst = bullethole.instantiate() as Node3D
		bulletInst.set_as_top_level(true)
		get_parent().add_child(bulletInst)
		
		#make bullet trail, either it collides with object, or shoot it into space
		instance = bullet_trail.instantiate()
		if shot_spread[0].is_colliding():
			if shot_spread[0].get_collider().is_in_group("enemy"):
				shot_spread[0].get_collider().hit(20)
			instance.init(gun_barrel.global_position, shot_spread[0].get_collision_point())
		else:
			instance.init(gun_barrel.global_position, shot_trails[0].global_position)
		get_parent().add_child(instance)
		bulletInst.global_transform.origin = shot_spread[0].get_collision_point() as Vector3
	
