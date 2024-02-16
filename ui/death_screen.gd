extends Control

var rounds_survived = 0
var score = 0
var kills = 0
var headshots = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_stats():
	rounds_survived = GameCharacteristics.current_round
	score = GameCharacteristics.total_score
	kills = GameCharacteristics.kills
	headshots = GameCharacteristics.precision_kills
	$RoundsSurvived/Label.text = "Rounds Survived: " + str(rounds_survived)
	$RoundsSurvived/Label.text += "\nScore: " + str(score)
	$RoundsSurvived/Label.text += "\nKills: " + str(kills)
	$RoundsSurvived/Label.text += "\nHeadshots: " + str(headshots)
	$RoundsSurvived/Label.text += "\n\nPress Space to Continue"
	
func show_stats():
	update_stats()
	visible = true
