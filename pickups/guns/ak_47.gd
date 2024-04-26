extends Gun

const icon = "res://pixel_sprites/ui/item_icons/ak47_icon.png"

var bullet = load("res://bullets/revolver_bullet.tscn")
var bullet_instance

var WEAPON_DAMAGE = 130


# Called when the node enters the scene tree for the first time.
func _ready():
	gunshot_sound = $gunshot
	reload_sound = $reload
	gun_name = "AK-47"
	gun_barrel = $Node3D
	bullethole = load("res://bullets/bullethole.tscn")
	magazine_size = 30
	reserves_size = 240
	current_magazine = magazine_size
	current_reserves = reserves_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot(shot_spread, _shot_trails, gun_barrel):
	if !can_shoot():
		return
		
	while Input.is_action_pressed("primary action"):
		if !can_shoot():
			return
		gunshot_sound.play()
		remove_ammo(1)
		bullet_instance = bullet.instantiate()
		bullet_instance.WEAPON_DAMAGE = WEAPON_DAMAGE
		bullet_instance.position = gun_barrel.global_position
		bullet_instance.transform.basis = shot_spread[0].global_transform.basis
				
		get_parent().add_child(bullet_instance)
		await get_tree().create_timer(.15).timeout
