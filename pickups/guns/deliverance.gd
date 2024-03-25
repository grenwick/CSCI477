extends Gun

const icon = "res://pixel_sprites/ui/item_icons/frostbringer_icon.png"

var bullet = load("res://bullets/revolver_bullet.tscn")
var bullet_inst

var WEAPON_DAMAGE = 150000


# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Delivernac"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")
	magazine_size = 600
	reserves_size = 22000
	current_magazine = magazine_size
	current_reserves = reserves_size

func shoot(shot_spread, shot_trails, gun_barrel):
	if !can_shoot():
		return
	
	remove_ammo(1)
	bullet_inst = bullet.instantiate()
	bullet_inst.WEAPON_DAMAGE = WEAPON_DAMAGE
	bullet_inst.position = gun_barrel.global_position
	bullet_inst.transform.basis = shot_spread[0].global_transform.basis
	
	get_parent().add_child(bullet_inst)
