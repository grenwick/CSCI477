extends Node

const DEFAULT_ROUND = 1
const DEFAULT_SCORE = 0
var current_round
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	current_round = DEFAULT_ROUND
	score = DEFAULT_SCORE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset():
	current_round = DEFAULT_ROUND
	score = DEFAULT_SCORE
