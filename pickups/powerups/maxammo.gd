extends RigidBody3D

@onready var pickup_sound

# Called when the node enters the scene tree for the first time.
func _ready():
	$DestroyTimer.connect("timeout", _on_destroy_timer_timeout)
	pickup_sound = $maxammo_pickup


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	##if(player position is within collision shape) {destroy this instance, refill player ammo and reserves}
	#var player_position = Player.global_position #grab player position
	#var collision_shape = $CollisionShape3D #grab the max ammo's collision shape
	##compare them
	pass

func _on_destroy_timer_timeout():
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		pickup_sound.play()
		visible = false
		GlobalVars.held_object.current_reserves = GlobalVars.held_object.reserves_size
		$DestroyTimer.start()
