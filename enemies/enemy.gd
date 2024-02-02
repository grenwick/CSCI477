extends CharacterBody3D
class_name Enemy

var current_health

func check_live():
	if current_health > 0:
		return true
	#stupid fix but this project isnt serious lmao
	current_health += 999999
	return false
