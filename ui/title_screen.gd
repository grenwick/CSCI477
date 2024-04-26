extends Node2D

@onready var music = $music

# Called when the node enters the scene tree for the first time.
func _ready():
	var playButton = $PlayButton
	var popup = playButton.get_popup()
	popup.id_pressed.connect(play_level_select)
	music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_button_pressed():
	$SettingsButton.visible = false
	$QuitButton.visible = false


func _on_quit_button_pressed():
	get_tree().quit()

func play_level_select(id):
	match id:
		0:
			get_tree().change_scene_to_file("res://levels/level.tscn")
		1:
			get_tree().change_scene_to_file("res://levels/JailMap.tscn")
		_:
			print("How tf did you get here")
	
