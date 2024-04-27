extends Enemy

var player = null
var level = null
var state_machine
var dead = false
var dead2 = false


var max_ammo = preload("res://pickups/powerups/maxammo.tscn")

const SPEED = 3.25

const ATTACK_RANGE = 2.5
const ATTACK_DAMAGE = 1

const HIT_VALUE = 10
const DEATH_VALUE = 50

@export var player_path := "/root/Level/Player"
@export var level_path := "/root/Level"

@onready var nav_agent = $NavigationAgent3D
@onready var anim_tree = $AnimationTree
@onready var hit_sound = $hit_sound
@onready var zombie_growl = $zombie_growl

func _ready():
	set_physics_process(false)
	current_health = GameCharacteristics.zombie_health
	player = get_node(player_path)
	level = get_node(level_path)
	state_machine = anim_tree.get("parameters/playback")
	
func _process(_delta):
	velocity = Vector3.ZERO
	
	#check if the enemy is alive
	if !check_live() and dead2 == false:
		GameCharacteristics.kills += 1
		GameCharacteristics.killed_zombies_in_round += 1
		GameCharacteristics.current_score += DEATH_VALUE
		GameCharacteristics.total_score += DEATH_VALUE
		GameCharacteristics.check_round_completed()
		anim_tree.set("parameters/conditions/dead", true)
		dead2 = true
		
	
	match state_machine.get_current_node():
		"crawl":
			#find player
			nav_agent.set_target_position(player.global_transform.origin)
			var next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			var target_vector = Vector3(global_position.x + velocity.x, global_position.y, global_position.z + velocity.z)
			if !global_transform.origin.is_equal_approx(target_vector):
				look_at(target_vector, Vector3.UP)
		"attack":
			#look at player
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			#chance to growl (1 in 2, assuming 60 frames)
			if randi() % 120 == 0:
				zombie_growl.play()
		"die":
			if dead == false:
				if randi() % 100 == 0:
					var lootbox = max_ammo.instantiate()
					lootbox.position = position
					level.add_child(lootbox)
				dead = true
			#if hp < 0, wait a few seconds and despawn zombie
			disable_collisions()
			await get_tree().create_timer(3.5).timeout
			queue_free()
		"stand":
			pass
	
	#conditions for different anims
	anim_tree.set("parameters/conditions/attack", target_in_range())
	
	#anim_tree.get("parameters/playback")
	move_and_slide()
	
func target_in_range():
	return global_position.distance_to(player.global_position) < ATTACK_RANGE

func _on_area_3d_body_part_hit(damage):
	hit_sound.play()
	current_health -= damage
	GameCharacteristics.current_score += HIT_VALUE
	GameCharacteristics.total_score += HIT_VALUE
		
	
func hit_player():
	if global_position.distance_to(player.global_position) < ATTACK_RANGE:
		player.hit(ATTACK_DAMAGE)
		
func disable_collisions():
	$Armature/Skeleton3D/Head/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/Torso/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftBicep/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightBicep/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftForearm/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightForearm/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftQuad/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftCalf/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightCalf/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightFoot/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftFoot/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightQuad/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/RightHand/Area3D/CollisionShape3D.disabled = true
	$Armature/Skeleton3D/LeftHand/Area3D/CollisionShape3D.disabled = true
	$CollisionShape3D.disabled = true

func kill(damage):
	hit_sound.play()
	current_health = 0
	GameCharacteristics.current_score += HIT_VALUE
	GameCharacteristics.total_score += HIT_VALUE
	
