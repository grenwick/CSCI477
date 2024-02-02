extends Gun

const icon = "res://pixel_sprites/ui/item_icons/frostbringer_icon.png"

var WEAPON_DAMAGE = 75


# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Frostbringer"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):
		var bullet_array = [bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate(), bullethole.instantiate()]
		var increment = 0
		for i in bullet_array:
			#make bullet trail, either it collides with object, or shoot it into space
			instance = bullet_trail.instantiate()
			if shot_spread[increment].is_colliding():
				if shot_spread[increment].get_collider().is_in_group("enemy"):
					shot_spread[increment].get_collider().hit(WEAPON_DAMAGE)
				else:
					i.set_as_top_level(true)
					get_parent().add_child(i)
					i.global_transform.origin = shot_spread[increment].get_collision_point() as Vector3
				instance.init(gun_barrel.global_position, shot_spread[increment].get_collision_point())
			else:
				instance.init(gun_barrel.global_position, shot_trails[increment].global_position)
			get_parent().add_child(instance)
			
			
			increment += 1
