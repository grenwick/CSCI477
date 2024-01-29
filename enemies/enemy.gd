extends CharacterBody3D
class_name Enemy

var current_health

func check_live():
	if current_health > 0:
		return true
	return false
