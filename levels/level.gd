extends Node3D

@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var zombie = load("res://enemies/better_zombie.tscn")
var zombie_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI.update_health($Player/PlayerCharacteristics.current_health)
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$UI.update_health($Player/PlayerCharacteristics.current_health)

func get_random_child(parent):
	var random_id = randi() % parent.get_child_count()
	return parent.get_child(random_id)

func _on_spawn_timer_timeout():
	var spawn_point = get_random_child(spawns).global_position
	
	#spawn zombies up until the max enemy count is reached
	if navigation_region.get_child_count() < 12:
		zombie_instance = zombie.instantiate()
		zombie_instance.position = spawn_point
		navigation_region.add_child(zombie_instance)
		
	
func _on_player_player_hit():
	$UI.flash_red()
