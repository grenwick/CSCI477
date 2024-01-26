extends CharacterBody3D
class_name Enemy

const MAX_HEALTH = 100
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var current_health

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	current_health = MAX_HEALTH
	
func _process(delta):
	if current_health <= 0:
		queue_free()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

func hit_gun():
	current_health -= 20
