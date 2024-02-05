extends Gun

const icon = "res://pixel_sprites/ui/item_icons/lyre_icon.png"

var bullet = load("res://bullets/lyre_bullet.tscn")
var bullet_instance

var WEAPON_DAMAGE = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_name = "Lyre"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(shot_spread, shot_trails, gun_name, gun_barrel):
	while Input.is_action_pressed("primary action"):
		bullet_instance = bullet.instantiate()
		bullet_instance.WEAPON_DAMAGE = WEAPON_DAMAGE
		bullet_instance.position = gun_barrel.global_position
		bullet_instance.transform.basis = shot_spread[0].global_transform.basis
				
		get_parent().add_child(bullet_instance)
		await get_tree().create_timer(.15).timeout
