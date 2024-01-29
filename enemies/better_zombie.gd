extends Enemy

var player = null
var state_machine

const ATTACK_RANGE = 2.5

@export var player_path := "/root/Level/Player"

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree

func _ready():
	set_physics_process(false)
	SPEED = 4.0
	MAX_HEALTH = 100
	current_health = MAX_HEALTH
	player = get_node(player_path)
	state_machine = anim_tree.get("parameters/playback")
	
func _process(delta):
	velocity = Vector3.ZERO
	
	#check if the enemy is alive
	anim_tree.set("parameters/conditions/dead", !check_live())
	
	match state_machine.get_current_node():
		"crawl":
			#find player
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			if !global_transform.origin.is_equal_approx(velocity / SPEED):
				look_at(Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z), Vector3.UP)
		"attack":
			#look at player
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		"die":
			#if hp < 0, wait a few seconds and despawn zombie
			$CollisionShape3D.disabled = true
			await get_tree().create_timer(3.5).timeout
			queue_free()
		"stand":
			pass
	
	#conditions for different anims
	anim_tree.set("parameters/conditions/attack", target_in_range())
	anim_tree.set("parameters/conditions/run", !target_in_range())
	
	#anim_tree.get("parameters/playback")
	move_and_slide()
	
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE


