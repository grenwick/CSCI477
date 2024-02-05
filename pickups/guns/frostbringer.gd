extends Gun

const icon = "res://pixel_sprites/ui/item_icons/frostbringer_icon.png"

var WEAPON_DAMAGE = 150


# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Frostbringer"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):
	#handle the charge mechanic
	var charge_time = 0
	while Input.is_action_pressed("primary action"):
		if charge_time > .74:
			break
		await get_tree().create_timer(.01).timeout
		if Input.is_action_just_released("primary action"):
			return
		else:
			charge_time += .0175
			
	#if charge satisfied, fire burst
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
		await get_tree().create_timer(.001).timeout
