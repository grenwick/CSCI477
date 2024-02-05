extends CharacterBody3D
class_name Player

@onready var camera = $Camera3D
#camera rays for interact / firing
@onready var interact_ray = camera.get_node("InteractRay")
@onready var shoot_ray = camera.get_node("ShootRay")
@onready var shoot_ray_end = camera.get_node("ShootRay/ShootRayEnd")
@onready var shoot_ray2 = camera.get_node("ShootRay2")
@onready var shoot_ray2_end = camera.get_node("ShootRay2/ShootRayEnd2")
@onready var shoot_ray3 = camera.get_node("ShootRay3")
@onready var shoot_ray3_end = camera.get_node("ShootRay3/ShootRayEnd3")
@onready var shoot_ray4 = camera.get_node("ShootRay4")
@onready var shoot_ray4_end = camera.get_node("ShootRay4/ShootRayEnd4")
@onready var shoot_ray5 = camera.get_node("ShootRay5")
@onready var shoot_ray5_end = camera.get_node("ShootRay5/ShootRayEnd5")
@onready var shoot_ray6 = camera.get_node("ShootRay6")
@onready var shoot_ray6_end = camera.get_node("ShootRay6/ShootRayEnd6")
@onready var shoot_ray7 = camera.get_node("ShootRay7")
@onready var shoot_ray7_end = camera.get_node("ShootRay7/ShootRayEnd7")

@onready var shot_spread = [shoot_ray, shoot_ray2, shoot_ray3, shoot_ray4, shoot_ray5, shoot_ray6, shoot_ray7]
@onready var shot_trails = [shoot_ray_end, shoot_ray2_end, shoot_ray3_end, shoot_ray4_end, shoot_ray5_end, shoot_ray6_end, shoot_ray7_end]

const SPEED = 6.5
const JUMP_VELOCITY = 3

var mouseSensibility = 600
var mouse_relative_x = 0
var mouse_relative_y = 0

signal player_hit()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		rotation.x -= event.relative.y / mouseSensibility
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90) )
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)
		
func _process(_delta):
	if PlayerCharacteristics.current_health <= 0:
		handle_death()
	if Input.is_action_just_pressed("primary action") or Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("drop"):
		handle_pickups()
	if Input.is_action_just_pressed("interact"):
		handle_interaction()
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func handle_pickups():
	
	if Input.is_action_just_pressed("interact") and !GlobalVars.held_object:
		if is_instance_of(interact_ray.get_collider(), Pickable):
			GlobalVars.held_object = interact_ray.get_collider()
			GlobalVars.held_object.visible = false
		if GlobalVars.held_object:
			match GlobalVars.held_object.gun_name:
				"Frostbringer":
					$Camera3D/Gun/Frostbringer.visible = true
				"Lyre":
					$Camera3D/Gun/Lyre.visible = true
				"Revolver":
					$Camera3D/Gun/Revolver.visible = true
			
	if Input.is_action_just_pressed("drop") and GlobalVars.held_object:
		GlobalVars.held_object.lock_rotation = true
		GlobalVars.held_object.visible = true
		if is_instance_of(GlobalVars.held_object, Gun):
			match GlobalVars.held_object.gun_name:
				"Frostbringer":
					$Camera3D/Gun/Frostbringer.visible = false
				"Lyre":
					$Camera3D/Gun/Lyre.visible = false
				"Revolver":
					$Camera3D/Gun/Revolver.visible = false
		GlobalVars.held_object.queue_free()
		GlobalVars.held_object = null
		
	if Input.is_action_just_pressed("primary action") and is_instance_of(GlobalVars.held_object, Gun):
		GlobalVars.held_object.shoot(shot_spread, shot_trails, GlobalVars.held_object.name, $Camera3D/Gun/Revolver/Node3D)
	
		
func handle_interaction():
	if is_instance_of(interact_ray.get_collider(), Interactible):
		interact_ray.get_collider().interact()

func hit(damage):
	PlayerCharacteristics.current_health -= damage
	emit_signal("player_hit")

func handle_death():
	#reset game state and start over
	GlobalVars.reset()
	PlayerCharacteristics.reset()
	GameCharacteristics.reset()
	get_tree().reload_current_scene()
	

