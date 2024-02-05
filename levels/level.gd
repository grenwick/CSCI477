extends Node3D

@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var zombie = load("res://enemies/better_zombie.tscn")
var zombie_instance

var frostbringer = preload("res://pickups/guns/frostbringer.tscn")
var revolver = preload("res://pickups/guns/revolver.tscn")
var lyre = preload("res://pickups/guns/lyre.tscn")

var weapons = []


# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.update_health(PlayerCharacteristics.current_health)
	randomize()
	weapons = [lyre, frostbringer, revolver]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$UI.update_health(PlayerCharacteristics.current_health)
	$UI.update_round()
	$UI.update_kill_checker()
	if GlobalVars.held_object:
		if is_instance_of(GlobalVars.held_object, Gun):
			$UI.update_ammo()
	

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
	

