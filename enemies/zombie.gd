extends CharacterBody3D

var player = null

const SPEED = 4.0
const ATTACK_RANGE = 2.5

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree
func _ready():
	player = get_node(player_path)
	
func _process(delta):
	velocity = Vector3.ZERO
	
	#find player
	nav_agent.set_target_position(player.global_transform.origin)
	var next_nav_point = nav_agent.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	
	#look at player
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	#conditions for different anims
	anim_tree.set("parameters/conditions/attack", target_in_range())
	anim_tree.set("parameters/conditions/run", !target_in_range())
	move_and_slide()
	
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE
