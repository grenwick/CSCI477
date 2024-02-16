extends Node

const DEFAULT_ROUND = 1
const DEFAULT_SCORE = 5000
const DEFAULT_ZOMBIE_HEALTH = 150
const DEFAULT_MAX_ZOMBIES_IN_ROUND = 6

var current_round
var current_score
var total_score

var kills
var precision_kills

var max_zombies_in_round
var zombie_health
var killed_zombies_in_round
var spawned_zombies_in_round

var upgrade_cost_l1 = 2500
var upgrade_cost_l2 = 10000
var upgrade_cost_l3 = 25000


# Called when the node enters the scene tree for the first time.
func _ready():
	current_round = DEFAULT_ROUND
	current_score = DEFAULT_SCORE
	zombie_health = DEFAULT_ZOMBIE_HEALTH
	max_zombies_in_round = DEFAULT_MAX_ZOMBIES_IN_ROUND
	spawned_zombies_in_round = 0
	killed_zombies_in_round = 0
	total_score = 0
	kills = 0
	precision_kills = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func reset():
	current_round = DEFAULT_ROUND
	current_score = DEFAULT_SCORE
	zombie_health = DEFAULT_ZOMBIE_HEALTH
	max_zombies_in_round = DEFAULT_MAX_ZOMBIES_IN_ROUND
	spawned_zombies_in_round = 0
	killed_zombies_in_round = 0
	total_score = 0
	kills = 0
	precision_kills = 0
	
func update_zombie_health():
	if current_round < 10:
		zombie_health += 100
	else:
		zombie_health *= 1.1
		
func update_zombies_per_round():
	max_zombies_in_round *= 1.15
	max_zombies_in_round = round(max_zombies_in_round)
	
func check_round_completed():
	if killed_zombies_in_round >= max_zombies_in_round:
		current_round += 1
		update_zombie_health()
		update_zombies_per_round()
		spawned_zombies_in_round = 0
		killed_zombies_in_round = 0
	else:
		pass
