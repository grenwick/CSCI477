extends Gun

const icon = "res://pixel_sprites/ui/item_icons/revolver_icon.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Revolver"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):
		#make bullet trail, either it collides with object, or shoot it into space
		instance = bullet_trail.instantiate()
		if shot_spread[0].is_colliding():
			if shot_spread[0].get_collider().is_in_group("enemy"):
				shot_spread[0].get_collider().hit(20)
			else:
				var bulletInst = bullethole.instantiate() as Node3D
				bulletInst.set_as_top_level(true)
				get_parent().add_child(bulletInst)
				bulletInst.global_transform.origin = shot_spread[0].get_collision_point() as Vector3
			instance.init(gun_barrel.global_position, shot_spread[0].get_collision_point())
		else:
			instance.init(gun_barrel.global_position, shot_trails[0].global_position)
		get_parent().add_child(instance)
