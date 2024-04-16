extends Gun

const icon = "res://pixel_sprites/ui/item_icons/Watergun_icon.png"

var WEAPON_DAMAGE = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Water Gun"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")
	magazine_size = 50
	reserves_size = 300
	current_magazine = magazine_size
	current_reserves = reserves_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#func shoot(shot_spread, _shot_trails, gun_barrel):
	#if !can_shoot():
		#return
		#
	#while Input.is_action_pressed("primary action"):
		#if !can_shoot():
			#return
		#remove_ammo(1)
		#bullet_instance = bullet.instantiate()
		#bullet_instance.WEAPON_DAMAGE = WEAPON_DAMAGE
		#bullet_instance.position = gun_barrel.global_position
		#bullet_instance.transform.basis = shot_spread[0].global_transform.basis
				#
		#get_parent().add_child(bullet_instance)
		#await get_tree().create_timer(.15).timeout

func shoot(shot_spread, shot_trails, gun_barrel):
	if !can_shoot():
		return
		
	#if charge satisfied, fire burst
	remove_ammo(1)
	var bullet_array = [bullethole.instantiate()]
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
		await get_tree().create_timer(.001).timeout
