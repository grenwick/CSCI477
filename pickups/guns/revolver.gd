extends Gun

const icon = "res://pixel_sprites/ui/item_icons/revolver_icon.png"

var bullet = load("res://bullets/revolver_bullet.tscn")
var bullet_instance

var WEAPON_DAMAGE = 125

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Revolver"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):
	bullet_instance = bullet.instantiate()
	bullet_instance.WEAPON_DAMAGE = WEAPON_DAMAGE
	bullet_instance.position = gun_barrel.global_position
	bullet_instance.transform.basis = shot_spread[0].global_transform.basis
	if shot_spread[0].is_colliding:
		if !shot_spread[0].get_collider().is_in_group("enemy"):
			var hole_instance = bullethole.instantiate() as Node3D
			hole_instance.global_transform.origin = shot_spread[0].get_collision_point()
			get_parent().add_child(hole_instance)
			
	get_parent().add_child(bullet_instance)
