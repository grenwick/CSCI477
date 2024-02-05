extends Control

var fps

# Called when the node enters the scene tree for the first time.
func _ready():
	update_health(PlayerCharacteristics.current_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_score()
	if(GlobalVars.held_object):
		$CurrentItem/CurrentItem.texture = load(GlobalVars.held_object.icon)
	else:
		$CurrentItem/CurrentItem.texture = null
	update_health(PlayerCharacteristics.current_health)
	update_round()
	update_kill_checker()
	update_ammo()

func _on_fps_update_timer_timeout():
	fps = Engine.get_frames_per_second()
	$FPSCounter/Label.text = str(fps)
	
func update_health(health):
	$HealthSymbol/Label.text = str(health)
	
func update_score():
	$Score/Label.text = str(GameCharacteristics.current_score)
	
func update_ammo():
	if GlobalVars.held_object:
		if is_instance_of(GlobalVars.held_object, Gun):
			$Ammo/Magazine.text = str(GlobalVars.held_object.current_magazine)
			$Ammo/Magazine/Reserves.text = str(GlobalVars.held_object.current_reserves)
			return
	$Ammo/Magazine.text = ""
	$Ammo/Magazine/Reserves.text = ""

func update_round():
	$RoundCounter/Label.text = str(GameCharacteristics.current_round)
	
func update_kill_checker():
	$KillCounter/Label.text = str(str(GameCharacteristics.killed_zombies_in_round) + "/" + str(GameCharacteristics.max_zombies_in_round))

func flash_red():
	$DamageSplash.visible = true
	await get_tree().create_timer(.15).timeout
	$DamageSplash.visible = false
