extends Control

var fps

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(GlobalVars.held_object):
		$AspectRatioContainer3/CurrentItem.texture = load(GlobalVars.held_object.icon)
	else:
		$AspectRatioContainer3/CurrentItem.texture = null
	


func _on_fps_update_timer_timeout():
	fps = Engine.get_frames_per_second()
	$AspectRatioContainer4/Label.text = str(fps)
	
func update_health(health):
	$AspectRatioContainer/Label.text = str(health)

func flash_red():
	$DamageSplash.visible = true
	await get_tree().create_timer(.15).timeout
	$DamageSplash.visible = false
