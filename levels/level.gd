extends Node3D

@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var zombie = load("res://enemies/better_zombie.tscn")
var zombie_instance

var frostbringer = preload("res://pickups/guns/frostbringer.tscn")
var revolver = preload("res://pickups/guns/revolver.tscn")
var lyre = preload("res://pickups/guns/lyre.tscn")
var ak47 = preload("res://pickups/guns/ak_47.tscn")

var weapons = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	weapons = [lyre, frostbringer, ak47]
	var starting_gun = revolver.instantiate()
	add_child(starting_gun)
	#spaghetti ass code
	$Player/Camera3D/Gun/Revolver.visible = true
	GlobalVars.held_object = starting_gun


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func get_random_child(parent):
	var random_id = randi() % parent.get_child_count()
	return parent.get_child(random_id)

func _on_spawn_timer_timeout():
	var spawn_point = get_random_child(spawns).global_position
	
	#spawn zombies up until the max enemy count is reached
	if navigation_region.get_child_count() < 12 and GameCharacteristics.spawned_zombies_in_round < GameCharacteristics.max_zombies_in_round:
		zombie_instance = zombie.instantiate()
		GameCharacteristics.spawned_zombies_in_round += 1
		zombie_instance.position = spawn_point
		navigation_region.add_child(zombie_instance)

	
func _on_player_player_hit():
	$UI.flash_red()

func generate_weapon():
	var random_weapon = randi() % weapons.size()
	var new_weapon = weapons[random_weapon].instantiate()
	add_child(new_weapon)
	return new_weapon
	
func _on_mystery_box_make_weapon():
	var generated_weapon = generate_weapon()
	generated_weapon.position = $MysteryBox.position
	generated_weapon.position.y += 1
	
func _on_mystery_box_2_make_weapon():
	var generated_weapon = generate_weapon()
	generated_weapon.position = $MysteryBox2.position
	generated_weapon.position.y += 1
	

func upgrade_weapon():
	GlobalVars.held_object.weapon_level += 1
	GlobalVars.held_object.WEAPON_DAMAGE *= 2.25
	GlobalVars.held_object.magazine_size *= 1.5
	GlobalVars.held_object.magazine_size = int(GlobalVars.held_object.magazine_size)
	GlobalVars.held_object.reserves_size *= 1.5
	GlobalVars.held_object.reserves_size = int(GlobalVars.held_object.reserves_size)
	GlobalVars.held_object.current_magazine = GlobalVars.held_object.magazine_size
	GlobalVars.held_object.current_reserves = GlobalVars.held_object.reserves_size
	

func _on_gun_upgrader_upgrade_weapon():
	upgrade_weapon()
	


func _on_player_player_dead():
	#puase game, hide level, and show stats
	get_tree().paused = true
	$UI.hide()
	visible = false
	$DeathScreen.show_stats()
	
	#spaghetti ass code, waits for space to be pressed
	while(true):
		if Input.is_action_pressed("jump"):
			break
		await get_tree().create_timer(.01).timeout
		
	#reset stats and level
	GlobalVars.reset()
	PlayerCharacteristics.reset()
	GameCharacteristics.reset()
	
	#unpause and switch back to main menu
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://ui/title_screen.tscn")
