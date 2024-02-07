class_name Gun extends Pickable

@export var bullethole : PackedScene
@export var gun_name : String
@export var gun_barrel : Node3D

var bullet_trail = preload("res://bullets/bullet_trail.tscn")
var instance

var magazine_size
var reserves_size
var current_magazine
var current_reserves

var is_reloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func can_shoot():
	if current_magazine <= 0:
		return false
	return true

func remove_ammo(shots_fired):
	current_magazine -= shots_fired

func reload(reload_speed, reload_multiplier):
	var rounds_to_reload = magazine_size - current_magazine
	if rounds_to_reload > current_reserves :
		rounds_to_reload = current_reserves
	#set state to reloading to prevent firing
	is_reloading = true
	var reload_time = reload_speed / reload_multiplier
	await get_tree().create_timer(reload_time).timeout
	
	current_reserves -= rounds_to_reload
	current_magazine += rounds_to_reload
	#reallow firing
	is_reloading = false
