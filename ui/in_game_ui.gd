extends Control

var fps

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update_score()
	if(GlobalVars.held_object):
		$CurrentItem/CurrentItem.texture = load(GlobalVars.held_object.icon)
	else:
		$CurrentItem/CurrentItem.texture = null
	


func _on_fps_update_timer_timeout():
	fps = Engine.get_frames_per_second()
	$FPSCounter/Label.text = str(fps)
	
func update_health(health):
	$HealthSymbol/Label.text = str(health)
	
func update_score():
	$Score/Label.text = str(GameCharacteristics.current_score)

func update_round():
	$RoundCounter/Label.text = str(GameCharacteristics.current_round)
	
func update_kill_checker():
	$"Kill Counter/Label".text = str(str(GameCharacteristics.killed_zombies_in_round) + "/" + str(GameCharacteristics.max_zombies_in_round))

func flash_red():
	$DamageSplash.visible = true
	await get_tree().create_timer(.15).timeout
	$DamageSplash.visible = false
