extends CharacterBody3D
class_name Enemy

var MAX_HEALTH = 100
var SPEED = 5.0
var JUMP_VELOCITY = 4.5

var current_health

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")



func hit_gun():
	current_health -= 20

func check_live():
	if current_health >= 0:
		return true
	return false
